/// =============================================================================
/// standard_text_field.dart
/// -----------------------------------------------------------------------------
/// Campo de texto estándar reutilizable. Figura 40 del MPF.
/// Internamente usa `TextFormField`, lo que permite participar en formularios
/// (`Form` + `validator`) sin perder compatibilidad con uso simple.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../spacing/app_spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class StandardTextField extends StatelessWidget {
  const StandardTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.enabled = true,
    this.validator,
    this.inputFormatters,
    this.maxLines = 1,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final bool enabled;

  /// Validador opcional para uso dentro de un `Form`.
  final FormFieldValidator<String>? validator;

  /// Formatters de entrada (ej. `FilteringTextInputFormatter.digitsOnly`).
  final List<TextInputFormatter>? inputFormatters;

  /// Líneas máximas (1 por defecto). Usar > 1 para campos multiline.
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacing.vGapSm,
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          enabled: enabled,
          validator: validator,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText ?? label,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: AppColors.textHint)
                : null,
            suffixIcon: suffixIcon,
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
