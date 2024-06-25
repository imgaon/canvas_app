import 'package:canvas_app/core/utils/di.dart';
import 'package:canvas_app/presentation/component/widget/canvas_widget.dart';
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
      return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              CanvasWidget(color: Colors.red, strokeWidth: 5,),
            ],
          ),
        ),
      ),
    );
  }
}
