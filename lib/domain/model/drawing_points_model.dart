import 'dart:ui';

class DrawingPointsModel {
  Offset points;
  Paint paint;
  bool isPoint;

  DrawingPointsModel({
    required this.points,
    required this.paint,
    this.isPoint = true,
  });
}