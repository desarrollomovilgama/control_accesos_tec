/// =============================================================================
/// rango_fechas.dart
/// -----------------------------------------------------------------------------
/// Selector de rango de fechas (inicio / fin) para el estatus del docente.
/// =============================================================================
library;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/icons/app_icons.dart';
import '../../../core/spacing/app_spacing.dart';

class RangoFechas extends StatelessWidget {
  const RangoFechas({
    super.key,
    required this.fechaInicio,
    required this.fechaFin,
    required this.onInicio,
    required this.onFin,
  });

  final DateTime? fechaInicio;
  final DateTime? fechaFin;
  final ValueChanged<DateTime> onInicio;
  final ValueChanged<DateTime> onFin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _BotonFecha(
            label: 'Inicio',
            fecha: fechaInicio,
            onTap: () => _picker(context, fechaInicio, onInicio),
          ),
        ),
        AppSpacing.hGapMd,
        Expanded(
          child: _BotonFecha(
            label: 'Fin',
            fecha: fechaFin,
            onTap: () => _picker(context, fechaFin, onFin),
          ),
        ),
      ],
    );
  }

  Future<void> _picker(
    BuildContext context,
    DateTime? actual,
    ValueChanged<DateTime> onChanged,
  ) async {
    final result = await showDatePicker(
      context: context,
      initialDate: actual ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (result != null) onChanged(result);
  }
}

class _BotonFecha extends StatelessWidget {
  const _BotonFecha({
    required this.label,
    required this.fecha,
    required this.onTap,
  });

  final String label;
  final DateTime? fecha;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final txt =
        fecha == null ? label : DateFormat('dd/MM/yyyy').format(fecha!);
    return OutlinedButton.icon(
      onPressed: onTap,
      icon: const Icon(AppIcons.calendar, size: 18),
      label: Text(txt),
    );
  }
}
