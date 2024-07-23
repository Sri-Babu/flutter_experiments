import 'package:favorite_places/provider/user_provider.dart';
import 'package:favorite_places/screens/add_places.dart';
import 'package:favorite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScrees extends ConsumerWidget {
  const PlacesScrees({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
   final userPlaces= ref.watch(UserPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Place'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddPlacesScreen()),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body:  PlacesList(
        places: userPlaces,
      ),
    );
  }
}
