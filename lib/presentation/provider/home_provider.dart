import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeProvider extends ChangeNotifier {
  bool test = false;

  GlobalKey globalKey = GlobalKey();

  Future<ui.Image> capturePng() async {
    RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    return image;
  }

  Future<Color> getColorFromImage(ui.Image image, Offset position) async {
    ByteData? data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    if (data == null) return Colors.transparent;

    int width = image.width;
    int height = image.height;

    int x = position.dx.toInt();
    int y = position.dy.toInt();

    if (x >= width || y >= height) {
      return Colors.transparent;
    }

    int byteOffset = (y * width + x) * 4;

    int r = data.getUint8(byteOffset);
    int g = data.getUint8(byteOffset + 1);
    int b = data.getUint8(byteOffset + 2);
    int a = data.getUint8(byteOffset + 3);

    return Color.fromARGB(a, r, g, b);
  }
}