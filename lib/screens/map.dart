import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation location;
  final bool isSelecting;

  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
      longitude: 37.422,
      latitute: -122.084,
      address: '',
    ),
    this.isSelecting = false,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save),
            )
        ],
        title:
            Text(widget.isSelecting ? 'Pick your location' : 'Your Location'),
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.location.latitute,
                widget.location.longitude,
              ),
              zoom: 16),
          markers: {
            Marker(
              markerId: const MarkerId('m1'),
              position: LatLng(
                widget.location.latitute,
                widget.location.longitude,
              ),
            )
          }),
    );
  }
}
