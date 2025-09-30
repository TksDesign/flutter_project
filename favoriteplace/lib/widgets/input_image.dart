import 'package:flutter/material.dart';

class InputImage extends StatefulWidget {
  const InputImage({super.key});

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white.withOpacity(0.2))),
      height: 250,
      width: double.infinity,
      child: TextButton.icon(
          icon: const Icon(Icons.camera),
          onPressed: () {},
          label: const Text('Take a picture')),
    );
  }
}
