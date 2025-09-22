import 'package:flutter/material.dart';
import 'package:roll_dice_app/gradient_container.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: const GradientContainer(
        const Color.fromARGB(255, 137, 59, 213),
        const Color.fromARGB(255, 173, 121, 243),
        const Color.fromARGB(255, 57, 23, 89),
        const Color.fromARGB(255, 100, 103, 159),
        const Color.fromARGB(255, 88, 86, 142),
      ),
    ),
  ));
}
