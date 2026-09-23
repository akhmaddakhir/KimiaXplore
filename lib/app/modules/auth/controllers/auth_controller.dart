import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import '../../../services/profile_service.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isFormValid = false.obs;
  final isLoginFormValid = false.obs;
  final isLoading = false.obs;
  final isGoogleLoading = false.obs;

  final AuthService _authService = AuthService();
  final ProfileService _profileService = ProfileService();

  StreamSubscription<AuthState>? _authSubscription;

  bool _waitingForGoogleAuth = false;

  Map<String, String> get onboardingAnswers {
    final arguments = Get.arguments;

    if (arguments is Map<String, String>) {
      return arguments;
    }

    if (arguments is Map) {
      return arguments.map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      );
    }

    return {};
  }

  @override
  void onInit() {
    super.onInit();

    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
    confirmPasswordController.addListener(validateForm);

    emailController.addListener(validateLoginForm);
    passwordController.addListener(validateLoginForm);

    _authSubscription = _authService.authStateChanges.listen(
      _handleAuthStateChange,
    );
  }

  Future<void> _handleAuthStateChange(AuthState state) async {
    if (!_waitingForGoogleAuth) {
      return;
    }

    if (state.event != AuthChangeEvent.signedIn) {
      return;
    }

    final user = state.session?.user;

    if (user == null) {
      return;
    }

    _waitingForGoogleAuth = false;

    await _finishGoogleLogin(user);
  }

  Future<void> _finishGoogleLogin(User user) async {
    try {
      isGoogleLoading.value = true;

      await _profileService.ensureProfile(
        userId: user.id,
        email: user.email ?? '',
        onboardingAnswers: onboardingAnswers,
      );

      Get.offAllNamed(AppRoutes.home);
    } on PostgrestException catch (error) {
      _showError('Profil gagal dibuat', error.message);
    } catch (_) {
      _showError(
        'Login Google gagal',
        'Terjadi kesalahan setelah login Google.',
      );
    } finally {
      isGoogleLoading.value = false;
    }
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Email wajib diisi';
    }

    if (!GetUtils.isEmail(email)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  String? validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Sandi wajib diisi';
    }

    if (password.length < 6) {
      return 'Sandi minimal 6 karakter';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    final confirmPassword = value ?? '';

    if (confirmPassword.isEmpty) {
      return 'Konfirmasi sandi wajib diisi';
    }

    if (confirmPassword != passwordController.text) {
      return 'Konfirmasi sandi tidak cocok';
    }

    return null;
  }

  void validateForm() {
    final isEmailValid = validateEmail(emailController.text) == null;

    final isPasswordValid = validatePassword(passwordController.text) == null;

    final isConfirmPasswordValid =
        validateConfirmPassword(confirmPasswordController.text) == null;

    isFormValid.value =
        isEmailValid && isPasswordValid && isConfirmPasswordValid;
  }

  void validateLoginForm() {
    final isEmailValid = validateEmail(emailController.text) == null;

    final isPasswordValid = validatePassword(passwordController.text) == null;

    isLoginFormValid.value = isEmailValid && isPasswordValid;
  }

  Future<void> register() async {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid || isLoading.value) {
      return;
    }

    validateForm();

    if (!isFormValid.value) {
      return;
    }

    try {
      isLoading.value = true;

      final response = await _authService.register(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final user = response.user;

      if (user == null) {
        _showError('Registrasi gagal', 'Akun tidak berhasil dibuat.');

        return;
      }

      await _profileService.ensureProfile(
        userId: user.id,
        email: user.email ?? emailController.text.trim(),
        onboardingAnswers: onboardingAnswers,
      );

      Get.offAllNamed(AppRoutes.home);
    } on AuthException catch (error) {
      _showError('Registrasi gagal', error.message);
    } on PostgrestException catch (error) {
      _showError('Profil gagal dibuat', error.message);
    } catch (_) {
      _showError('Registrasi gagal', 'Terjadi kesalahan. Coba lagi.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    final isValid =
        (loginFormKey.currentState ?? formKey.currentState)?.validate() ??
        false;

    if (!isValid || isLoading.value) {
      return;
    }

    validateLoginForm();

    if (!isLoginFormValid.value) {
      return;
    }

    try {
      isLoading.value = true;

      final response = await _authService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      final user = response.user;

      if (user == null) {
        _showError('Login gagal', 'Akun tidak ditemukan.');

        return;
      }

      await _profileService.ensureProfile(
        userId: user.id,
        email: user.email ?? emailController.text.trim(),
      );

      Get.offAllNamed(AppRoutes.home);
    } on AuthException catch (error) {
      _showError('Login gagal', error.message);
    } on PostgrestException catch (error) {
      _showError('Profil gagal dimuat', error.message);
    } catch (_) {
      _showError('Login gagal', 'Terjadi kesalahan. Coba lagi.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    if (isGoogleLoading.value) {
      return;
    }

    try {
      isGoogleLoading.value = true;

      _waitingForGoogleAuth = !_authService.usesNativeGoogleSignIn;

      final response = await _authService.signInWithGoogle();

      if (_authService.usesNativeGoogleSignIn) {
        final user = response?.user;

        if (user == null) {
          throw const AuthException(
            'Akun Google tidak berhasil diautentikasi.',
          );
        }

        await _finishGoogleLogin(user);
      }
    } on GoogleSignInException catch (error) {
      _waitingForGoogleAuth = false;

      if (error.code != GoogleSignInExceptionCode.canceled) {
        _showError(
          'Login Google gagal',
          error.description ?? 'Gagal masuk menggunakan akun Google.',
        );
      }
    } on AuthException catch (error) {
      _waitingForGoogleAuth = false;

      _showError('Login Google gagal', error.message);
    } catch (error) {
      _waitingForGoogleAuth = false;

      _showError('Login Google gagal', error.toString());
    } finally {
      isGoogleLoading.value = false;
    }
  }

  void _showError(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  @override
  void onClose() {
    _authSubscription?.cancel();

    emailController.removeListener(validateForm);
    passwordController.removeListener(validateForm);
    confirmPasswordController.removeListener(validateForm);

    emailController.removeListener(validateLoginForm);
    passwordController.removeListener(validateLoginForm);

    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}
