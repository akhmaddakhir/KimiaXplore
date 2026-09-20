import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isFormValid = false.obs;
  final isLoginFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();

    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
    confirmPasswordController.addListener(validateForm);

    emailController.addListener(validateLoginForm);
    passwordController.addListener(validateLoginForm);
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

  void register() {
    final isValid = formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    validateForm();
  }

  void login() {
    final isValid =
        (loginFormKey.currentState ?? formKey.currentState)?.validate() ??
        false;

    if (!isValid) {
      return;
    }

    validateLoginForm();
  }

  @override
  void onClose() {
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
