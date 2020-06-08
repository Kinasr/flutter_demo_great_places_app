import 'dart:io';

import 'package:demogreatplacesapp/models/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../providers/places_provider.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File _pickedImage;
  PlaceLocation _userLocation;
  final _titleController = TextEditingController();
  var _hasTitle = false;
  var _hasImage = false;
  var _hasLocation = false;

  @override
  void dispose() {
    super.dispose();

    _titleController.dispose();
  }

  void _getPickedImage(File pickedImage) {
    setState(() {
      _hasImage = true;
    });
    _pickedImage = pickedImage;
  }

  void _getUserLocation(PlaceLocation location) {
    setState(() {
      _hasLocation = true;
    });
    _userLocation = location;
  }

  void _savePlace() {
    Provider.of<PlacesProvider>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage, _userLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Great Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: TextField(
                        controller: _titleController,
                        style: TextStyle(color: MyColors.liteColor),
                        cursorColor: MyColors.primaryColor,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: MyColors.liteColor),
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: MyColors.liteColor),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _hasTitle = value.isNotEmpty;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 10.0),
                    ImageInput(_getPickedImage),
                    SizedBox(height: 10.0),
                    LocationInput(_getUserLocation),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: const Text('Add This Great Place'),
            elevation: 0.0,
            textColor: MyColors.deepColor,
            color: MyColors.accentColor,
            disabledTextColor: MyColors.deepColor,
            disabledColor: MyColors.liteColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: _hasTitle && _hasImage && _hasLocation
                ? () {
                    _savePlace();
                    Navigator.of(context).pop();
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
