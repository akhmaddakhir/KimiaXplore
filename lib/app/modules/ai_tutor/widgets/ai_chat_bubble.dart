import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_typography.dart';

class AiChatBubble extends StatelessWidget {
  const AiChatBubble({super.key, required this.message, this.isUser = true});

  final String message;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: isUser ? AppColors.blue50 : AppColors.surface,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(26),
              topRight: const Radius.circular(26),
              bottomLeft: Radius.circular(isUser ? 26 : 6),
              bottomRight: Radius.circular(isUser ? 6 : 26),
            ),
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}
