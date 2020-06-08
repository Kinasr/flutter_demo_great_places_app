import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../constants/my_colors.dart';
import '../models/place.dart';
import '../helper/location_helper.dart';

class LocationInput extends StatefulWidget {
  final Function getUserLocation;

  LocationInput(this.getUserLocation);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _userLocation;
  var _isLocationServiceEnabled = false;
  PermissionStatus _permissionGranted;

  Future<void> _getUserLocation() async {
    final location = Location();

    _isLocationServiceEnabled = await location.serviceEnabled();
    if (!_isLocationServiceEnabled) {
      _isLocationServiceEnabled = await location.requestService();
      if (!_isLocationServiceEnabled) {
        //todo
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        //todo
        return;
      }
    }

    final locationData = await location.getLocation();

    final address = await LocationHelper()
        .getLocation(locationData.latitude, locationData.longitude);
    setState(() {
      _userLocation = address == null ? 'Can not reach Your location' : address;
    });
    widget.getUserLocation(
      PlaceLocation(
        latitude: locationData.longitude,
        longitude: locationData.longitude,
        address: address,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: MyColors.liteColor),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: _userLocation == null
              ? Icon(Icons.map, color: MyColors.liteColor)
              : Center(
                  child: Text(
                    _userLocation,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: MyColors.liteColor,
                    ),
                  ),
                ),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FlatButton.icon(
              icon: const Icon(Icons.add_location),
              label: const Text('Current Location'),
              textColor: MyColors.accentColor,
              onPressed: _getUserLocation,
            ),
          ],
        ),
      ],
    );
  }
}
