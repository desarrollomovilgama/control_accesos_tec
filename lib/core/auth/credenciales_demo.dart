/// =============================================================================
/// credenciales_demo.dart
/// -----------------------------------------------------------------------------
/// Catálogo de credenciales DEMO para la maqueta del Sistema de Control de
/// Aulas. Solo se usa mientras no exista la integración real con el WS SAM.
///
/// IMPORTANTE: Todas las cuentas usan el dominio institucional
/// @toluca.tecnm.mx (apartado 7.2 del MPF — política de credenciales).
/// =============================================================================
library;

import '../../features/autenticacion/model/usuario_model.dart';

/// Dominio institucional obligatorio para iniciar sesión en la app.
const String kDominioInstitucional = '@toluca.tecnm.mx';

/// Tupla simple de credencial demo (correo + contraseña + perfil asociado).
class CredencialDemo {
  const CredencialDemo({
    required this.correo,
    required this.password,
    required this.usuario,
    required this.descripcion,
  });

  final String correo;
  final String password;
  final Usuario usuario;

  /// Texto corto para mostrar en los chips del login (ej. "Estudiante").
  final String descripcion;
}

/// Catálogo de credenciales DEMO disponibles.
/// El primer elemento de cada rol es el que se sugiere por defecto.
const List<CredencialDemo> kCredencialesDemo = <CredencialDemo>[
  // -------------------------------- Estudiante -------------------------------
  CredencialDemo(
    correo: 'l22280352@toluca.tecnm.mx',
    password: 'estudiante123',
    descripcion: 'Estudiante',
    usuario: Usuario(
      id: 'AL-22280352',
      nombre: 'Juan Pérez Hernández',
      correo: 'l22280352@toluca.tecnm.mx',
      tipo: TipoUsuario.alumno,
      carrera: 'Ing. en Sistemas Computacionales',
      grupo: 'ISC-8A',
    ),
  ),
  // ---------------------------------- Docente --------------------------------
  CredencialDemo(
    correo: 'gcastro@toluca.tecnm.mx',
    password: 'docente123',
    descripcion: 'Docente',
    usuario: Usuario(
      id: 'DOC-001',
      nombre: 'Mtro. Gamaliel Castro González',
      correo: 'gcastro@toluca.tecnm.mx',
      tipo: TipoUsuario.docente,
    ),
  ),
  // ------------------------------ Laboratorista ------------------------------
  CredencialDemo(
    correo: 'lab.computo@toluca.tecnm.mx',
    password: 'labo123',
    descripcion: 'Laboratorista',
    usuario: Usuario(
      id: 'LAB-001',
      nombre: 'Ing. Laura Mendoza Ruiz',
      correo: 'lab.computo@toluca.tecnm.mx',
      tipo: TipoUsuario.laboratorista,
    ),
  ),
];

/// Busca una credencial por correo+contraseña. Devuelve null si no existe.
CredencialDemo? buscarCredencial({
  required String correo,
  required String password,
}) {
  final correoNorm = correo.trim().toLowerCase();
  for (final c in kCredencialesDemo) {
    if (c.correo.toLowerCase() == correoNorm && c.password == password) {
      return c;
    }
  }
  return null;
}

/// Indica si el correo tiene el dominio institucional permitido.
bool tieneDominioInstitucional(String correo) {
  return correo.trim().toLowerCase().endsWith(kDominioInstitucional);
}
