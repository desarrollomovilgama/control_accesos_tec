/// =============================================================================
/// docente_resultado.dart
/// -----------------------------------------------------------------------------
/// Tarjeta de resultado para un docente.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../model/resultado_busqueda.dart';

class DocenteResultadoCard extends StatelessWidget {
  const DocenteResultadoCard({super.key, required this.docente});

  final ResultadoDocente docente;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.paddingCard,
        child: Row(
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.primary,
              child: Icon(AppIcons.teacher, color: AppColors.textOnPrimary),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(docente.nombre,
                      style: AppTypography.textTheme.titleMedium),
                  AppSpacing.vGapXs,
                  if (docente.tieneClase)
                    Text(
                      '${docente.materia} • Aula ${docente.aula}',
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.statusClase,
                      ),
                    )
                  else
                    Text(
                      'Sin información de clase disponible',
                      style: AppTypography.textTheme.bodySmall?.copyWith(
                        color: AppColors.textHint,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
