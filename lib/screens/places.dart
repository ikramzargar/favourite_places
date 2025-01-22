import 'package:favourite_places/providers/user_places.dart';
import 'package:favourite_places/screens/add_place.dart';
import 'package:favourite_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
   return _PlacesScreenState();
  }
}
  class _PlacesScreenState extends ConsumerState<PlacesScreen>{
 late Future<void> _placesFuture;
  @override
  void initState() {
  _placesFuture =  ref.read(userPlacesProvider.notifier).loadPlaces();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   final userPlaces =  ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(future: _placesFuture, builder: (context,snapshot)=> snapshot.connectionState==ConnectionState.waiting?Center(child: CircularProgressIndicator()):PlacesList(places: userPlaces))),
      );

  }
}
