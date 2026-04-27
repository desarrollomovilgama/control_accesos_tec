/// =============================================================================
/// docente_actual_card.dart
/// -----------------------------------------------------------------------------
/// Tarjeta destacada que se muestra al estudiante después de escanear un QR.
/// Indica de un vistazo qué docente está impartiendo clase en ese momento,
/// la materia, el grupo y el horario.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../model/aula_model.dart';

class DocenteActualCard extends StatelessWidget {
  const DocenteActualCard({super.key, required this.clase});

  final ClaseHorario clase;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primary,
      child: Padding(
        padding: AppSpacing.paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.white.withValues(alpha: 0.18),
                  child: const Icon(
                    AppIcons.teacher,
                    color: Colors.white,
                  ),
                ),
                AppSpacing.hGapMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clase.docente,
                        style: AppTypography.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        clase.materia,
                        style: AppTypography.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.vGapMd,
            Row(
              children: [
                _MiniInfo(
                  icon: AppIcons.schedule,
                  text: '${clase.horaInicio} – ${clase.horaFin}',
                ),
                AppSpacing.hGapLg,
                _MiniInfo(icon: AppIcons.student, text: clase.grupo),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  const _MiniInfo({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withValues(alpha: 0.85), size: 16),
        AppSpacing.hGapXs,
        Text(
          text,
          style: AppTypography.textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
