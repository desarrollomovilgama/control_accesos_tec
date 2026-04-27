/// @file    app_text_styles.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Tipografía institucional — Open Sans — GAMA MPF v1.0
/// Referencia: Sección 5.2.2 / Tabla 8 del Manual de Programación Flutter
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  /// SemiBold 600 · 22px · h1.3 — Encabezados principales de pantalla
  static TextStyle get title => GoogleFonts.openSans(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.textContrast,
  );

  /// Medium 500 · 17px · h1.4 — Secciones y encabezados secundarios
  static TextStyle get subtitle => GoogleFonts.openSans(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textContrast,
  );

  /// Regular 400 · 15px · h1.5 — Párrafos y texto general
  static TextStyle get body => GoogleFonts.openSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: AppColors.textMain,
  );

  /// Bold 700 · 14px · h1.2 — Botones (siempre en mayúsculas)
  static TextStyle get button => GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.5,
    color: Colors.white,
  );

  /// Regular 400 · 12px · h1.4 — Textos de apoyo, hints, notas secundarias
  static TextStyle get caption => GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.iconGray,
  );

  /// Regular 400 · 12px · h1.4 · color error — Validaciones fallidas
  static TextStyle get errorText => GoogleFonts.openSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.error,
  );

  // ── Variantes de texto ────────────────────────────────────────────
  static TextStyle get bodyBold => body.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get captionBold => caption.copyWith(fontWeight: FontWeight.w600);
  static TextStyle get subtitleWhite => subtitle.copyWith(color: Colors.white);
  static TextStyle get bodyWhite => body.copyWith(color: Colors.white);
  static TextStyle get titleWhite => title.copyWith(color: Colors.white);

  /// Texto de AppBar
  static TextStyle get appBarTitle => GoogleFonts.openSans(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  /// Label de campos de formulario
  static TextStyle get fieldLabel => GoogleFonts.openSans(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textContrast,
  );

  /// Hint de campos
  static TextStyle get fieldHint => GoogleFonts.openSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.iconGray,
  );
}
