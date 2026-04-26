/// =============================================================================
/// horario_lista.dart
/// -----------------------------------------------------------------------------
/// Lista vertical de clases del día asociadas a un aula.
/// Reutilizado en aula_info_view y aula_detalle_view.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../model/aula_model.dart';

class HorarioLista extends StatelessWidget {
  const HorarioLista({super.key, required this.clases});

  final List<ClaseHorario> clases;

  @override
  Widget build(BuildContext context) {
    if (clases.isEmpty) {
      return Padding(
        padding: AppSpacing.paddingScreen,
        child: Text(
          'No hay clases registradas para este día.',
          style: AppTypography.textTheme.bodyMedium,
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: clases.length,
      separatorBuilder: (_, __) => AppSpacing.vGapSm,
      itemBuilder: (_, i) => _Item(clase: clases[i]),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.clase});

  final ClaseHorario clase;

  Color get _color {
    switch (clase.estatus) {
      case EstatusClase.clase:
        return AppColors.statusClase;
      case EstatusClase.junta:
        return AppColors.statusJunta;
      case EstatusClase.comision:
        return AppColors.statusComision;
      case EstatusClase.incapacidad:
        return AppColors.statusIncapacidad;
      case EstatusClase.permiso:
      case EstatusClase.otro:
        return AppColors.statusOtro;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.paddingCard,
        child: Row(
          children: [
            Container(
              width: 4,
              height: 48,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(clase.materia,
                      style: AppTypography.textTheme.titleMedium),
                  AppSpacing.vGapXs,
                  Text(
                    '${clase.docente}  •  Grupo ${clase.grupo}',
                    style: AppTypography.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            AppSpacing.hGapSm,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(AppIcons.schedule,
                    size: 16, color: AppColors.textSecondary),
                AppSpacing.vGapXs,
                Text(
                  clase.horarioCompleto,
                  style: AppTypography.textTheme.labelMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
