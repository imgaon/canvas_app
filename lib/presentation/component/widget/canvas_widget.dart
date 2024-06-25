import 'package:canvas_app/domain/model/drawing_points_model.dart';
import 'package:canvas_app/presentation/component/painter/drawing_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CanvasWidget extends StatefulWidget {
  final Color color;
  final double strokeWidth;

  const CanvasWidget({
    super.key,
    required this.color,
    required this.strokeWidth,
  });

  @override
  State<CanvasWidget> createState() => _CanvasWidgetState();
}

class _CanvasWidgetState extends State<CanvasWidget> {
  List<DrawingPointsModel> points = [];
  bool isEraser = false;
  List<bool> items = [false, false];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        canvas(),
        bottomBar(),
      ],
    );
  }

  Widget canvas() {
    return GestureDetector(
      onPanUpdate: (details) {
        points.add(DrawingPointsModel(
          points: details.localPosition,
          isPoint: true,
        ));
        setState(() {});
      },
      onPanEnd: (details) {
        points.add(DrawingPointsModel(points: Offset.zero, isPoint: false));
        setState(() {});
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 500,
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.black),
          borderRadius: BorderRadius.circular(30),
        ),
        child: CustomPaint(
          painter: DrawingPainter(
              points: points,
              color: widget.color,
              strokeWidth: widget.strokeWidth,
              isEraser: isEraser),
          child: Container(),
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      width: 200,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(10),
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
              items[0] ? isEraser = true : isEraser = false;
              setState(() {});
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
  }
}
