/// =============================================================================
/// materia_resultado.dart
/// -----------------------------------------------------------------------------
/// Tarjeta de resultado para una materia.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../model/resultado_busqueda.dart';

class MateriaResultadoCard extends StatelessWidget {
  const MateriaResultadoCard({super.key, required this.materia});

  final ResultadoMateria materia;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.accent.withValues(alpha: 0.15),
          child: const Icon(AppIcons.subject, color: AppColors.accent),
        ),
        title: Text(materia.nombre,
            style: AppTypography.textTheme.titleMedium),
        subtitle: Text(
          'Grupo ${materia.grupo} • ${materia.horario}\nAula ${materia.aula}',
          style: AppTypography.textTheme.bodySmall,
        ),
        isThreeLine: true,
      ),
    );
  }
}
