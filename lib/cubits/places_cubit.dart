import 'package:favorite_places/models/place.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesCubit extends Cubit<List<Place>> {
  PlacesCubit() : super(const []);

  void addPlace(Place place) {
    final places = [place, ...state];

    emit(places);
  }
}
