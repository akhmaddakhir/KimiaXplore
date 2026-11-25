import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_bottom_navbar.dart';

import '../../achievement/views/achievement_view.dart';
import '../../ai_tutor/views/ai_tutor_view.dart';
import '../../home/views/home_view.dart';
import '../../lab/views/lab_view.dart';
import '../../shop/views/shop_view.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  static const List<Widget> _pages = [
    HomeView(),
    AchievementView(),
    AiTutorView(),
    ShopView(),
  ];

  void _openProfile() {
    controller.closeMoreMenu();
    controller.refreshProfile();
    Get.toNamed(AppRoutes.profile);
  }

  void _openTeacherTutor() {
    controller.closeMoreMenu();
    Get.snackbar(
      'Guru Tutor',
      'Fitur konsultasi dengan Guru Tutor segera hadir.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
    );
  }

  void _openPracticeCenter() {
    controller.closeMoreMenu();
    Get.to(() => const LabView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        final activeTab = controller.selectedIndex.value.clamp(
          0,
          _pages.length - 1,
        );
        final isMoreOpen = controller.isMoreMenuOpen.value;

        return Stack(
          children: [
            IndexedStack(
              index: activeTab,
              children: _pages,
            ),
            if (isMoreOpen) ...[
              // Scrim gelap di atas halaman saat More Option terbuka
              Positioned.fill(
                child: GestureDetector(
                  onTap: controller.closeMoreMenu,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: AppColors.textDark.withValues(alpha: 0.45),
                  ),
                ),
              ),
              // Menu More Option menempel di atas bottom navbar ala Duolingo
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    border: Border(
                      top: BorderSide(color: AppColors.border, width: 1.5),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _MoreOptionTile(
                        icon: ClipOval(
                          child: SvgPicture.asset(
                            'assets/images/guest_avatar.svg',
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                        label: 'Profile',
                        onTap: _openProfile,
                      ),
                      const Divider(
                        color: AppColors.border,
                        height: 1,
                        thickness: 1.5,
                      ),
                      _MoreOptionTile(
                        icon: SvgPicture.asset(
                          'assets/icons/teachertutor_icon.svg',
                          width: 32,
                          height: 32,
                          fit: BoxFit.contain,
                        ),
                        label: 'Guru Tutor',
                        onTap: _openTeacherTutor,
                      ),
                      const Divider(
                        color: AppColors.border,
                        height: 1,
                        thickness: 1.5,
                      ),
                      _MoreOptionTile(
                        icon: SvgPicture.asset(
                          'assets/icons/practice_icon.svg',
                          width: 32,
                          height: 32,
                          fit: BoxFit.contain,
                        ),
                        label: 'Pusat Latihan',
                        onTap: _openPracticeCenter,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      }),
      bottomNavigationBar: Obx(
        () => AppBottomNavbar(
          selectedIndex: controller.selectedIndex.value,
          isMoreOpen: controller.isMoreMenuOpen.value,
          onTabSelected: controller.changeTab,
        ),
      ),
    );
  }
}

class _MoreOptionTile extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const _MoreOptionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.xl,
            vertical: 16,
          ),
          child: Row(
            children: [
              SizedBox(width: 48, height: 48, child: Center(child: icon)),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Text(
                  label,
                  style: AppTypography.title.copyWith(
                    color: AppColors.textDark,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
