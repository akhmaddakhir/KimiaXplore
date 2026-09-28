import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../widgets/speech_bubble.dart';

class OnboardingIntro extends StatelessWidget {
  const OnboardingIntro({super.key, this.message});

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 36),
        SpeechBubble(text: message ?? 'onboarding_intro_msg'.tr),
        const SizedBox(height: 28),
        Center(
          child: SizedBox(
            width: 220,
            height: 220,
            child: SvgPicture.asset(
              'assets/images/app_mascot.svg',
              fit: BoxFit.contain,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
