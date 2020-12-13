import 'package:flutter/material.dart';
import 'dart:math' as math;

class Sun extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path();
    path.addArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height * 3),
        radius: 100,
      ),
      math.pi / 6,
      math.pi / 3,
    );
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
