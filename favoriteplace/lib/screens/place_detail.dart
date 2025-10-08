import 'package:favoriteplace/model/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({super.key, required this.place});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            place.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            Image.file(
              place.file,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              
            )
          ],
        ));
  }
}
