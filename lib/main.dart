import 'package:canvas_app/core/utils/di.dart';
import 'package:canvas_app/presentation/provider/home_provider.dart';
import 'package:canvas_app/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final HomeProvider homeProvider = HomeProvider();

  di.set(homeProvider);

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    )
  );
}