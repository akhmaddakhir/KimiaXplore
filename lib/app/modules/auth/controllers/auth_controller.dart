import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
    confirmPasswordController.addListener(validateForm);
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

  void register() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    validateForm();
  }

  @override
  void onClose() {
    emailController.removeListener(validateForm);
    passwordController.removeListener(validateForm);
    confirmPasswordController.removeListener(validateForm);

    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}
