/// =============================================================================
/// app_colors.dart
/// -----------------------------------------------------------------------------
/// Paleta de colores oficial del proyecto Control de Aulas.
/// Apartado 4.2 (Lineamientos de identidad visual) del MPF.
/// =============================================================================
library;

import 'package:flutter/material.dart';

/// Paleta institucional inspirada en la identidad TecNM / ITT.
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Colores principales (Tabla 4 del MPF)
  // ---------------------------------------------------------------------------
  static const Color primary = Color(0xFF1E5BA0);
  static const Color primaryLight = Color(0xFF4A8AC5);
  static const Color primaryDark = Color(0xFF143F73);

  // ---------------------------------------------------------------------------
  // Colores de acento (Tabla 5 del MPF)
  // ---------------------------------------------------------------------------
  static const Color accent = Color(0xFFE85D04);
  static const Color accentLight = Color(0xFFF48C42);

  // ---------------------------------------------------------------------------
  // Colores de elementos de interfaz (Tabla 6 del MPF)
  // ---------------------------------------------------------------------------
  static const Color background = Color(0xFFF2F2F2);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFE8E8E8);
  static const Color border = Color(0xFFD9D9D9);
  static const Color divider = Color(0xFFE0E0E0);

  // ---------------------------------------------------------------------------
  // Tipografía y texto
  // ---------------------------------------------------------------------------
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF616161);
  static const Color textHint = Color(0xFF9E9E9E);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color link = Color(0xFF1976D2);

  // ---------------------------------------------------------------------------
  // Estados del sistema (Tabla 7 del MPF)
  // ---------------------------------------------------------------------------
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF0288D1);

  // ---------------------------------------------------------------------------
  // Estatus del docente (módulo 5)
  // ---------------------------------------------------------------------------
  static const Color statusClase = Color(0xFF2E7D32);
  static const Color statusJunta = Color(0xFFFFA000);
  static const Color statusComision = Color(0xFF1565C0);
  static const Color statusIncapacidad = Color(0xFFC62828);
  static const Color statusOtro = Color(0xFF6A1B9A);
}
