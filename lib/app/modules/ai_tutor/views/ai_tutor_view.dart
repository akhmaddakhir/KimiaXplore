import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_main_header.dart';
import '../controllers/ai_tutor_controller.dart';
import '../widgets/ai_chat_bubble.dart';
import '../widgets/ai_chat_input.dart';

class AiTutorView extends GetView<AiTutorController> {
  const AiTutorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            AppMainHeader(
              title: 'AI Tutor',
              actions: [
                Obx(
                  () => controller.isChatOpen.value
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: controller.isSending.value
                              ? null
                              : controller.openNewChat,
                          child: const SizedBox(
                            width: 36,
                            height: 36,
                            child: Icon(
                              Icons.add_comment_outlined,
                              color: AppColors.textDark,
                              size: 24,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
            ),
            Expanded(
              child: Obx(
                () => controller.isChatOpen.value
                    ? _buildChatContent()
                    : _buildWelcomeContent(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Obx(
                () => AiChatInput(
                  enabled: !controller.isSending.value,
                  onSend: controller.sendMessage,
                  onAttachment: controller.openAttachment,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.lg,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        color: AppColors.blue50,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                      child: const Icon(
                        Icons.science_rounded,
                        size: 88,
                        color: AppColors.blue500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'Mau belajar apa hari ini?',
                      textAlign: TextAlign.center,
                      style: AppTypography.heading1.copyWith(
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Tanyakan apa saja tentang kimia kepada Kimi!',
                      textAlign: TextAlign.center,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textMedium,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatContent() {
    return Obx(() {
      final isSending = controller.isSending.value;

      final itemCount = controller.messages.length + (isSending ? 1 : 0);

      return ListView.builder(
        reverse: true,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (isSending && index == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.md),
              child: AiChatBubble(
                message: 'Kimi sedang berpikir...',
                isUser: false,
              ),
            );
          }

          final adjustedIndex = isSending ? index - 1 : index;

          final reversedIndex = controller.messages.length - 1 - adjustedIndex;

          final message = controller.messages[reversedIndex];

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AiChatBubble(message: message.text, isUser: message.isUser),
          );
        },
      );
    });
  }
}
