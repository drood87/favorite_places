import 'package:favorite_places/screens/add_places.dart';
import 'package:flutter/material.dart';

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
    );
  }
}
