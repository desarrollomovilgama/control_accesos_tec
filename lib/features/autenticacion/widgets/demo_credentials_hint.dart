/// =============================================================================
/// demo_credentials_hint.dart
/// -----------------------------------------------------------------------------
/// Tarjeta informativa con las credenciales DEMO disponibles. Cada chip
/// autorrellena los campos de usuario y contraseña al presionarse.
///
/// Solo es útil mientras la app esté en modo maqueta. Antes de pasar a
/// producción, este widget debe eliminarse del LoginView.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/auth/credenciales_demo.dart';
import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class DemoCredentialsHint extends StatelessWidget {
  const DemoCredentialsHint({
    super.key,
    required this.userCtrl,
    required this.passCtrl,
  });

  final TextEditingController userCtrl;
  final TextEditingController passCtrl;

  void _autollenar(CredencialDemo c) {
    userCtrl.text = c.correo;
    passCtrl.text = c.password;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingCard,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(AppIcons.info, color: AppColors.primary, size: 18),
              AppSpacing.hGapSm,
              Expanded(
                child: Text(
                  'Credenciales DEMO',
                  style: AppTypography.textTheme.titleSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.vGapXs,
          Text(
            'Toca un rol para autorrellenar los campos.',
            style: AppTypography.textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.vGapMd,
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: kCredencialesDemo.map((c) {
              return ActionChip(
                avatar: Icon(
                  _iconoPorDescripcion(c.descripcion),
                  size: 16,
                  color: AppColors.primary,
                ),
                label: Text(c.descripcion),
                onPressed: () => _autollenar(c),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  IconData _iconoPorDescripcion(String d) {
    switch (d) {
      case 'Estudiante':
        return AppIcons.student;
      case 'Docente':
        return AppIcons.teacher;
      case 'Laboratorista':
        return AppIcons.lab;
      default:
        return AppIcons.info;
    }
  }
}
