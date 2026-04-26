/// =============================================================================
/// qr_overlay.dart
/// -----------------------------------------------------------------------------
/// Overlay visual sobre la cámara QR (marco con esquinas). Maqueta visual.
/// =============================================================================
library;

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class QrOverlay extends StatelessWidget {
  const QrOverlay({super.key, this.size = 240});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: _CornerPainter()),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    const cornerLen = 26.0;

    // Superior izquierda
    canvas.drawLine(Offset.zero, const Offset(cornerLen, 0), paint);
    canvas.drawLine(Offset.zero, const Offset(0, cornerLen), paint);
    // Superior derecha
    canvas.drawLine(Offset(size.width - cornerLen, 0),
        Offset(size.width, 0), paint);
    canvas.drawLine(Offset(size.width, 0),
        Offset(size.width, cornerLen), paint);
    // Inferior izquierda
    canvas.drawLine(Offset(0, size.height - cornerLen),
        Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, size.height),
        Offset(cornerLen, size.height), paint);
    // Inferior derecha
    canvas.drawLine(Offset(size.width - cornerLen, size.height),
        Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height - cornerLen),
        Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
