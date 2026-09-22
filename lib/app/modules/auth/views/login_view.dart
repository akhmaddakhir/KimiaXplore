import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_step_header.dart';
import '../../../widgets/app_text_field.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_divider.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  String? get tag => 'login';

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
                    key: controller.loginFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 32),
                        Text(
                          'Masuk',
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
                        const AuthDivider(),
                        const SizedBox(height: 24),
                        AppTextField(
                          label: 'Email',
                          hintText: 'Masukkan email kamu',
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          validator: controller.validateEmail,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: 'Sandi',
                          hintText: 'Masukkan sandi kamu',
                          controller: controller.passwordController,
                          isPassword: true,
                          textInputAction: TextInputAction.done,
                          autofillHints: const [AutofillHints.password],
                          validator: controller.validatePassword,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Belum punya akun? ',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textMedium,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Get.offNamed(AppRoutes.onboarding),
                              child: Text(
                                'Gas bikin',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.blue500,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
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
                    label: 'Masuk',
                    onPressed:
                        controller.isLoginFormValid.value &&
                            !controller.isLoading.value
                        ? controller.login
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
