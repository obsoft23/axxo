// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_declarations

import 'dart:math';

import 'package:flutter/material.dart';

class RosesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final twigPaint = Paint()
      ..color = Colors.brown
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final leafPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    final roseSize = 20.0;
    final spacing = 100.0;

    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing) {
        _drawRoseWithTwigAndLeaves(
            canvas, Offset(x, y), roseSize, paint, twigPaint, leafPaint);
      }
    }
  }

  void _drawRoseWithTwigAndLeaves(Canvas canvas, Offset center, double size,
      Paint rosePaint, Paint twigPaint, Paint leafPaint) {
    // Draw the twig
    canvas.drawLine(center, Offset(center.dx, center.dy + size * 3), twigPaint);

    // Draw the leaves
    final leafPath = Path();
    leafPath.moveTo(center.dx, center.dy + size * 1.5);
    leafPath.quadraticBezierTo(center.dx - size, center.dy + size * 2,
        center.dx, center.dy + size * 2.5);
    leafPath.quadraticBezierTo(center.dx + size, center.dy + size * 2,
        center.dx, center.dy + size * 1.5);
    canvas.drawPath(leafPath, leafPaint);

    leafPath.reset();
    leafPath.moveTo(center.dx, center.dy + size * 2.0);
    leafPath.quadraticBezierTo(center.dx - size, center.dy + size * 2.5,
        center.dx, center.dy + size * 3);
    leafPath.quadraticBezierTo(center.dx + size, center.dy + size * 2.5,
        center.dx, center.dy + size * 2.0);
    canvas.drawPath(leafPath, leafPaint);

    // Draw the rose petals
    for (double i = 0; i < 6; i++) {
      final angle = i * (360 / 6);
      final x = center.dx + size * cos(_degreesToRadians(angle));
      final y = center.dy + size * sin(_degreesToRadians(angle));
      canvas.drawCircle(Offset(x, y), size / 2, rosePaint);
    }
    canvas.drawCircle(center, size / 2, rosePaint);
  }

  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
