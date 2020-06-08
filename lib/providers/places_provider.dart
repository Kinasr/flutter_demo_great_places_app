import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helper/db_helper.dart';
import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  Future<void> fetchAndGetData() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(
              latitude: item['lat'],
              longitude: item['long'],
              address: item['address'],
            ),
            image: File(
              item['image'],
            ),
          ),
        )
        .toList();
    notifyListeners();
  }

  void addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation userLocation,
  ) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: pickedTitle,
      location: userLocation,
      image: pickedImage,
    );
    _items.add(newPlace);
    notifyListeners();

    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': userLocation.latitude,
      'lng': userLocation.longitude,
      'address': userLocation.address,
    });
  }

  Place getPlace(String id) => _items.firstWhere((element) => element.id == id);

  void deletePlace(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();

    DBHelper.delete('user_places', id);
  }
}
