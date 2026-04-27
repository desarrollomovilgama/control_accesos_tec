/// =============================================================================
/// qr_scanner_view.dart
/// -----------------------------------------------------------------------------
/// Vista de escaneo QR.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/qr_overlay.dart';

class QrScannerView extends StatelessWidget {
  const QrScannerView({super.key});

  void _simular(BuildContext context) {
    Navigator.of(context).pushNamed(
      RouteNames.aulaInfo,
      arguments: <String, dynamic>{'codigoAula': 'F-203'},
    );
  }

  @override
  Widget build(BuildContext context) {
    // Se envuelve en un Scaffold para asegurar que tenga su propio fondo
    // y no se vea "transparente" o en blanco si se navega como ruta completa.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Código'),
      ),
      body: Padding(
        padding: AppSpacing.paddingScreen,
        child: Column(
          children: [
            Text(
              'Coloca el código QR de la puerta del aula dentro del recuadro.',
              style: AppTypography.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            AppSpacing.vGapLg,
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Container(
                      color: AppColors.textPrimary,
                      width: double.infinity,
                      child: const Center(
                        child: Icon(
                          AppIcons.qrScan,
                          size: 80,
                          color: AppColors.surfaceVariant,
                        ),
                      ),
                    ),
                    const QrOverlay(),
                  ],
                ),
              ),
            ),
            AppSpacing.vGapLg,
            PrimaryButton(
              label: 'Simular escaneo (demo)',
              icon: AppIcons.qrScan,
              onPressed: () => _simular(context),
            ),
            AppSpacing.vGapSm,
            OutlinedButton.icon(
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteNames.busqueda),
              icon: const Icon(AppIcons.search),
              label: const Text('Búsqueda manual'),
            ),
            AppSpacing.vGapSm,
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(RouteNames.sinConexion),
              child: const Text('Probar vista "Sin conexión"'),
            ),
          ],
        ),
      ),
    );
  }
}
