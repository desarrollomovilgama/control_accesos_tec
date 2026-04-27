/// @file    stat_card.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Widgets de estadísticas y perfil — perspectiva del Empleado.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_spacing.dart';
import '../../../../core/config/app_text_styles.dart';

/// Fila de información de perfil con icono.
class ProfileRow extends StatelessWidget {
  const ProfileRow({super.key, required this.icon, required this.label});

  final IconData icon;
  final String   label;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      FaIcon(icon, size: 15, color: AppColors.secondary),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: Text(label, style: AppTextStyles.body,
            overflow: TextOverflow.ellipsis),
      ),
    ]);
  }
}

/// Tarjeta de estadística numérica (Total / Aprobadas / Pendientes…).
class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label, value;
  final Color  color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.md, horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        children: [
          Text(value,
              style: AppTextStyles.title.copyWith(color: color, fontSize: 24)),
          const SizedBox(height: 2),
          Text(label,
              style: AppTextStyles.caption, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
