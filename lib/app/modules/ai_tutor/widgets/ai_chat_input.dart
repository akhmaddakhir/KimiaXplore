import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_radius.dart';
import '../../../theme/app_spacing.dart';
import '../../../theme/app_typography.dart';

class AiChatInput extends StatefulWidget {
  const AiChatInput({
    super.key,
    required this.onSend,
    this.onAttachment,
    this.hintText = 'Tanyakan sesuatu tentang kimia...',
    this.enabled = true,
  });

  final ValueChanged<String> onSend;
  final VoidCallback? onAttachment;
  final String hintText;
  final bool enabled;

  @override
  State<AiChatInput> createState() => _AiChatInputState();
}

class _AiChatInputState extends State<AiChatInput> {
  final TextEditingController _textController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  bool get _hasText => _textController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();

    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  void _sendMessage() {
    if (!widget.enabled || !_hasText) {
      return;
    }

    final message = _textController.text.trim();

    _textController.clear();

    _focusNode.unfocus();

    widget.onSend(message);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);

    _textController.dispose();

    _focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.blue700.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _textController,
            focusNode: _focusNode,
            enabled: widget.enabled,
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            textCapitalization: TextCapitalization.sentences,
            minLines: 2,
            maxLines: 5,
            style: AppTypography.body.copyWith(color: AppColors.textDark),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppTypography.body.copyWith(color: AppColors.textHint),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xs,
                vertical: AppSpacing.sm,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.sm),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.enabled ? (widget.onAttachment ?? () {}) : null,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      Icons.add_rounded,
                      color: AppColors.textDark,
                      size: 24,
                    ),
                  ),
                ),
              ),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(scale: animation, child: child),
                  );
                },
                child: _hasText && widget.enabled
                    ? Material(
                        key: const ValueKey('send'),
                        color: AppColors.blue500,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        child: InkWell(
                          onTap: _sendMessage,
                          borderRadius: BorderRadius.circular(AppRadius.pill),
                          child: const SizedBox(
                            width: 36,
                            height: 36,
                            child: Icon(
                              Icons.arrow_upward_rounded,
                              color: AppColors.surface,
                              size: 22,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(
                        key: ValueKey('empty'),
                        width: 36,
                        height: 36,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
