/// =============================================================================
/// aula_card.dart
/// -----------------------------------------------------------------------------
/// Tarjeta resumida de un aula dentro de la lista de consulta.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../model/horario_model.dart';

class AulaCard extends StatelessWidget {
  const AulaCard({super.key, required this.aula, required this.onTap});

  final AulaResumen aula;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: aula.ocupada
              ? AppColors.error.withValues(alpha: 0.12)
              : AppColors.success.withValues(alpha: 0.12),
          child: Icon(
            AppIcons.classroom,
            color: aula.ocupada ? AppColors.error : AppColors.success,
          ),
        ),
        title: Text('Aula ${aula.codigo}',
            style: AppTypography.textTheme.titleMedium),
        subtitle: Text(
          aula.ocupada
              ? 'Ocupada${aula.materiaActual != null ? " • ${aula.materiaActual}" : ""}'
              : 'Disponible',
          style: AppTypography.textTheme.bodySmall,
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
