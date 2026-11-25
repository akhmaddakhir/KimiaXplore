import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
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
              title: 'ai_title'.tr,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
                vertical: AppSpacing.md,
              ),
              actions: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: controller.openHistory,
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      Icons.history_rounded,
                      color: AppColors.textDark,
                      size: 24,
                    ),
                  ),
                ),
                Obx(
                  () => controller.isChatOpen.value
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: AppSpacing.sm),
                            GestureDetector(
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
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => controller.isChatOpen.value
                    ? _buildChatContent()
                    : _buildWelcomeContent(),
              ),
            ),
            // Maskot di atas kiri chatbox + AiChatInput yang dipertahankan
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                40,
                AppSpacing.lg,
                AppSpacing.lg,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -42,
                    left: 14,
                    child: IgnorePointer(
                      child: SvgPicture.asset(
                        'assets/images/app_mascot.svg',
                        width: 56,
                        height: 56,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Obx(
                    () => AiChatInput(
                      enabled: !controller.isSending.value,
                      hintText: 'ai_input_hint'.tr,
                      onSend: controller.sendMessage,
                      onAttachment: controller.openAttachment,
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

  Widget _buildWelcomeContent() {
    final isEn = controller.activeChatLanguage == 'EN';
    final headline = isEn
        ? 'What should we tackle next?'
        : 'Apa yang mau kita bahas?';
    final prompts = isEn
        ? ['Learn something new', 'Let\'s do some puzzles']
        : ['Pelajari materi baru', 'Ayo latihan soal kimia'];

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            headline,
            style: AppTypography.heading2.copyWith(
              color: AppColors.textDark,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          ...prompts.map(
            (prompt) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm + 2),
              child: Material(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => controller.sendMessage(prompt),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.border,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      prompt,
                      style: AppTypography.body.copyWith(
                        color: AppColors.textDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      ),
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
            final thinkingText = controller.activeChatLanguage == 'EN'
                ? 'Kimi is thinking...'
                : 'Kimi sedang berpikir...';

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: AiChatBubble(
                message: thinkingText,
                isUser: false,
              ),
            );
          }

          final messageIndex = isSending ? index - 1 : index;
          final reversedIndex = controller.messages.length - 1 - messageIndex;
          final message = controller.messages[reversedIndex];

          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AiChatBubble(
              message: message.text,
              isUser: message.isUser,
            ),
          );
        },
      );
    });
  }
}
