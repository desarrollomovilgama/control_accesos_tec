/// @file    empty_state.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Widget de estado vacío reutilizable para el panel del Anfitrión.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/config/app_colors.dart';
import '../../../../core/config/app_spacing.dart';
import '../../../../core/config/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String   label;
  final Color    color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, size: 48, color: color.withOpacity(0.4)),
          const SizedBox(height: AppSpacing.md),
          Text(label,
              style: AppTextStyles.body
                  .copyWith(color: AppColors.iconGray)),
        ],
      ),
    );
  }
}
