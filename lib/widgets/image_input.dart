import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

import '../constants/my_colors.dart';

class ImageInput extends StatefulWidget {
  final Function getPickedImage;

  ImageInput(this.getPickedImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePhoto() async {
    final imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final storedImage = await _storedImage.copy('${appDir.path}/$fileName');
    widget.getPickedImage(storedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 9,
          child: LayoutBuilder(
            builder: (ctx, constraints) => Container(
              height: constraints.maxWidth * 0.6,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: MyColors.liteColor),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: _storedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.file(
                        _storedImage,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(
                      Icons.image,
                      color: MyColors.liteColor,
                    ),
            ),
          ),
        ),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 7,
            child: FlatButton.icon(
              icon: Icon(Icons.camera),
              label: Text('Take Photo'),
              textColor: MyColors.accentColor,
              onPressed: _takePhoto,
            )),
      ],
    );
  }
}
