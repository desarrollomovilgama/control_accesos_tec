/// =============================================================================
/// usuario_model.dart
/// -----------------------------------------------------------------------------
/// Modelo del usuario autenticado. Apartado 4.1 (Model) del MPF.
/// =============================================================================
library;

enum TipoUsuario { alumno, docente, laboratorista, desconocido }

/// Etiqueta legible del rol para mostrar en la UI (perfil, encabezados, etc.).
extension TipoUsuarioLabel on TipoUsuario {
  String get label {
    switch (this) {
      case TipoUsuario.alumno:
        return 'Estudiante';
      case TipoUsuario.docente:
        return 'Docente';
      case TipoUsuario.laboratorista:
        return 'Laboratorista';
      case TipoUsuario.desconocido:
        return 'Sin rol';
    }
  }
}

class Usuario {
  const Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.tipo,
    this.carrera,
    this.grupo,
  });

  final String id;
  final String nombre;
  final String correo;
  final TipoUsuario tipo;

  /// Solo aplica para estudiantes (ej. "Ing. en Sistemas Computacionales").
  final String? carrera;

  /// Solo aplica para estudiantes (ej. "ISC-8A").
  final String? grupo;

  bool get esAlumno => tipo == TipoUsuario.alumno;
  bool get esDocente => tipo == TipoUsuario.docente;
  bool get esLaboratorista => tipo == TipoUsuario.laboratorista;

  /// Ejemplo demostrativo (NO usar en producción).
  factory Usuario.demo() => const Usuario(
        id: '0',
        nombre: 'Usuario Demo',
        correo: 'demo@toluca.tecnm.mx',
        tipo: TipoUsuario.alumno,
      );
}
