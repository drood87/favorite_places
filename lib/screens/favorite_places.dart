import 'package:favorite_places/cubits/places_cubit.dart';
import 'package:favorite_places/models/places.dart';
import 'package:favorite_places/screens/add_places.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePlaces extends StatelessWidget {
  const FavoritePlaces({super.key});

  void _addPlaces(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const AddPlaces(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your places'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _addPlaces(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<PlacesCubit, List<Place>>(
        builder: (context, state) => state.isNotEmpty
            ? PlacesList(places: state)
            : const Center(
                child: Text(
                  'No places added yet, go out and explore!',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
      ),
    );
  }
}
