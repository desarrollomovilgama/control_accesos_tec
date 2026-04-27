/// @file    app_colors.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Paleta de colores institucional — GAMA MPF v1.0
/// Referencia: Tablas 4, 5, 6 y 7 del Manual de Programación Flutter
library;

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Colores principales (Tabla 4) ─────────────────────────────────
  /// Deep Corporate Blue — AppBars, encabezados, botones principales
  static const Color primary = Color(0xFF134474);

  /// Royal Blue — Botones de acción principal (CTA)
  static const Color secondary = Color(0xFF1E5A8A);

  /// Soft Steel Blue — Fondos de tarjetas y UI secundario
  static const Color tertiary = Color(0xFF5F86A6);

  /// Ice Blue — Fondos generales, contenedores, formularios
  static const Color iceBlue = Color(0xFFF2F7FB);

  /// Mist Blue — Separadores, fondos suaves, alertas informativas
  static const Color mistBlue = Color(0xFFE3EDF5);

  /// Dark Graphite — Párrafos y texto general
  static const Color textMain = Color(0xFF545454);

  /// Midnight — Títulos y texto sobre fondos claros
  static const Color textContrast = Color(0xFF1F2A35);

  // ── Elementos de interfaz (Tabla 6) ───────────────────────────────
  /// Fondo general del Scaffold
  static const Color appBackground = Color(0xFFFFFFFF);

  /// Bordes de campos, divisores entre elementos
  static const Color borderGray = Color(0xFFE0E0E0);

  /// Botones, campos e íconos en estado deshabilitado
  static const Color disabled = Color(0xFFBDBDBD);

  /// Íconos secundarios y de navegación general
  static const Color iconGray = Color(0xFF757575);

  // ── Acentos de interacción (Tabla 5) ──────────────────────────────
  /// Corporate Orange — Hover en menú y botones interactivos
  static const Color orange = Color(0xFFF28B2C);

  /// Deep Orange Accent — Estado activo en menú y botones
  static const Color orangeActive = Color(0xFFD96A10);

  // ── Estados del sistema (Tabla 7) ─────────────────────────────────
  static const Color error   = Color(0xFFD32F2F);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color info    = Color(0xFF1565C0);

  // ── Fondos de estados (backgrounds) ───────────────────────────────
  static const Color errorBg   = Color(0xFFFFEBEE);
  static const Color successBg = Color(0xFFE8F5E9);
  static const Color warningBg = Color(0xFFFFF8E1);
  static const Color infoBg    = Color(0xFFE3F2FD);
}
