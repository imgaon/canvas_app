import 'dart:ui';

class DrawingPointsModel {
  Offset points;
  bool isPoint;

  DrawingPointsModel({
    required this.points,
    this.isPoint = true,
  });
}