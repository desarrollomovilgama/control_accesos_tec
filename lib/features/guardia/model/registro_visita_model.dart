/// @file    registro_visita_model.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Modelo de datos para el registro de visita generado por el Guardia.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

class RegistroVisita {
  RegistroVisita({
    required this.nombre,
    required this.correo,
    required this.lugar,
    required this.timestamp,
  }) : id = _generarId(timestamp);

  final String   id;
  final String   nombre;
  final String   correo;
  final String   lugar;
  final DateTime timestamp;

  /// Genera un ID único basado en la fecha/hora para el registro.
  static String _generarId(DateTime dt) =>
      'VIS-${dt.year}${dt.month.toString().padLeft(2, '0')}'
      '${dt.day.toString().padLeft(2, '0')}-'
      '${dt.hour.toString().padLeft(2, '0')}'
      '${dt.minute.toString().padLeft(2, '0')}'
      '${dt.second.toString().padLeft(2, '0')}';

  /// Cadena que se codifica en el QR.
  String toQRData() =>
      'ID:$id|NOMBRE:$nombre|CORREO:$correo|LUGAR:$lugar'
      '|FECHA:${timestamp.day.toString().padLeft(2, '0')}/'
      '${timestamp.month.toString().padLeft(2, '0')}/${timestamp.year}'
      '|HORA:${timestamp.hour.toString().padLeft(2, '0')}:'
      '${timestamp.minute.toString().padLeft(2, '0')}';

  String get fechaFormateada =>
      '${timestamp.day.toString().padLeft(2, '0')}/'
      '${timestamp.month.toString().padLeft(2, '0')}/${timestamp.year}';

  String get horaFormateada =>
      '${timestamp.hour.toString().padLeft(2, '0')}:'
      '${timestamp.minute.toString().padLeft(2, '0')}';
}

/// Lugares predefinidos disponibles en el formulario.
const List<String> lugaresDisponibles = [
  'Alberca',
  'Edificio A',
  'Edificio X',
];
