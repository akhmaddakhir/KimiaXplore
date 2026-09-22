import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const AppDetailHeader(title: 'Pengaturan'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.xl,
                  AppSpacing.md,
                  AppSpacing.xl,
                  AppSpacing.xxl,
                ),
                child: Column(
                  children: [
                    _SettingsTile(
                      icon: Icons.person_outline_rounded,
                      title: 'Akun',
                      onTap: controller.openAccount,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    _SettingsTile(
                      icon: Icons.shopping_bag_outlined,
                      title: 'Riwayat Pembelian',
                      onTap: controller.openPurchaseHistory,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Obx(
                      () => _SettingsTile(
                        icon: Icons.dark_mode_outlined,
                        title: 'Mode Tampilan',
                        trailing: Switch.adaptive(
                          value: controller.isDarkMode.value,
                          activeThumbColor: AppColors.blue500,
                          activeTrackColor: AppColors.blue100,
                          onChanged: controller.toggleDarkMode,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Obx(
                      () => _LanguageTile(
                        selectedLanguage: controller.selectedLanguage.value,
                        onSelected: controller.selectLanguage,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    const Divider(color: AppColors.border, height: 1),
                    const SizedBox(height: AppSpacing.xl),
                    Obx(
                      () => _SettingsTile(
                        icon: Icons.logout_rounded,
                        title: controller.isLoggingOut.value
                            ? 'Keluar...'
                            : 'Log out',
                        iconColor: AppColors.red500,
                        textColor: AppColors.red500,
                        onTap: controller.isLoggingOut.value
                            ? null
                            : controller.confirmLogout,
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

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.textColor,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.lg,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Icon(
                  icon,
                  size: 26,
                  color: iconColor ?? AppColors.textDark,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.body.copyWith(
                    color: textColor ?? AppColors.textDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (trailing != null)
                trailing!
              else if (onTap != null)
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 24,
                  color: AppColors.textHint,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.selectedLanguage,
    required this.onSelected,
  });

  final String selectedLanguage;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.lg,
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 40,
            child: Icon(
              Icons.language_rounded,
              size: 26,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              'Bahasa',
              style: AppTypography.body.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.blue50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.blue100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _LanguageOption(
                  label: 'ID',
                  selected: selectedLanguage == 'ID',
                  onTap: () => onSelected('ID'),
                ),
                _LanguageOption(
                  label: 'EN',
                  selected: selectedLanguage == 'EN',
                  onTap: () => onSelected('EN'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          style: AppTypography.caption.copyWith(
            color: selected ? AppColors.blue500 : AppColors.textMedium,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
