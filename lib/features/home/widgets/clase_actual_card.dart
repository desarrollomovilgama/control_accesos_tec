/// =============================================================================
/// clase_actual_card.dart
/// -----------------------------------------------------------------------------
/// Tarjeta resumen de la "clase en curso" mostrada en la pestaña Inicio.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class ClaseActualCard extends StatelessWidget {
  const ClaseActualCard({
    super.key,
    required this.materia,
    required this.docente,
    required this.aula,
    required this.horario,
  });

  final String materia;
  final String docente;
  final String aula;
  final String horario;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    AppIcons.classroom,
                    color: AppColors.primary,
                  ),
                ),
                AppSpacing.hGapMd,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(materia,
                          style: AppTypography.textTheme.titleMedium),
                      Text(
                        'Aula $aula',
                        style: AppTypography.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSpacing.vGapMd,
            const Divider(height: 1),
            AppSpacing.vGapMd,
            _Info(icon: AppIcons.teacher, text: docente),
            AppSpacing.vGapSm,
            _Info(icon: AppIcons.schedule, text: horario),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.textSecondary),
        AppSpacing.hGapSm,
        Expanded(
          child: Text(text, style: AppTypography.textTheme.bodyMedium),
        ),
      ],
    );
  }
}
