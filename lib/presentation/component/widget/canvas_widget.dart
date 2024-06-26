import 'dart:developer';

import 'package:canvas_app/domain/model/drawing_points_model.dart';
import 'package:canvas_app/presentation/component/dialog/brush_width_dialog.dart';
import 'package:canvas_app/presentation/component/dialog/color_picker_dialog.dart';
import 'package:canvas_app/presentation/component/painter/drawing_painter.dart';
import 'package:flutter/material.dart';

class CanvasWidget extends StatefulWidget {
  const CanvasWidget({
    super.key,
  });

  @override
  State<CanvasWidget> createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> {
  List<DrawingPointsModel> points = [];
  bool isEraser = false;
  List<bool> items = [false, false];
  double stroke = 5;
  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        canvas(),
        bottomBar(context),
      ],
    );
  }

  Widget canvas() {
    return GestureDetector(
      onPanUpdate: (details) {
        points.add(DrawingPointsModel(
          points: details.localPosition,
          paint: Paint()
            ..color = isEraser ? Colors.white : color
            ..strokeCap = StrokeCap.round
            ..strokeWidth = stroke
            ..style = PaintingStyle.stroke
            ..isAntiAlias = true,
          isPoint: true,
        ));
        setState(() {});
      },
      onPanEnd: (details) {
        points.add(DrawingPointsModel(points: Offset.zero, paint: Paint(), isPoint: false));
        setState(() {});
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 500,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
        ),
        child: CustomPaint(
          painter: DrawingPainter(
            points: points,
            isEraser: isEraser,
          ),
          child: Container(),
        ),
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
      width: 240,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconButton(
            icon: Icons.how_to_vote_outlined,
            isSelected: items[0],
            onTap: () {
              selectedItem(0);
              setState(() {});
            },
          ),
          const SizedBox(width: 20),
          iconButton(
              icon: Icons.colorize,
              isSelected: items[1],
              onTap: () {
                selectedItem(1);
                setState(() {});
              }),
          const SizedBox(width: 20),
          iconButton(
            icon: Icons.draw,
            isSelected: false,
            onTap: () async {
              final newStroke = await showBrushDialog(context);
              if (newStroke != 0) {
                stroke = newStroke;
              }
            },
          ),
          const SizedBox(width: 20),
          iconButton(
            icon: Icons.delete,
            isSelected: false,
            onTap: () {
              points.clear();
              setState(() {});
            },
          ),
          const SizedBox(width: 20),
          iconButton(
            icon: Icons.palette,
            isSelected: false,
            onTap: () async {
              final Color? newColor = await showColorPicker(context);
              log(newColor.toString());
              if (newColor != null) color = newColor;

              log(color.toString());
            },
          ),
        ],
      ),
    );
  }

  Widget iconButton({
    required IconData icon,
    required bool isSelected,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: isSelected ? Colors.blue : Colors.white),
    );
  }

  void selectedItem(int index) {
    if (items[index]) {
      items[index] = false;
    } else {
      for (int i = 0; i < items.length; i++) {
        items[i] = i == index;
      }
    }

    items[0] ? isEraser = true : isEraser = false;
  }
}
