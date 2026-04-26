/// =============================================================================
/// resultado_busqueda.dart
/// -----------------------------------------------------------------------------
/// Modelos de resultado para la búsqueda multi-tipo.
/// =============================================================================
library;

class ResultadoDocente {
  const ResultadoDocente({
    required this.nombre,
    required this.tieneClase,
    this.aula,
    this.materia,
  });

  final String nombre;
  final bool tieneClase;
  final String? aula;
  final String? materia;
}

class ResultadoMateria {
  const ResultadoMateria({
    required this.nombre,
    required this.grupo,
    required this.aula,
    required this.horario,
  });

  final String nombre;
  final String grupo;
  final String aula;
  final String horario;
}

class ResultadoAula {
  const ResultadoAula({
    required this.codigo,
    required this.edificio,
    required this.disponible,
  });

  final String codigo;
  final String edificio;
  final bool disponible;
}
