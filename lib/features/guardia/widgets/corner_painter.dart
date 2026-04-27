/// @file    corner_painter.dart
/// @author  Jesús David Johnson Soto
/// @version 1.0
/// Widgets de esquinas del escáner QR.
/// GAMA MPF v1.0 · Proyecto C — Control de Accesos

import 'package:flutter/material.dart';

/// Widget que dibuja una esquina del visor del escáner.
class Corner extends StatelessWidget {
  const Corner({
    super.key,
    required this.color,
    required this.size,
    required this.sw,
    this.tl = false,
    this.tr = false,
    this.bl = false,
    this.br = false,
  });

  final Color  color;
  final double size, sw;
  final bool   tl, tr, bl, br;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: CustomPaint(
      painter: CornerPainter(
          color: color, sw: sw, tl: tl, tr: tr, bl: bl, br: br),
    ),
  );
}

/// CustomPainter que dibuja las líneas de una esquina.
class CornerPainter extends CustomPainter {
  CornerPainter({
    required this.color,
    required this.sw,
    this.tl = false,
    this.tr = false,
    this.bl = false,
    this.br = false,
  });

  final Color  color;
  final double sw;
  final bool   tl, tr, bl, br;

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color      = color
      ..strokeWidth = sw
      ..strokeCap  = StrokeCap.square
      ..style      = PaintingStyle.stroke;

    if (tl) {
      canvas.drawLine(Offset.zero, Offset(size.width, 0), p);
      canvas.drawLine(Offset.zero, Offset(0, size.height), p);
    }
    if (tr) {
      canvas.drawLine(Offset(size.width, 0), Offset.zero, p);
      canvas.drawLine(
          Offset(size.width, 0), Offset(size.width, size.height), p);
    }
    if (bl) {
      canvas.drawLine(
          Offset(0, size.height), Offset(size.width, size.height), p);
      canvas.drawLine(Offset(0, size.height), Offset.zero, p);
    }
    if (br) {
      canvas.drawLine(
          Offset(size.width, size.height), Offset(0, size.height), p);
      canvas.drawLine(
          Offset(size.width, size.height), Offset(size.width, 0), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
