import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

class OnboardingTransition extends StatelessWidget {
  const OnboardingTransition({
    super.key,
    this.imagePath = 'assets/images/onboarding_transition.png',
    this.title = 'Saatnya Bereaksi!',
    this.subtitle =
        'Kalau atom aja bisa berikatan, masa kamu sama kimia cuma sebatas kenalan?',
    this.imageHeight = 300,
  });

  final String imagePath;
  final String title;
  final String subtitle;
  final double imageHeight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath,
                    height: imageHeight,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox(
                        height: imageHeight,
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 64,
                            color: AppColors.textHint,
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 48),

                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: AppTypography.heading1.copyWith(
                      color: AppColors.textDark,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: AppTypography.body.copyWith(
                      color: AppColors.textMedium,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
