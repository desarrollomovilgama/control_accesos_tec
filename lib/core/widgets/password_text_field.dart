/// =============================================================================
/// password_text_field.dart
/// -----------------------------------------------------------------------------
/// Campo de contraseña con toggle de visibilidad (icono de ojo).
/// Variante del catálogo de widgets estándar (Fig. 40 del MPF).
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../icons/app_icons.dart';
import '../spacing/app_spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.enabled = true,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;
  final bool enabled;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscured = true;

  void _toggle() => setState(() => _obscured = !_obscured);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTypography.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacing.vGapSm,
        TextField(
          controller: widget.controller,
          obscureText: _obscured,
          enabled: widget.enabled,
          textInputAction: TextInputAction.done,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            hintText: widget.hintText ?? widget.label,
            errorText: widget.errorText,
            suffixIcon: IconButton(
              tooltip: _obscured ? 'Mostrar' : 'Ocultar',
              onPressed: _toggle,
              icon: Icon(
                _obscured ? AppIcons.visibilityOff : AppIcons.visibility,
                color: AppColors.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
