import 'dart:math';

import 'package:flutter/material.dart';

class ArcPainter extends CustomPainter {
  ArcPainter({
    this.strokeWidth,
    this.backgroundColor,
    this.color,
    required this.headValue,
    required this.tailValue,
    required this.stepValue,
    required this.rotationValue
  })  : arcStart = _startAngle + // -pi / 2
      tailValue * 3 / 2 * pi +
      rotationValue * pi * 1.7 -
      stepValue * 0.8 * pi,
        arcSweep =
        max(headValue * 3 / 2 * pi - tailValue * 3 / 2 * pi, _epsilon);

  final Color? backgroundColor;
  final Color? color;
  final double headValue;
  final double tailValue;
  final int stepValue;
  final double rotationValue;
  final double? strokeWidth;
  final double arcStart;
  final double arcSweep;

  static const double _twoPi = pi * 2.0;
  static const double _epsilon = .001;

  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _completeCircumference = _twoPi - _epsilon;
  static const double _startAngle = -pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor!
        ..strokeWidth = strokeWidth!
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
          Offset(-strokeWidth! / 2, -strokeWidth! / 2) &
          Size(size.width + strokeWidth!, size.height + strokeWidth!),
          0,
          _completeCircumference,
          false,
          backgroundPaint);
    }

    final Paint paint = Paint()
      ..color = color!
      ..strokeWidth = strokeWidth!
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    canvas.drawArc(
        Offset(-strokeWidth! / 2, -strokeWidth! / 2) &
        Size(size.width + strokeWidth!, size.height + strokeWidth!),
        arcStart,
        arcSweep,
        false,
        paint);
  }

  @override
  bool shouldRepaint(ArcPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.color != color ||
        oldPainter.headValue != headValue ||
        oldPainter.tailValue != tailValue ||
        oldPainter.stepValue != stepValue ||
        oldPainter.rotationValue != rotationValue ||
        oldPainter.strokeWidth != strokeWidth;
  }
}