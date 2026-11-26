import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../controllers/profile_controller.dart';

class EditAvatarView extends StatefulWidget {
  const EditAvatarView({super.key});

  @override
  State<EditAvatarView> createState() => _EditAvatarViewState();
}

class _EditAvatarViewState extends State<EditAvatarView> {
  final ProfileController _controller = Get.find<ProfileController>();

  late String _selectedAsset;
  late Color _selectedBg;
  int _activeTab = 0; // 0 = AVATAR, 1 = BACKGROUND

  @override
  void initState() {
    super.initState();
    _selectedAsset = _controller.selectedAvatarAsset.value;
    _selectedBg = _controller.selectedAvatarBg.value;
  }

  void _saveAndClose() {
    _controller.updateAvatarAppearance(
      assetPath: _selectedAsset,
      backgroundColor: _selectedBg,
    );
    Get.back<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Top bar: X di kiri, "Edit Avatar" di tengah, "SELESAI" di kanan
          Container(
            color: AppColors.surface,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back<void>(),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.textMedium,
                        size: 26,
                      ),
                      tooltip: 'Tutup',
                    ),
                    Expanded(
                      child: Text(
                        'Edit Avatar',
                        textAlign: TextAlign.center,
                        style: AppTypography.heading2.copyWith(
                          color: AppColors.textDark,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _saveAndClose,
                      child: Text(
                        'SELESAI',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.blue500,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Area preview avatar & background
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: double.infinity,
            height: 210,
            color: _selectedBg,
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              _selectedAsset,
              width: 180,
              height: 180,
              fit: BoxFit.contain,
            ),
          ),
          // Tab bar: AVATAR | BACKGROUND
          Container(
            color: AppColors.surface,
            child: Row(
              children: [
                _TabItem(
                  label: 'AVATAR',
                  isSelected: _activeTab == 0,
                  onTap: () => setState(() => _activeTab = 0),
                ),
                _TabItem(
                  label: 'BACKGROUND',
                  isSelected: _activeTab == 1,
                  onTap: () => setState(() => _activeTab = 1),
                ),
              ],
            ),
          ),
          // Konten tab
          Expanded(
            child: _activeTab == 0
                ? _buildAvatarTab()
                : _buildBackgroundTab(),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarTab() {
    const options = ProfileController.avatarOptions;

    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.xl),
      itemCount: options.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSpacing.md,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        final option = options[index];
        final isSelected = option.asset == _selectedAsset;

        return GestureDetector(
          onTap: () => setState(() => _selectedAsset = option.asset),
          child: Column(
            children: [
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.blue50 : AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AppColors.blue500 : AppColors.border,
                      width: 2.0,
                    ),
                  ),
                  child: SvgPicture.asset(
                    option.asset,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                option.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bodySmall.copyWith(
                  color: isSelected ? AppColors.blue500 : AppColors.textMedium,
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackgroundTab() {
    const colors = AppColors.avatarBackgrounds;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Warna latar belakang',
            style: AppTypography.heading2.copyWith(
              color: AppColors.textDark,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: colors.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final color = colors[index];
              final isSelected = color.toARGB32() == _selectedBg.toARGB32();

              return GestureDetector(
                onTap: () => setState(() => _selectedBg = color),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 140),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? AppColors.blue500 : AppColors.border,
                      width: 2.0,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.blue500 : AppColors.border,
                width: isSelected ? 2.5 : 1.5,
              ),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              color: isSelected ? AppColors.blue500 : AppColors.textMedium,
              fontWeight: FontWeight.w800,
              fontSize: 13.5,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
