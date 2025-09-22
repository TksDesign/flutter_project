import 'package:flutter/material.dart';
import 'package:quiz_app2/quiz.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: quiz(),
    ),
  ));
}
