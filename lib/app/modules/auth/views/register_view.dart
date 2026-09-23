import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_step_header.dart';
import '../../../widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_divider.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  String? get tag => 'register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            AppStepHeader(progress: 1.0, onBackPressed: () => Get.back()),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SingleChildScrollView(
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          'auth_ready_start'.tr,
                          textAlign: TextAlign.center,
                          style: AppTypography.heading1.copyWith(
                            color: AppColors.textDark,
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Obx(
                          () => AppButton.icon(
                            width: double.infinity,
                            icon: SvgPicture.asset(
                              'assets/icons/google.svg',
                              width: 24,
                              height: 24,
                            ),
                            onPressed: controller.isGoogleLoading.value
                                ? null
                                : controller.signInWithGoogle,
                          ),
                        ),
                        const SizedBox(height: 24),
                        AuthDivider(text: 'auth_or'.tr),
                        const SizedBox(height: 24),
                        AppTextField(
                          label: 'email'.tr,
                          hintText: 'auth_email_hint'.tr,
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          validator: controller.validateEmail,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: 'auth_password'.tr,
                          hintText: 'auth_password_min'.tr,
                          controller: controller.passwordController,
                          isPassword: true,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.newPassword],
                          validator: controller.validatePassword,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: 'auth_confirm_password'.tr,
                          hintText: 'auth_confirm_password_hint'.tr,
                          controller: controller.confirmPasswordController,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          validator: controller.validateConfirmPassword,
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => AppButton.primary(
                    label: 'material_complete'.tr,
                    onPressed:
                        controller.isFormValid.value &&
                            !controller.isLoading.value
                        ? controller.register
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
