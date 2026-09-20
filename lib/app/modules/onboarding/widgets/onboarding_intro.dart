import 'package:flutter/material.dart';

import '../../../widgets/speech_bubble.dart';

class OnboardingIntro extends StatelessWidget {
  const OnboardingIntro({super.key, this.message = 'Halo Xplorer!'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 52),
        SpeechBubble(text: message),
        const Spacer(),
      ],
    );
  }
}
