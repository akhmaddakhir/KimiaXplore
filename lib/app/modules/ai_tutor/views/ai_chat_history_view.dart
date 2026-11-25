import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/app_detail_header.dart';
import '../controllers/ai_tutor_controller.dart';
import '../models/ai_chat_session.dart';

class AiChatHistoryView extends GetView<AiTutorController> {
  const AiChatHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Obx(
              () => AppDetailHeader(
                title: 'ai_history_title'.tr,
                actions: [
                  if (controller.sessions.isNotEmpty)
                    IconButton(
                      icon: const Icon(
                        Icons.delete_sweep_outlined,
                        color: AppColors.red500,
                        size: 24,
                      ),
                      tooltip: 'ai_history_clear_all'.tr,
                      onPressed: () => _showClearAllDialog(context),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if (controller.isLoadingHistory.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blue500,
                    ),
                  );
                }

                if (controller.sessions.isEmpty) {
                  return _buildEmptyState();
                }

                return _buildHistoryList(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 140,
              height: 140,
              child: SvgPicture.asset(
                'assets/images/app_mascot.svg',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'ai_history_empty_title'.tr,
              textAlign: TextAlign.center,
              style: AppTypography.heading2.copyWith(
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'ai_history_empty_desc'.tr,
              textAlign: TextAlign.center,
              style: AppTypography.body.copyWith(
                color: AppColors.textMedium,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton.primary(
              label: 'ai_history_new_chat'.tr,
              icon: const Icon(
                Icons.add_comment_rounded,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () {
                controller.openNewChat();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      itemCount: controller.sessions.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: AppButton.outline(
              label: 'ai_history_new_chat'.tr,
              icon: const Icon(
                Icons.add_rounded,
                color: AppColors.blue500,
                size: 22,
              ),
              onPressed: () {
                controller.openNewChat();
                Get.back();
              },
            ),
          );
        }

        final session = controller.sessions[index - 1];
        final isCurrentActive = controller.currentSessionId.value == session.id;

        return _buildSessionCard(context, session, isCurrentActive);
      },
    );
  }

  Widget _buildSessionCard(
    BuildContext context,
    AiChatSession session,
    bool isCurrentActive,
  ) {
    final language = controller.activeChatLanguage;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          onTap: () {
            controller.loadSession(session);
            Get.back();
          },
          child: Ink(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: isCurrentActive ? AppColors.blue50 : AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(
                color: isCurrentActive ? AppColors.blue500 : AppColors.border,
                width: isCurrentActive ? 2.0 : 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isCurrentActive
                      ? AppColors.blue100.withValues(alpha: 0.4)
                      : Colors.black.withValues(alpha: 0.03),
                  offset: const Offset(0, 3),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Avatar
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isCurrentActive
                        ? AppColors.blue100
                        : AppColors.blue50,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.blue500,
                    size: 22,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              session.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.title.copyWith(
                                fontSize: 15,
                                color: AppColors.textDark,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            session.formatRelativeTime(language: language),
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textMedium,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        session.lastMessageSnippet.isNotEmpty
                            ? session.lastMessageSnippet
                            : 'ai_input_hint'.tr,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textMedium,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.blue50,
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              '${session.messageCount} ${language == 'EN' ? 'messages' : 'pesan'}',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.blue500,
                                fontWeight: FontWeight.w700,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          if (isCurrentActive) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.green50,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.sm),
                              ),
                              child: Text(
                                language == 'EN' ? 'Active' : 'Aktif',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.green700,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),

                // Delete Action
                IconButton(
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: AppColors.red500,
                    size: 20,
                  ),
                  tooltip: 'ai_history_delete_confirm'.tr,
                  onPressed: () => _showDeleteDialog(context, session),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, AiChatSession session) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        backgroundColor: AppColors.surface,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: AppColors.red50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_forever_rounded,
                  color: AppColors.red500,
                  size: 28,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'ai_history_delete_title'.tr,
                style: AppTypography.title.copyWith(
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'ai_history_delete_desc'.tr,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: AppButton.outline(
                      label: 'ai_history_cancel'.tr,
                      height: 44,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: AppButton(
                      label: 'ai_history_delete_confirm'.tr,
                      height: 44,
                      gradientColors: const [
                        AppColors.red500,
                        AppColors.red500,
                      ],
                      shadowColor: AppColors.red700,
                      onPressed: () {
                        controller.deleteSession(session.id);
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        backgroundColor: AppColors.surface,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: AppColors.red50,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.delete_sweep_rounded,
                  color: AppColors.red500,
                  size: 28,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'ai_history_clear_all'.tr,
                style: AppTypography.title.copyWith(
                  color: AppColors.textDark,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'ai_history_clear_all_desc'.tr,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMedium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: AppButton.outline(
                      label: 'ai_history_cancel'.tr,
                      height: 44,
                      onPressed: () => Get.back(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: AppButton(
                      label: 'ai_history_delete_confirm'.tr,
                      height: 44,
                      gradientColors: const [
                        AppColors.red500,
                        AppColors.red500,
                      ],
                      shadowColor: AppColors.red700,
                      onPressed: () {
                        controller.clearAllHistory();
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
