/// =============================================================================
/// solicitud_card.dart
/// -----------------------------------------------------------------------------
/// Tarjeta resumen con los datos a confirmar antes de enviar la solicitud.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SolicitudCard extends StatelessWidget {
  const SolicitudCard({
    super.key,
    required this.codigoLab,
    required this.docente,
    required this.grupo,
    required this.materia,
  });

  final String codigoLab;
  final String docente;
  final String grupo;
  final String materia;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Linea(
                icon: AppIcons.laboratory, label: 'Laboratorio', value: codigoLab),
            const Divider(height: 24),
            _Linea(icon: AppIcons.teacher, label: 'Docente', value: docente),
            const Divider(height: 24),
            _Linea(icon: AppIcons.subject, label: 'Materia', value: materia),
            const Divider(height: 24),
            _Linea(
                icon: AppIcons.clipboardList, label: 'Grupo', value: grupo),
          ],
        ),
      ),
    );
  }
}

class _Linea extends StatelessWidget {
  const _Linea({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        AppSpacing.hGapMd,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: AppTypography.textTheme.labelMedium?.copyWith(
                    color: AppColors.textSecondary,
                  )),
              Text(value, style: AppTypography.textTheme.titleMedium),
            ],
          ),
        ),
      ],
    );
  }
}
