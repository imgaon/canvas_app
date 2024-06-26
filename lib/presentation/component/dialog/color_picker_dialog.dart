import 'package:canvas_app/presentation/component/painter/color_area_painter.dart';
import 'package:flutter/material.dart';

Future<Color?> showColorPicker(BuildContext context) async {
  Color? selectedColor;
  Color customColor = Colors.white;
  double hue = 0;
  double saturation = 0;
  double value = 1;

  List<bool> items = [true, false, false, false, false, false];
  Offset position = const Offset(0, 0);

  List<Color> hsvColorList =
      List.generate(360, (index) => HSVColor.fromAHSV(1, index.toDouble(), 1, 1).toColor());

  Widget colorButton({
    required Color color,
    required bool isSelected,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
      ),
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

  await showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.sizeOf(context).width * 0.6,
            height: MediaQuery.sizeOf(context).height * 0.4,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 5,
                  child: LayoutBuilder(builder: (context, constraints) {
                    return GestureDetector(
                      onPanUpdate: (details) {

                        position = details.localPosition;

                        if (position.dx < 0) position = Offset(0, position.dy);
                        if (position.dy < 0) position = Offset(position.dx, 0);
                        if (position.dx > constraints.maxWidth) {
                          position = Offset(constraints.maxWidth, position.dy);
                        }
                        if (position.dy > constraints.maxHeight) {
                          position = Offset(position.dx, constraints.maxHeight);
                        }

                        saturation = position.dx / constraints.maxWidth;
                        value = 1 - position.dy / constraints.maxHeight;

                        customColor = HSVColor.fromAHSV(1, hue, saturation, value).toColor();

                        items = [true, false, false, false, false, false];
                        selectedColor = customColor;
                        setState(() {});
                      },
                      child: CustomPaint(
                        painter: ColorAreaPainter(hue: hue, position: position),
                        child: Container(),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: hsvColorList),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      SliderTheme(
                        data: SliderThemeData(
                          overlayShape: SliderComponentShape.noOverlay,
                        ),
                        child: Slider(
                          min: 0,
                          max: 360,
                          value: hue,
                          activeColor: Colors.transparent,
                          inactiveColor: Colors.transparent,
                          thumbColor: HSVColor.fromAHSV(1, hue, 1, 1).toColor(),
                          onChanged: (double hueData) {
                            hue = hueData;
                            customColor = HSVColor.fromAHSV(1, hue, saturation, value).toColor();

                            items = [true, false, false, false, false, false];
                            selectedColor = customColor;
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: Row(
                    children: [
                      colorButton(
                        color: customColor,
                        isSelected: items[0],
                        onTap: () {
                          selectedItem(0);
                          selectedColor = customColor;
                          setState(() {});
                        },
                      ),
                      colorButton(
                        color: Colors.red,
                        isSelected: items[1],
                        onTap: () {
                          selectedItem(1);
                          selectedColor = Colors.red;
                          setState(() {});
                        },
                      ),
                      colorButton(
                        color: Colors.green,
                        isSelected: items[2],
                        onTap: () {
                          selectedItem(2);
                          selectedColor = Colors.green;
                          setState(() {});
                        },
                      ),
                      colorButton(
                        color: Colors.blue,
                        isSelected: items[3],
                        onTap: () {
                          selectedItem(3);
                          selectedColor = Colors.blue;
                          setState(() {});
                        },
                      ),
                      colorButton(
                        color: Colors.yellow,
                        isSelected: items[4],
                        onTap: () {
                          selectedItem(4);
                          selectedColor = Colors.yellow;
                          setState(() {});
                        },
                      ),
                      colorButton(
                        color: Colors.black,
                        isSelected: items[5],
                        onTap: () {
                          selectedItem(5);
                          selectedColor = Colors.black;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40,
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );

  return selectedColor;
}
