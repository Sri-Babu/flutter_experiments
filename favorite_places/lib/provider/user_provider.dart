import 'package:favorite_places/model/place.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>>{
  UserPlacesNotifier(super.state);


  void addPlace(String title){
    final newPlace = Place(tilte:title );
    state = [newPlace, ...state];

  }

}

final UserPlacesProvider = StateNotifierProvider<UserPlacesNotifier,List<Place>>((ref) => UserPlacesNotifier([]),);