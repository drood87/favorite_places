import 'dart:io';

import 'package:favorite_places/env/env.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Place {
  Place({
    required this.name,
    required this.image,
    required this.location,
    String? id,
  }) : id = id ?? uuid.v4();

  final String name;
  final String id;
  final File image;
  final PlaceLocation location;
}

class PlaceLocation {
  const PlaceLocation({
    required this.longitude,
    required this.latitute,
    required this.address,
  });

  final double latitute;
  final double longitude;
  final String address;

  String get locationImage {
    final lat = latitute;
    final long = longitude;

    return '''https://maps.googleapis.com/maps/api/staticmap?center=$lat,$long&
            zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$long
            &key=${Env.googleMapsKey}
            ''';
  }
}
