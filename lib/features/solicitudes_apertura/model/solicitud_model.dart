/// =============================================================================
/// solicitud_model.dart
/// -----------------------------------------------------------------------------
/// Modelo de una solicitud de apertura/cierre de laboratorio.
/// =============================================================================
library;

enum TipoSolicitud { apertura, cierre }
enum EstadoSolicitud { enviada, aceptada, rechazada, pendiente }

class SolicitudApertura {
  const SolicitudApertura({
    required this.codigoLab,
    required this.docente,
    required this.grupo,
    required this.tipo,
    required this.estado,
    required this.creadaEn,
  });

  final String codigoLab;
  final String docente;
  final String grupo;
  final TipoSolicitud tipo;
  final EstadoSolicitud estado;
  final DateTime creadaEn;
}
