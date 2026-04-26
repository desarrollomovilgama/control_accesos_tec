/// =============================================================================
/// loading_state.dart
/// -----------------------------------------------------------------------------
/// Estado visual de carga. Figura 42 del MPF.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../spacing/app_spacing.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key, this.message = 'Cargando...'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          AppSpacing.vGapMd,
          Text(
            message,
            style: AppTypography.textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
