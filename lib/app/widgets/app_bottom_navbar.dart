import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

class AppBottomNavbar extends StatelessWidget {
  const AppBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    this.isMoreOpen = false,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final bool isMoreOpen;

  static const List<_NavItem> _items = [
    _NavItem(
      label: 'Home',
      assetPath: 'assets/icons/home_icon.svg',
      size: 36,
    ),
    _NavItem(
      label: 'Achievement',
      assetPath: 'assets/icons/achievement_icon.svg',
      size: 36,
    ),
    _NavItem(
      label: 'AI Tutor',
      assetPath: 'assets/icons/aitutor_icon.svg',
      size: 42,
    ),
    _NavItem(
      label: 'Shop',
      assetPath: 'assets/icons/shop_icon.svg',
      size: 42,
    ),
    _NavItem(
      label: 'More',
      assetPath: 'assets/icons/more_icon.svg',
      size: 36,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final activeIndex = isMoreOpen ? 4 : selectedIndex;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = activeIndex == index;

              return Expanded(
                child: Semantics(
                  label: item.label,
                  selected: isSelected,
                  button: true,
                  child: GestureDetector(
                    onTap: () => onTabSelected(index),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 14, 0, 16),
                      child: Center(
                        heightFactor: 1.0,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 140),
                          width: 50,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.blue50
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(14),
                            border: isSelected
                                ? Border.all(
                                    color: AppColors.blue500,
                                    width: 2,
                                  )
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(
                            item.assetPath,
                            width: item.size,
                            height: item.size,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
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
  const _NavItem({
    required this.label,
    required this.assetPath,
    required this.size,
  });

  final String label;
  final String assetPath;
  final double size;
}
