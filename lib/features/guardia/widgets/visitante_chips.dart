/// @file    visitante_chips.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Chips de resumen y filtro para la lista de visitantes del Guardia.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_spacing.dart';
import '../../../../core/config/app_text_styles.dart';

/// Chip de resumen con contador numérico (fila superior de stats).
class ResChip extends StatelessWidget {
  const ResChip({
    super.key,
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int    count;
  final Color  color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(children: [
          Text('$count',
              style: AppTextStyles.title.copyWith(color: color, fontSize: 20)),
          Text(label,
              style: AppTextStyles.caption,
              overflow: TextOverflow.ellipsis),
        ]),
      ),
    );
  }
}

/// Chip de filtro seleccionable.
class FiltroChip extends StatelessWidget {
  const FiltroChip({
    super.key,
    required this.label,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  final String       label;
  final bool         selected;
  final Color        color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: selected ? color.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? color : AppColors.borderGray),
        ),
        child: Text(
          label,
          style: AppTextStyles.captionBold.copyWith(
              color: selected ? color : AppColors.iconGray),
        ),
      ),
    );
  }
}
