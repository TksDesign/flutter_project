import 'dart:io';

import 'package:favoriteplace/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

// pour pouvoir avooir acces a la base de donnees
Future<Database> _getDatabase() async {
  // pour pouvoir avoir acces et creer ma bd
  final dbPath = await sql.getDatabasesPath();
  // await sql.deleteDatabase(path.join(dbPath, 'place.db'));
  final db = await sql.openDatabase(
    path.join(dbPath, 'place.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_place( id TEXT PRIMARY KEY,title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

class UserPlaceNotifier extends StateNotifier<List<Place>> {
  UserPlaceNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    // interoge la base de donnes pour avoir acces a celle ci
    final data = await db.query(
        'user_place'); //et on peut egalement specifier quelquel condition comme un where

    final place = data
        .map((row) => Place(
            id: row['id'] as String,
            title: row['title'] as String,
            file: File(row['image'] as String),
            location: PlaceLocation(
                latitude: row['lat'] as double,
                longitude: row['lng'] as double,
                adress: row['address'] as String)))
        .toList();
    // definer l'etat
    state = place;
  }

  void addPlace(String title, File file, PlaceLocation location) async {
    // definir une emplacement pour stocker
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(file.path);
    // nouvelle emplacement
    final copiedImage = await file.copy('${appDir.path}/${filename}');

    final NewPlace = Place(title: title, file: copiedImage, location: location);

    final db = await _getDatabase();

    db.insert('user_place', {
      'id': NewPlace.id,
      'title': NewPlace.title,
      'image': NewPlace.file.path,
      'lat': NewPlace.location.latitude,
      'lng': NewPlace.location.longitude,
      'address': NewPlace.location.adress
    });
    state = [NewPlace, ...state];
  }
}

final userPlaceProvider = StateNotifierProvider<UserPlaceNotifier, List<Place>>(
    (ref) => UserPlaceNotifier());
