import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/my_constants.dart';

class LocationHelper {
  Future<String> getLocation(double latitude, double longitude) async {
    final response = await http.get(
        '$API_URL?lat=$latitude&lon=$longitude&appid=$API_KEY&units=metric');
    final locationData = json.decode(response.body);
    return locationData['name'];
  }
}
