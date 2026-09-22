import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';
import '../controllers/profile_controller.dart';

class ProfileHeaderCard extends GetView<ProfileController> {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _ProfileAvatar(
              avatarUrl: controller.avatarUrl.value,
              initial: controller.userInitial,
            ),
            const SizedBox(width: 16),
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
                      fontWeight: FontWeight.w700,
                      color: controller.roleTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.avatarUrl, required this.initial});

  final String? avatarUrl;
  final String initial;

  @override
  Widget build(BuildContext context) {
    final url = avatarUrl?.trim();

    if (url != null && url.isNotEmpty) {
      return ClipOval(
        child: Image.network(
          url,
          width: 68,
          height: 68,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _InitialAvatar(initial: initial);
          },
        ),
      );
    }

    return _InitialAvatar(initial: initial);
  }
}

class _InitialAvatar extends StatelessWidget {
  const _InitialAvatar({required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 68,
      height: 68,
      decoration: const BoxDecoration(
        color: AppColors.blue500,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          fontFamily: AppTypography.fontFamily,
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
