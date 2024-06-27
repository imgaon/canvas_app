import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:canvas_app/core/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

final _globalKey = GlobalKey();

class EyeDrop extends StatefulWidget {
  final Widget child;

  const EyeDrop({super.key, required this.child});

  @override
  State<EyeDrop> createState() => _EyeDropState();
}

class _EyeDropState extends State<EyeDrop> {
  final EyeDropController controller = EyeDropController();
  
  void updateScreen() => setState(() {});
  
  @override
  void initState() {
    super.initState();
    di.set(controller);
    controller.addListener(updateScreen);
  }
  
  @override
  void dispose() {
    controller.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: _globalKey,
      child: GestureDetector(
        onTapDown: (details) async {
          if (controller.isUse) {
            controller.pickColor(details);
          }
        },
        child: widget.child,
      ),
    );
  }
}

class EyeDropController extends ChangeNotifier {
  Color color = Colors.white;
  bool isUse = false;
  
  void useEyeDropper() {
    isUse = true;
  }
  
  Future<void> pickColor(TapDownDetails details) async {
    log('!!!!');
    final ui.Image image = await _capturePng();
    color = await _getColorFromImage(image, details.localPosition);
    log(color.toString());
    isUse = false;
    notifyListeners();
  }

  Future<ui.Image> _capturePng() async {
    RenderRepaintBoundary boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    return image;
  }

  Future<Color> _getColorFromImage(ui.Image image, Offset position) async {
    ByteData? data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    int width = image.width;
    int height = image.height;

    int x = position.dx.toInt();
    int y = position.dy.toInt();

    if (x >= width || y >= height || data == null) {
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
