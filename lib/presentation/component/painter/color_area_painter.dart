import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorAreaPainter extends CustomPainter {
  final double hue;
  Offset position;

  ColorAreaPainter({super.repaint, required this.hue, required this.position});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    const Gradient gradientV = LinearGradient(
      colors: [Colors.white, Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final Gradient gradientH = LinearGradient(
      colors: [Colors.white, HSVColor.fromAHSV(1, hue, 1, 1).toColor()],
    );

    canvas.drawRect(rect, Paint()..shader = gradientV.createShader(rect));
    canvas.drawRect(
      rect,
      Paint()
        ..shader = gradientH.createShader(rect)
        ..blendMode = BlendMode.multiply,
    );

    final double pointerSize = size.height * .04;

    if (position.dx == 0) position = Offset(position.dx + pointerSize, position.dy);
    if (position.dx == size.width) position = Offset(position.dx - pointerSize, position.dy);

    if (position.dy == 0) position = Offset(position.dx, position.dy + pointerSize);
    if (position.dy == size.height) position = Offset(position.dx, position.dy - pointerSize);

    canvas.drawCircle(
      position,
      pointerSize,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
