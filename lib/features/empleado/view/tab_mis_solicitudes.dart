/// @file    tab_mis_solicitudes.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tab de solicitudes de visita — panel del Empleado.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';

import '../../../core/config/app_spacing.dart';
import '../../../core/config/app_text_styles.dart';
import '../widgets/solicitud_card.dart';

class TabMisSolicitudes extends StatelessWidget {
  const TabMisSolicitudes({super.key});

  static const _solicitudes = [
    {
      'visitante' : 'Carlos Mejía',
      'empresa'   : 'SoftTech S.A.',
      'fecha'     : 'Hoy 10:00',
      'estado'    : 'pendiente',
    },
    {
      'visitante' : 'Laura Torres',
      'empresa'   : 'Auditores MX',
      'fecha'     : 'Ayer 14:00',
      'estado'    : 'aprobada',
    },
    {
      'visitante' : 'Roberto Fuentes',
      'empresa'   : 'IndTec',
      'fecha'     : '07/04 09:00',
      'estado'    : 'rechazada',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenH,
        AppSpacing.screenH,
        AppSpacing.screenH,
        80, // espacio para el FAB
      ),
      itemCount: _solicitudes.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.listItemGap),
      itemBuilder: (ctx, i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: Text('Mis solicitudes', style: AppTextStyles.subtitle),
          );
        }
        final s = _solicitudes[i - 1];
        return SolicitudEmpleadoCard(
          visitante : s['visitante']!,
          empresa   : s['empresa']!,
          fecha     : s['fecha']!,
          estado    : s['estado']!,
        );
      },
    );
  }
}
