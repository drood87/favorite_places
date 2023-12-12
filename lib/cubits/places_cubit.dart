import 'dart:developer';
import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,name TEXT, image TEXT, lat REAL, long REAL, address TEXT)');
    },
    version: 1,
  );

  return db;
}

class PlacesCubit extends Cubit<List<Place>> {
  PlacesCubit() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');

    final places = data
        .map(
          (row) => Place(
            id: row['id'] as String,
            image: File(row['image'] as String),
            name: row['name'] as String,
            location: PlaceLocation(
              longitude: row['long'] as double,
              latitute: row['lat'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();

    emit(places);
  }

  Future<void> addPlace(Place place) async {
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final filename = path.basename(place.image.path);
    final copiedImage = await place.image.copy('${appDir.path}/$filename');

    final newPlace =
        Place(name: place.name, location: place.location, image: copiedImage);

    final db = await _getDatabase();

    db.insert(
      'user_places',
      {
        'id': newPlace.id,
        'name': newPlace.name,
        'image': newPlace.image.path,
        'lat': newPlace.location.latitute,
        'lang': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );

    final places = [newPlace, ...state];

    emit(places);
  }
}
