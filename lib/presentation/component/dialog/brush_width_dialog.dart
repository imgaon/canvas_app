import 'package:flutter/material.dart';

Future<double> showBrushDialog(BuildContext context) async {
  List<bool> items = [false, false, false, false];
  double stroke = 0;

  Widget strokeButton({
    required double width,
    required bool isSelected,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Divider(
        thickness: width,
        color: isSelected ? Colors.blue : Colors.black,
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
            width: MediaQuery.sizeOf(context).width / 2,
            height: MediaQuery.sizeOf(context).height * 0.23,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                strokeButton(
                  width: 20,
                  isSelected: items[0],
                  onTap: () {
                    selectedItem(0);
                    stroke = 20;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                strokeButton(
                  width: 15,
                  isSelected: items[1],
                  onTap: () {
                    selectedItem(1);
                    stroke = 15;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                strokeButton(
                  width: 10,
                  isSelected: items[2],
                  onTap: () {
                    selectedItem(2);
                    stroke = 10;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                strokeButton(
                  width: 5,
                  isSelected: items[3],
                  onTap: () {
                    selectedItem(3);
                    stroke = 5;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
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

  return stroke;
}
