/// =============================================================================
/// horario_model.dart
/// -----------------------------------------------------------------------------
/// Resumen ligero de un aula utilizado en listados.
/// =============================================================================
library;

class AulaResumen {
  const AulaResumen({
    required this.codigo,
    required this.edificio,
    required this.ocupada,
    this.materiaActual,
  });

  final String codigo;
  final String edificio;
  final bool ocupada;
  final String? materiaActual;
}
