import 'package:canvas_app/core/utils/di.dart';
import 'package:canvas_app/presentation/component/widget/canvas/canvas_widget.dart';
import 'package:canvas_app/presentation/component/widget/eyedrop/eye_dropper_widget.dart';
import 'package:canvas_app/presentation/provider/home_provider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeProvider provider = di.get<HomeProvider>();

  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    provider.addListener(updateScreen);
  }

  @override
  void dispose() {
    provider.removeListener(updateScreen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EyeDrop(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const CanvasWidget(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    button(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: Colors.blue)),
                      text: 'Selected Image',
                      color: Colors.blue,
                      onTap: () {
                        provider.pickImage();
                      },
                    ),
                    const SizedBox(width: 10),
                    button(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.blue),
                      text: 'Export png',
                      color: Colors.white,
                      onTap: () async {
                        final result = await provider.saveCanvasImage();

                        final snackBar = SnackBar(content: Text(
                          result ? '이미지가 저장되었습니다.' : '이미지 저장에 실패하였습니다.'
                        ));

                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button({
    required BoxDecoration decoration,
    required String text,
    required Color color,
    required void Function()? onTap,
  }) =>
      Flexible(
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50,
            decoration: decoration,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      );
}
