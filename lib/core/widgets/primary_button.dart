<<<<<<< HEAD
/// =============================================================================
/// primary_button.dart
/// -----------------------------------------------------------------------------
/// Botón primario del catálogo de widgets estándar. Figura 39 del MPF.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../spacing/app_spacing.dart';
import '../theme/app_colors.dart';
=======
/// @file    primary_button.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Botón primario estándar — GAMA MPF v1.0
/// Referencia: Sección 5.2.6 / Figura 39 del Manual de Programación Flutter
///
/// IMPORTANTE: Queda PROHIBIDO usar ElevatedButton directamente en las vistas.
/// Siempre importar PrimaryButton desde core/widgets.

import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_spacing.dart';
import '../config/app_text_styles.dart';

enum PrimaryButtonVariant { filled, outlined, danger, success }
>>>>>>> 358d57ba1357f30f64afa2c4e1ad017fde59e106

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
<<<<<<< HEAD
    this.isLoading = false,
    this.icon,
=======
    this.variant = PrimaryButtonVariant.filled,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
>>>>>>> 358d57ba1357f30f64afa2c4e1ad017fde59e106
  });

  final String label;
  final VoidCallback? onPressed;
<<<<<<< HEAD
  final bool isLoading;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null || isLoading;
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2.4,
                color: AppColors.textOnPrimary,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  AppSpacing.hGapSm,
                ],
                Text(label),
              ],
            ),
    );
  }
=======
  final PrimaryButtonVariant variant;
  final bool isLoading;
  final bool isEnabled;
  final Widget? icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final bool canPress = isEnabled && !isLoading && onPressed != null;

    return SizedBox(
      width: width ?? double.infinity,
      child: switch (variant) {
        PrimaryButtonVariant.filled    => _buildFilled(canPress),
        PrimaryButtonVariant.outlined  => _buildOutlined(canPress),
        PrimaryButtonVariant.danger    => _buildColored(AppColors.error, canPress),
        PrimaryButtonVariant.success   => _buildColored(AppColors.success, canPress),
      },
    );
  }

  Widget _buildFilled(bool canPress) => ElevatedButton(
    onPressed: canPress ? onPressed : null,
    style: ElevatedButton.styleFrom(
      backgroundColor: canPress ? AppColors.primary : AppColors.disabled,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.buttonV,
        horizontal: AppSpacing.buttonH,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
    ),
    child: _buildChild(),
  );

  Widget _buildOutlined(bool canPress) => OutlinedButton(
    onPressed: canPress ? onPressed : null,
    style: OutlinedButton.styleFrom(
      foregroundColor: canPress ? AppColors.primary : AppColors.disabled,
      side: BorderSide(
        color: canPress ? AppColors.primary : AppColors.disabled,
        width: 1.5,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.buttonV,
        horizontal: AppSpacing.buttonH,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
    ),
    child: _buildChild(isOutlined: true),
  );

  Widget _buildColored(Color color, bool canPress) => ElevatedButton(
    onPressed: canPress ? onPressed : null,
    style: ElevatedButton.styleFrom(
      backgroundColor: canPress ? color : AppColors.disabled,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.buttonV,
        horizontal: AppSpacing.buttonH,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
    ),
    child: _buildChild(),
  );

  Widget _buildChild({bool isOutlined = false}) {
    if (isLoading) {
      return SizedBox(
        height: 18,
        width: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: isOutlined ? AppColors.primary : Colors.white,
        ),
      );
    }
    final style = AppTextStyles.button.copyWith(
      color: isOutlined ? AppColors.primary : Colors.white,
    );
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: AppSpacing.sm),
          Text(label.toUpperCase(), style: style),
        ],
      );
    }
    return Text(label.toUpperCase(), style: style);
  }
>>>>>>> 358d57ba1357f30f64afa2c4e1ad017fde59e106
}
