/// =============================================================================
/// perfil_header.dart
/// -----------------------------------------------------------------------------
/// Encabezado del perfil con foto, nombre y rol.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class PerfilHeader extends StatelessWidget {
  const PerfilHeader({
    super.key,
    required this.nombre,
    required this.rol,
    required this.correo,
  });

  final String nombre;
  final String rol;
  final String correo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.paddingCard,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.primary,
              child: Icon(
                AppIcons.user,
                color: AppColors.textOnPrimary,
                size: 32,
              ),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nombre,
                      style: AppTypography.textTheme.titleLarge),
                  Text(rol,
                      style: AppTypography.textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      )),
                  Text(correo,
                      style: AppTypography.textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
