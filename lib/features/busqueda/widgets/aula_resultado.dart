/// =============================================================================
/// aula_resultado.dart
/// -----------------------------------------------------------------------------
/// Tarjeta de resultado para un aula.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../model/resultado_busqueda.dart';

class AulaResultadoCard extends StatelessWidget {
  const AulaResultadoCard({super.key, required this.aula, this.onTap});

  final ResultadoAula aula;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: const Icon(AppIcons.classroom, color: AppColors.primary),
        title: Text('Aula ${aula.codigo}',
            style: AppTypography.textTheme.titleMedium),
        subtitle: Text(
          'Edificio ${aula.edificio} • '
          '${aula.disponible ? "Disponible" : "Ocupada"}',
          style: AppTypography.textTheme.bodySmall?.copyWith(
            color: aula.disponible ? AppColors.success : AppColors.error,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
