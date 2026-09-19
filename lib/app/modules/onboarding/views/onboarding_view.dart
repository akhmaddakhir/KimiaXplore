import 'package:flutter/material.dart';

import '../../../widgets/app_button.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: AppButton.primary(label: 'Lanjut', onPressed: () {}),
          ),
        ),
      ),
    );
  }
}
