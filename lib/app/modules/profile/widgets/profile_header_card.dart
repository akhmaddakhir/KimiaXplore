import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../controllers/profile_controller.dart';

class ProfileHeaderCard extends GetView<ProfileController> {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Buletan Profile di Kiri (lebih besar & proporsional)
            Container(
              width: 68,
              height: 68,
              decoration: const BoxDecoration(
                color: Color(0xFF7E847B),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                controller.userInitial,
                style: const TextStyle(
                  fontFamily: AppTypography.fontFamily,
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Nama di Kanan & Role di Bawahnya (lebih besar & jelas)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.userName.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.roleName,
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: controller.roleTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
