import 'package:favorite_places/model/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailedScreen extends StatelessWidget {
  

  const PlaceDetailedScreen({super.key, required this.place});
  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.tilte,
         style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Center(child: Text(place.tilte),),
    );
  }
}