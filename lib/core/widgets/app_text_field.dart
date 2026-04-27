/// @file    app_text_field.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Campo de texto estándar — GAMA MPF v1.0
/// Referencia: Sección 5.2.6 / Figura 40 del Manual de Programación Flutter
///
/// IMPORTANTE: Queda PROHIBIDO usar TextField suelto sin validación.
/// Todo campo de texto debe incluir validación asociada.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_colors.dart';
import '../config/app_spacing.dart';
import '../config/app_text_styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.suffixWidget,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final Widget? suffixWidget;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label ──────────────────────────────────────────────────
        Text(widget.label, style: AppTextStyles.fieldLabel),
        const SizedBox(height: AppSpacing.xs),

        // ── Campo ──────────────────────────────────────────────────
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          keyboardType: widget.keyboardType,
          onChanged: widget.onChanged,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          autofocus: widget.autofocus,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          style: AppTextStyles.body.copyWith(color: AppColors.textContrast),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.fieldHint,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: FaIcon(
                      widget.prefixIcon,
                      size: 15,
                      color: AppColors.iconGray,
                    ),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 44),
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: FaIcon(
                      _obscure
                          ? FontAwesomeIcons.eyeSlash
                          : FontAwesomeIcons.eye,
                      size: 15,
                      color: AppColors.iconGray,
                    ),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : widget.suffixWidget,
            filled: true,
            fillColor: widget.enabled
                ? AppColors.iceBlue
                : AppColors.mistBlue,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              borderSide: const BorderSide(color: AppColors.borderGray),
            ),
            errorStyle: AppTextStyles.errorText,
          ),
        ),
      ],
    );
  }
}
