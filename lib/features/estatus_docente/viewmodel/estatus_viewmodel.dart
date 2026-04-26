/// =============================================================================
/// estatus_viewmodel.dart
/// -----------------------------------------------------------------------------
/// ViewModel para registro y listado de estatus del docente.
/// =============================================================================
library;

import 'package:flutter/foundation.dart';

import '../model/estatus_model.dart';

class EstatusViewModel extends ChangeNotifier {
  TipoEstatus _tipoSeleccionado = TipoEstatus.clase;
  DateTime? _fechaInicio;
  DateTime? _fechaFin;
  final List<EstatusDocente> _historial = [
    EstatusDocente(
      tipo: TipoEstatus.junta,
      fechaInicio: DateTime.now().subtract(const Duration(days: 5)),
      fechaFin: DateTime.now().subtract(const Duration(days: 5)),
      observaciones: 'Junta de academia',
    ),
  ];

  TipoEstatus get tipoSeleccionado => _tipoSeleccionado;
  DateTime? get fechaInicio => _fechaInicio;
  DateTime? get fechaFin => _fechaFin;
  List<EstatusDocente> get historial => List.unmodifiable(_historial);

  void seleccionarTipo(TipoEstatus t) {
    _tipoSeleccionado = t;
    notifyListeners();
  }

  void cambiarFechaInicio(DateTime d) {
    _fechaInicio = d;
    notifyListeners();
  }

  void cambiarFechaFin(DateTime d) {
    _fechaFin = d;
    notifyListeners();
  }

  bool get esValido =>
      _fechaInicio != null &&
      _fechaFin != null &&
      !_fechaFin!.isBefore(_fechaInicio!);

  void registrar() {
    if (!esValido) return;
    _historial.insert(
      0,
      EstatusDocente(
        tipo: _tipoSeleccionado,
        fechaInicio: _fechaInicio!,
        fechaFin: _fechaFin!,
      ),
    );
    _fechaInicio = null;
    _fechaFin = null;
    _tipoSeleccionado = TipoEstatus.clase;
    notifyListeners();
  }
}
