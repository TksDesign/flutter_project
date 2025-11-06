import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation(
      {required this.latitude, required this.longitude, required this.adress});
  final double latitude;
  final double longitude;
  final String adress;
}

class Place {
  Place({required this.title, required this.file, 
  required this.location, String? id
  })
      : id = id ?? uuid.v4();
  final String id;
  final String title;
  final File file;
  final PlaceLocation location;
}
