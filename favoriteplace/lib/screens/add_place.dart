import 'dart:io';

import 'package:favoriteplace/model/place.dart';
import 'package:favoriteplace/providers/user_place.dart';
import 'package:favoriteplace/widgets/input_image.dart';
import 'package:favoriteplace/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleConntroller = TextEditingController();
  File? _selectImage;
  PlaceLocation? _selectLocation;

  void _addPlace() {
    final enteredTitle = _titleConntroller.text;

    if (enteredTitle.isEmpty ||
        _selectImage == null ||
        _selectLocation == null) {
      return;
    }
    ref
        .read(userPlaceProvider.notifier)
        .addPlace(enteredTitle, _selectImage!, _selectLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleConntroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add New Place',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary!),
                decoration: const InputDecoration(
                  label: Text(
                    'Title',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                keyboardType: TextInputType.text,
                controller: _titleConntroller,
              ),
              const SizedBox(
                height: 12,
              ),
              InputImage(
                onPickImage: (image) {
                  _selectImage = image;
                },
              ),
              const SizedBox(height: 10),
              LocationInput(
                onSelectLocation: (location) {
                  _selectLocation = location;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: _addPlace,
                  label: const Text('add place'))
            ],
          ),
        ));
  }
}
