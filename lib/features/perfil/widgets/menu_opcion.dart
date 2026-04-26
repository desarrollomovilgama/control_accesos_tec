/// =============================================================================
/// menu_opcion.dart
/// -----------------------------------------------------------------------------
/// Item del menú de opciones del perfil.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class MenuOpcion extends StatelessWidget {
  const MenuOpcion({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: color ?? AppColors.primary),
        title: Text(
          label,
          style: AppTypography.textTheme.titleMedium?.copyWith(color: color),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
