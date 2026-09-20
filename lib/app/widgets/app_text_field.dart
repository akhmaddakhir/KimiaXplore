import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_typography.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.enabled = true,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.prefix,
    this.suffix,
    this.autofillHints,
    this.focusNode,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final IconData? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isPassword != widget.isPassword) {
      _isObscured = widget.isPassword;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  Widget? _buildPrefix() {
    if (widget.prefix != null) {
      return widget.prefix;
    }

    if (widget.prefixIcon != null) {
      return Icon(widget.prefixIcon, color: AppColors.textMedium, size: 22);
    }

    return null;
  }

  Widget? _buildSuffix() {
    if (widget.isPassword) {
      return IconButton(
        onPressed: widget.enabled ? _togglePasswordVisibility : null,
        tooltip: _isObscured ? 'Tampilkan password' : 'Sembunyikan password',
        icon: Icon(
          _isObscured
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.textHint,
          size: 22,
        ),
      );
    }

    return widget.suffix;
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppRadius.lg);

    OutlineInputBorder buildBorder(Color color) {
      return OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: color, width: 2),
      );
    }

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      obscureText: widget.isPassword && _isObscured,
      enabled: widget.enabled,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autofillHints: widget.autofillHints,
      autocorrect: !widget.isPassword,
      enableSuggestions: !widget.isPassword,
      cursorColor: AppColors.textDark,
      style: AppTypography.body.copyWith(
        color: AppColors.textDark,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        labelStyle: AppTypography.body.copyWith(
          color: AppColors.textHint,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return AppTypography.bodySmall.copyWith(
              color: AppColors.errorRed,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            );
          }

          return AppTypography.bodySmall.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          );
        }),
        hintStyle: AppTypography.body.copyWith(
          color: AppColors.textHint,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: _buildPrefix(),
        suffixIcon: _buildSuffix(),
        border: buildBorder(AppColors.border),
        enabledBorder: buildBorder(AppColors.border),
        focusedBorder: buildBorder(AppColors.textDark),
        errorBorder: buildBorder(AppColors.errorRed),
        focusedErrorBorder: buildBorder(AppColors.errorRed),
        disabledBorder: buildBorder(AppColors.border),
        errorStyle: AppTypography.caption.copyWith(color: AppColors.darkRed),
      ),
    );
  }
}

typedef AppTextInput = AppTextField;
