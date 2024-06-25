import 'package:canvas_app/domain/model/drawing_points_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawingPainter extends CustomPainter {
  final List<DrawingPointsModel> points;
  final Color color;
  final double strokeWidth;
  final bool isEraser;

  DrawingPainter({
    super.repaint,
    required this.points,
    required this.color,
    required this.strokeWidth,
    required this.isEraser,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].isPoint && points[i + 1].isPoint) {
        canvas.drawLine(points[i].points, points[i + 1].points, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
