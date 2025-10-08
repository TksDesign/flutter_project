import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImage extends StatefulWidget {
  const InputImage({super.key, required this.onPickImage});
  final void Function(File image) onPickImage;

  @override
  State<InputImage> createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File? _selectImage;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: double.infinity,
        maxHeight: double.infinity);
    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectImage = File(pickedImage.path); //le chemin qui mene vers l'image
    });
    widget.onPickImage(_selectImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        icon: const Icon(Icons.camera),
        onPressed: _takePicture,
        label: const Text('Take a picture'));
    if (_selectImage != null) {
      content = InkWell(
        onTap: _takePicture,
        child: Image.file(
          _selectImage!,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white.withOpacity(0.2))),
        height: 250,
        width: double.infinity,
        child: content);
  }
}
