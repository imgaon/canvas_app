import 'package:canvas_app/domain/model/drawing_points_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawingPainter extends CustomPainter {
  final List<DrawingPointsModel> points;
  final bool isEraser;

  DrawingPainter({
    super.repaint,
    required this.points,
    required this.isEraser,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i].isPoint && points[i + 1].isPoint) {
        Offset currentPoints = points[i].points;
        Offset nextPoints = points[i + 1].points;

        if (currentPoints.dx < 0) currentPoints = Offset(0, currentPoints.dy);
        if (currentPoints.dy < 0) currentPoints = Offset(currentPoints.dx, 0);
        if (currentPoints.dx > size.width) currentPoints = Offset(size.width, currentPoints.dy);
        if (currentPoints.dy > size.height) currentPoints = Offset(currentPoints.dx, size.height);

        if (nextPoints.dx < 0) nextPoints = Offset(0, nextPoints.dy);
        if (nextPoints.dy < 0) nextPoints = Offset(nextPoints.dx, 0);
        if (nextPoints.dx > size.width) nextPoints = Offset(size.width, nextPoints.dy);
        if (nextPoints.dy > size.height) nextPoints = Offset(nextPoints.dx, size.height);


        canvas.drawLine(currentPoints, nextPoints, points[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
