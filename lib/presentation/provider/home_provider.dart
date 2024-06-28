import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeProvider extends ChangeNotifier {
  File? image;
  GlobalKey globalKey = GlobalKey();

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      // final Uint8List bytes = await pickedFile.readAsBytes();
      // final Completer<ui.Image> completer = Completer();
      // ui.decodeImageFromList(bytes, (ui.Image img) {
      //   image = img;
      //   completer.complete(img);
      // });
      // completer.future;
    }
    notifyListeners();
  }

  Future<bool> saveCanvasImage() async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3);
      ByteData? data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) throw Exception('ERROR');
      Uint8List pngBytes = data.buffer.asUint8List();

      Directory? downloadsDir = Directory('/storage/emulated/0/Download');

      if (!downloadsDir.existsSync()) {
        downloadsDir = await getExternalStorageDirectory();
      }

      String filePath = '${downloadsDir!.path}/${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} ${DateTime.now().microsecond}.png';

      File imgFile = File(filePath);
      await imgFile.writeAsBytes(pngBytes);

      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}