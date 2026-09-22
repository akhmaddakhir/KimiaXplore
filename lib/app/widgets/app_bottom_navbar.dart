import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class AppBottomNavbar extends StatelessWidget {
  const AppBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  static const List<_NavItem> _items = [
    _NavItem(labelKey: 'nav_home', icon: Icons.home_outlined),
    _NavItem(labelKey: 'nav_lab', icon: Icons.science_outlined),
    _NavItem(labelKey: 'nav_ai_tutor', icon: Icons.smart_toy_outlined),
    _NavItem(labelKey: 'nav_shop', icon: Icons.workspace_premium_outlined),
    _NavItem(labelKey: 'nav_profile', icon: Icons.person_outline_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: AppColors.surface),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];

              final isSelected = selectedIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () {
                    onTabSelected(index);
                  },
                  borderRadius: BorderRadius.circular(24),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 36,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.blue50
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          item.icon,
                          size: 24,
                          color: isSelected
                              ? AppColors.textDark
                              : AppColors.textHint,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.labelKey.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTypography.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColors.textDark
                              : AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.labelKey, required this.icon});

  final String labelKey;
  final IconData icon;
}
