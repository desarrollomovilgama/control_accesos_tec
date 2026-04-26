/// =============================================================================
/// estatus_model.dart
/// -----------------------------------------------------------------------------
/// Modelo del estatus reportado por un docente.
/// =============================================================================
library;

enum TipoEstatus { clase, comision, junta, incapacidad, permiso, otro }

extension TipoEstatusX on TipoEstatus {
  String get label {
    switch (this) {
      case TipoEstatus.clase:
        return 'Clase';
      case TipoEstatus.comision:
        return 'Comisión';
      case TipoEstatus.junta:
        return 'Junta';
      case TipoEstatus.incapacidad:
        return 'Incapacidad';
      case TipoEstatus.permiso:
        return 'Permiso económico';
      case TipoEstatus.otro:
        return 'Otro';
    }
  }
}

class EstatusDocente {
  const EstatusDocente({
    required this.tipo,
    required this.fechaInicio,
    required this.fechaFin,
    this.observaciones,
  });

  final TipoEstatus tipo;
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String? observaciones;
}
