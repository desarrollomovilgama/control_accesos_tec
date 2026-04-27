/// =============================================================================
/// aula_info_view.dart
/// -----------------------------------------------------------------------------
/// Vista mostrada tras escanear un QR exitoso. Recibe el código del aula
/// como parámetro (Figura 47 del MPF) y muestra horario del día.
///
/// La UI se adapta al rol del usuario actual (apartado 4.3 del MPF):
///   - Estudiante: ve "Docente actual" destacado y todo el horario.
///   - Docente / Laboratorista: ve además el botón "Solicitar apertura".
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/routes/route_names.dart';
import '../../../core/session/session_service.dart';
import '../../../core/spacing/app_spacing.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/primary_button.dart';
import '../model/aula_model.dart';
import '../widgets/docente_actual_card.dart';
import '../widgets/horario_lista.dart';

class AulaInfoView extends StatelessWidget {
  const AulaInfoView({super.key, required this.codigoAula});

  final String codigoAula;

  static const _clasesDemo = <ClaseHorario>[
    ClaseHorario(
      materia: 'Auditoría Informática',
      docente: 'Mtro. Gamaliel Castro González',
      grupo: 'ISC-8A',
      horaInicio: '09:00',
      horaFin: '11:00',
      estatus: EstatusClase.clase,
    ),
    ClaseHorario(
      materia: 'Inteligencia Artificial',
      docente: 'Dra. Mariana López',
      grupo: 'ISC-8A',
      horaInicio: '11:00',
      horaFin: '13:00',
      estatus: EstatusClase.clase,
    ),
    ClaseHorario(
      materia: 'Programación Móvil',
      docente: 'Mtro. Mauro Sánchez',
      grupo: 'ISC-8B',
      horaInicio: '13:00',
      horaFin: '15:00',
      estatus: EstatusClase.junta,
    ),
  ];

  /// Selección demo de la clase "actual". En el WS real se calculará por hora.
  /// Es `static final` (no `const`) porque indexar una lista `const` no es
  /// una expresión constante en Dart.
  static final ClaseHorario _claseActualDemo = _clasesDemo[1];

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionService>();
    final esAlumno = session.esAlumno;
    final puedeSolicitarApertura = !esAlumno;

    return Scaffold(
      appBar: AppBar(title: Text('Aula $codigoAula')),
      body: ListView(
        padding: AppSpacing.paddingScreen,
        children: [
          _Encabezado(codigo: codigoAula),
          AppSpacing.vGapLg,
          if (esAlumno) ...[
            Text('Docente en este momento',
                style: AppTypography.textTheme.titleLarge),
            AppSpacing.vGapMd,
            DocenteActualCard(clase: _claseActualDemo),
            AppSpacing.vGapXl,
          ],
          Text('Horario del día',
              style: AppTypography.textTheme.titleLarge),
          AppSpacing.vGapMd,
          const HorarioLista(clases: _clasesDemo),
          if (puedeSolicitarApertura) ...[
            AppSpacing.vGapXl,
            PrimaryButton(
              label: 'Solicitar apertura (laboratorio)',
              icon: AppIcons.doorOpen,
              onPressed: () => Navigator.of(context).pushNamed(
                RouteNames.solicitudApertura,
                arguments: <String, dynamic>{'codigoLab': codigoAula},
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  const _Encabezado({required this.codigo});

  final String codigo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: AppSpacing.paddingCard,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                AppIcons.classroom,
                color: AppColors.primary,
                size: 32,
              ),
            ),
            AppSpacing.hGapMd,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Aula $codigo',
                      style: AppTypography.textTheme.headlineSmall),
                  Text(
                    'Edificio F • Piso 2',
                    style: AppTypography.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
