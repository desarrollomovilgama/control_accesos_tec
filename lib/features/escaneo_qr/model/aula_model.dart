/// =============================================================================
/// aula_model.dart
/// -----------------------------------------------------------------------------
/// Modelo del aula y su horario. Apartado 4.1 (Model) del MPF.
/// =============================================================================
library;

class Aula {
  const Aula({
    required this.codigo,
    required this.edificio,
    required this.tipo,
  });

  final String codigo;
  final String edificio;
  final TipoAula tipo;

  bool get esLaboratorio => tipo == TipoAula.laboratorio;
}

enum TipoAula { regular, laboratorio }

class ClaseHorario {
  const ClaseHorario({
    required this.materia,
    required this.docente,
    required this.grupo,
    required this.horaInicio,
    required this.horaFin,
    this.estatus = EstatusClase.clase,
  });

  final String materia;
  final String docente;
  final String grupo;
  final String horaInicio;
  final String horaFin;
  final EstatusClase estatus;

  String get horarioCompleto => '$horaInicio — $horaFin';
}

enum EstatusClase { clase, comision, junta, incapacidad, permiso, otro }
