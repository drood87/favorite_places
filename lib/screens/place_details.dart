import 'package:favorite_places/cubits/places_cubit.dart';
import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceDetails extends StatelessWidget {
  final Place place;
  final int placeIndex;

  const PlaceDetails({
    required this.place,
    required this.placeIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlacesCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(place.name),
        ),
        body: Stack(
          children: [
            Image.file(
              place.image,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => MapScreen(
                            location: place.location,
                            isSelecting: false,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        context
                            .read<PlacesCubit>()
                            .state[placeIndex]
                            .location
                            .locationImage,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      place.location.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
