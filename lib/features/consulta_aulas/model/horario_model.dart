/// =============================================================================
/// horario_model.dart
/// -----------------------------------------------------------------------------
/// Modelos relacionados con aulas.
/// =============================================================================
library;

/// Tipo de espacio físico que se puede registrar en el sistema.
enum TipoAula { aula, laboratorio, auditorio }

extension TipoAulaLabel on TipoAula {
  String get label {
    switch (this) {
      case TipoAula.aula:
        return 'Aula';
      case TipoAula.laboratorio:
        return 'Laboratorio';
      case TipoAula.auditorio:
        return 'Auditorio';
    }
  }
}

/// Resumen ligero de un aula utilizado en listados y detalles.
class AulaResumen {
  const AulaResumen({
    required this.codigo,
    required this.edificio,
    required this.ocupada,
    this.materiaActual,
    this.piso,
    this.capacidad,
    this.tipo = TipoAula.aula,
    this.equipamiento,
  });

  final String codigo;
  final String edificio;
  final bool ocupada;
  final String? materiaActual;

  /// Datos extendidos (provistos al registrar un aula nueva).
  final int? piso;
  final int? capacidad;
  final TipoAula tipo;
  final String? equipamiento;
}
