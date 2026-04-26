/// =============================================================================
/// solicitud_view.dart
/// -----------------------------------------------------------------------------
/// Vista de solicitud de apertura/cierre de un laboratorio.
/// Recibe el código del laboratorio como argumento (Figura 47 del MPF).
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../model/solicitud_model.dart';
import '../viewmodel/solicitud_viewmodel.dart';
import '../widgets/solicitud_card.dart';

class SolicitudView extends StatelessWidget {
  const SolicitudView({super.key, required this.codigoLab});

  final String codigoLab;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SolicitudViewModel(),
      child: _Scaffold(codigoLab: codigoLab),
    );
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({required this.codigoLab});

  final String codigoLab;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<SolicitudViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Solicitud de apertura')),
      body: ListView(
        padding: AppSpacing.paddingScreen,
        children: [
          Text('Tipo de solicitud',
              style: AppTypography.textTheme.titleMedium),
          AppSpacing.vGapSm,
          SegmentedButton<TipoSolicitud>(
            segments: const [
              ButtonSegment(
                value: TipoSolicitud.apertura,
                label: Text('Apertura'),
                icon: Icon(AppIcons.doorOpen),
              ),
              ButtonSegment(
                value: TipoSolicitud.cierre,
                label: Text('Cierre'),
                icon: Icon(AppIcons.doorClosed),
              ),
            ],
            selected: {vm.tipo},
            onSelectionChanged: (s) => vm.cambiarTipo(s.first),
          ),
          AppSpacing.vGapXl,
          SolicitudCard(
            codigoLab: codigoLab,
            docente: 'Mtro. Mauro Sánchez',
            grupo: 'ISC-8B',
            materia: 'Programación Móvil',
          ),
          AppSpacing.vGapXxl,
          PrimaryButton(
            label: 'Confirmar solicitud',
            icon: AppIcons.success,
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(RouteNames.confirmacionSolicitud),
          ),
        ],
      ),
    );
  }
}
