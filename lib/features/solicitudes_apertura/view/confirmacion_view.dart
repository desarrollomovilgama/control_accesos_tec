/// =============================================================================
/// confirmacion_view.dart
/// -----------------------------------------------------------------------------
/// Pantalla de confirmación tras enviar una solicitud.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';

class ConfirmacionView extends StatelessWidget {
  const ConfirmacionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmación')),
      body: Padding(
        padding: AppSpacing.paddingScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(AppIcons.success,
                size: 96, color: AppColors.success),
            AppSpacing.vGapLg,
            Text(
              'Solicitud enviada correctamente',
              textAlign: TextAlign.center,
              style: AppTypography.textTheme.headlineSmall,
            ),
            AppSpacing.vGapSm,
            Text(
              'El laboratorista recibirá tu solicitud en su panel web.',
              textAlign: TextAlign.center,
              style: AppTypography.textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            AppSpacing.vGapXxl,
            PrimaryButton(
              label: 'Cerrar',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
