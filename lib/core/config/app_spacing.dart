/// @file    app_spacing.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Espaciado estándar — GAMA MPF v1.0
/// Referencia: Sección 5.2.3 del Manual de Programación Flutter
library;

class AppSpacing {
  AppSpacing._();

  static const double xs  = 4.0;
  static const double sm  = 8.0;   // Separación entre ítems de lista
  static const double md  = 12.0;  // Separación entre elementos (SizedBox)
  static const double lg  = 16.0;  // Padding horizontal de pantalla / entre bloques
  static const double xl  = 24.0;  // Padding interno de diálogos / botones horizontal
  static const double xxl = 32.0;

  /// Padding horizontal estándar de pantalla (Scaffold / SafeArea)
  static const double screenH = 16.0;

  /// Padding vertical estándar de pantalla
  static const double screenV = 12.0;

  /// Separación entre bloques de contenido independientes
  static const double blockGap = 16.0;

  /// Separación entre elementos dentro de un mismo bloque
  static const double elementGap = 12.0;

  /// Separación entre ítems de lista (ListView.separated)
  static const double listItemGap = 8.0;

  /// Padding interno de tarjetas
  static const double cardPadding = 16.0;

  /// Padding vertical de botón
  static const double buttonV = 12.0;

  /// Padding horizontal de botón
  static const double buttonH = 24.0;

  /// Radio de bordes estándar
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusCard = 10.0;
  static const double radiusXl  = 20.0;
}
