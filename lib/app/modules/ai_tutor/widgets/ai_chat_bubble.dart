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
            color: isUser ? AppColors.blue500 : AppColors.surface,
            border: isUser
                ? null
                : Border.all(color: AppColors.border, width: 1.5),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(22),
              topRight: const Radius.circular(22),
              bottomLeft: Radius.circular(isUser ? 22 : 6),
              bottomRight: Radius.circular(isUser ? 6 : 22),
            ),
          ),
          child: Text(
            message,
            style: TextStyle(
              fontFamily: AppTypography.fontFamily,
              fontSize: 14.5,
              fontWeight: FontWeight.w600,
              color: isUser ? AppColors.surface : AppColors.textDark,
              height: 1.45,
            ),
          ),
        ),
      ),
    );
  }
}
