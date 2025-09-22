import 'package:flutter/material.dart';
import 'package:popupmenu/pages/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: home1(),
      debugShowCheckedModeBanner: false,
    );
  }
}
