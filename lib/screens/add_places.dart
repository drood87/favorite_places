import 'dart:io';

import 'package:favorite_places/cubits/places_cubit.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlaces extends StatefulWidget {
  const AddPlaces({super.key});

  @override
  State<AddPlaces> createState() => _AddPlacesState();
}

class _AddPlacesState extends State<AddPlaces> {
  late TextEditingController _controller;
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Title'),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(
              onPickImage: (image) => _selectedImage = image,
            ),
            const SizedBox(
              height: 16,
            ),
            LocationInput(
              onSelectLocation: (location) {
                _selectedLocation = location;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    final cubit = BlocProvider.of<PlacesCubit>(context);

                    if (_controller.text.isEmpty ||
                        _selectedImage == null ||
                        _selectedLocation == null) {
                      return;
                    }

                    cubit.addPlace(
                      Place(
                        name: _controller.text,
                        image: _selectedImage!,
                        location: _selectedLocation!,
                      ),
                    );

                    Navigator.pop(context);
                  },
                  label: const Text('Add Place'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
