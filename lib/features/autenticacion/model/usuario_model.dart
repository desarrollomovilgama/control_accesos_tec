/// =============================================================================
/// usuario_model.dart
/// -----------------------------------------------------------------------------
/// Modelo del usuario autenticado. Apartado 4.1 (Model) del MPF.
/// =============================================================================
library;

enum TipoUsuario { alumno, docente, laboratorista, desconocido }

class Usuario {
  const Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.tipo,
  });

  final String id;
  final String nombre;
  final String correo;
  final TipoUsuario tipo;

  /// Ejemplo demostrativo (NO usar en producción).
  factory Usuario.demo() => const Usuario(
        id: '0',
        nombre: 'Usuario Demo',
        correo: 'demo@toluca.tecnm.mx',
        tipo: TipoUsuario.alumno,
      );
}
