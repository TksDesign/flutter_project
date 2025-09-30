import 'package:flutter/material.dart';
import 'package:textfield/data/dummyItems.dart';
import 'package:textfield/widgets/grocery_liste.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TextField',
        theme: ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 147, 229, 250),
              brightness: Brightness.dark,
              surface: const Color.fromARGB(255, 42, 51, 59),
            ),
            scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60)),
        home: GroceryListe());
  }
}
