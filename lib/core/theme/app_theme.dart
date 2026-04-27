/// @file    app_theme.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Configuración del tema visual — GAMA MPF v1.0
/// Referencia: Sección 5.2.1 del Manual de Programación Flutter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../config/app_colors.dart';
import '../config/app_spacing.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      error: AppColors.error,
      surface: AppColors.appBackground,
    ),
    scaffoldBackgroundColor: AppColors.appBackground,
    textTheme: GoogleFonts.openSansTextTheme(),

    // ── AppBar ──────────────────────────────────────────────────────
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.openSans(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(color: Colors.white, size: 20),
    ),

    // ── BottomNavigationBar ─────────────────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.appBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.iconGray,
      selectedLabelStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(fontSize: 10),
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    // ── Divider ─────────────────────────────────────────────────────
    dividerTheme: const DividerThemeData(
      color: AppColors.borderGray,
      thickness: 1,
      space: 0,
    ),

    // ── Card ────────────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.appBackground,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusCard),
        side: const BorderSide(color: AppColors.borderGray),
      ),
      margin: EdgeInsets.zero,
    ),


    // ── InputDecoration ─────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.iceBlue,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.borderGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.borderGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      hintStyle: GoogleFonts.openSans(
        fontSize: 14,
        color: AppColors.iconGray,
      ),
    ),
  );

  /// Estilo del sistema para pantallas con AppBar primario
  static const SystemUiOverlayStyle systemUiPrimary = SystemUiOverlayStyle(
    statusBarColor: AppColors.primary,
    statusBarIconBrightness: Brightness.light,
  );

  /// Estilo del sistema para pantallas con fondo claro (login header)
  static const SystemUiOverlayStyle systemUiLight = SystemUiOverlayStyle(
    statusBarColor: AppColors.iceBlue,
    statusBarIconBrightness: Brightness.dark,
  );
}
