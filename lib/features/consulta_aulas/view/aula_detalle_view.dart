/// =============================================================================
/// aula_detalle_view.dart
/// -----------------------------------------------------------------------------
/// Detalle de un aula (recibe código por argumentos). Reutiliza el widget
/// HorarioLista del feature de Escaneo QR.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../escaneo_qr/model/aula_model.dart';
import '../../escaneo_qr/widgets/horario_lista.dart';

class AulaDetalleView extends StatelessWidget {
  const AulaDetalleView({super.key, required this.codigoAula});

  final String codigoAula;

  static const _clases = <ClaseHorario>[
    ClaseHorario(
      materia: 'Bases de Datos',
      docente: 'Dr. Juan Pérez',
      grupo: 'ISC-6A',
      horaInicio: '07:00',
      horaFin: '09:00',
    ),
    ClaseHorario(
      materia: 'Auditoría Informática',
      docente: 'Mtro. Gamaliel Castro',
      grupo: 'ISC-8A',
      horaInicio: '11:00',
      horaFin: '13:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Aula $codigoAula')),
      body: ListView(
        padding: AppSpacing.paddingScreen,
        children: [
          Text('Horario del día',
              style: AppTypography.textTheme.titleLarge),
          AppSpacing.vGapMd,
          const HorarioLista(clases: _clases),
        ],
      ),
    );
  }
}
