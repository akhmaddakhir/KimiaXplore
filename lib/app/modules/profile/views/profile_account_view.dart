import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_detail_header.dart';
import '../../../widgets/app_text_field.dart';
import '../controllers/profile_controller.dart';

class ProfileAccountView extends GetView<ProfileController> {
  const ProfileAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const AppDetailHeader(title: 'Akun'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.xxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Akun',
                      style: AppTypography.heading2.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Kelola informasi akun KimiaXplore kamu.',
                      style: AppTypography.body.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppTextField(
                      label: 'Username',
                      controller: controller.usernameController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      prefixIcon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppTextField(
                      label: 'Email',
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      enabled: false,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Obx(
                      () => AppButton.primary(
                        label: controller.isSavingProfile.value
                            ? 'Menyimpan...'
                            : 'Simpan Perubahan',
                        onPressed: controller.isSavingProfile.value
                            ? null
                            : controller.updateUsername,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
