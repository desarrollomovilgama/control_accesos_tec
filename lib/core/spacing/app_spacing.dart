/// =============================================================================
/// app_spacing.dart
/// -----------------------------------------------------------------------------
/// Sistema de espaciado consistente. Apartado 4.2 (Espaciado) del MPF.
/// Usar siempre estas constantes en lugar de valores numéricos sueltos.
/// =============================================================================
library;

import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // Escala base (múltiplos de 4)
  static const double xxs = 2;
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;

  // Padding interno estándar (Figura 22 del MPF)
  static const EdgeInsets paddingScreen = EdgeInsets.all(lg);
  static const EdgeInsets paddingScreenHorizontal =
      EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingCard = EdgeInsets.all(md);
  static const EdgeInsets paddingButton =
      EdgeInsets.symmetric(horizontal: lg, vertical: md);

  // Margen externo estándar (Figura 23 del MPF)
  static const EdgeInsets marginSection = EdgeInsets.symmetric(vertical: lg);

  // SizedBox helpers para separación rápida (Figura 24-25 del MPF)
  static const Widget gapXs = SizedBox(height: xs, width: xs);
  static const Widget gapSm = SizedBox(height: sm, width: sm);
  static const Widget gapMd = SizedBox(height: md, width: md);
  static const Widget gapLg = SizedBox(height: lg, width: lg);
  static const Widget gapXl = SizedBox(height: xl, width: xl);
  static const Widget gapXxl = SizedBox(height: xxl, width: xxl);
  static const Widget gapXxxl = SizedBox(height: xxxl, width: xxxl);

  // Verticales explícitos
  static const Widget vGapXs = SizedBox(height: xs);
  static const Widget vGapSm = SizedBox(height: sm);
  static const Widget vGapMd = SizedBox(height: md);
  static const Widget vGapLg = SizedBox(height: lg);
  static const Widget vGapXl = SizedBox(height: xl);
  static const Widget vGapXxl = SizedBox(height: xxl);
  static const Widget vGapXxxl = SizedBox(height: xxxl);

  // Horizontales explícitos
  static const Widget hGapXs = SizedBox(width: xs);
  static const Widget hGapSm = SizedBox(width: sm);
  static const Widget hGapMd = SizedBox(width: md);
  static const Widget hGapLg = SizedBox(width: lg);
  static const Widget hGapXl = SizedBox(width: xl);
}
