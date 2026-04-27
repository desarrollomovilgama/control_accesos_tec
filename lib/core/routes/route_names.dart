/// =============================================================================
/// route_names.dart
/// -----------------------------------------------------------------------------
/// Constantes con los nombres de todas las rutas. Apartado 4.2 del MPF
/// (Navegación entre vistas, Figuras 45-49). Centralizar nombres evita
/// strings sueltos repartidos por el proyecto.
/// =============================================================================
library;

class RouteNames {
  RouteNames._();

  // Splash & Autenticación
  static const String splash = '/';
  static const String login = '/login';

  // Shell con BottomNavigationBar
  static const String home = '/home';

  // Escaneo QR
  static const String qrScanner = '/qr/scanner';
  static const String aulaInfo = '/qr/aula';
  static const String sinConexion = '/qr/sin-conexion';

  // Consulta de aulas
  static const String consultaAulas = '/aulas';
  static const String aulaDetalle = '/aulas/detalle';
  static const String agregarAula = '/aulas/nueva';

  // Búsqueda
  static const String busqueda = '/buscar';
  static const String resultadosBusqueda = '/buscar/resultados';

  // Estatus docente
  static const String registroEstatus = '/estatus/registro';
  static const String listaEstatus = '/estatus/lista';

  // Solicitudes de apertura
  static const String solicitudApertura = '/solicitudes/nueva';
  static const String confirmacionSolicitud = '/solicitudes/confirmacion';

  // Perfil
  static const String perfil = '/perfil';
}
