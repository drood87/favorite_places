import 'package:favorite_places/models/places.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesCubit extends Cubit<List<Place>> {
  PlacesCubit() : super([]);

  void addPlace(Place place) {
    final places = [...state];

    places.add(place);
    emit(places);
  }
}
