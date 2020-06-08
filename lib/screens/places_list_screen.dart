import 'package:demogreatplacesapp/models/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/my_colors.dart';
import '../providers/places_provider.dart';
import '../widgets/place_card.dart';
import './add_place_screen.dart';
import './place_details_screen.dart';

class PlaceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false)
            .fetchAndGetData(),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<PlacesProvider>(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'No Places Add Some!',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: MyColors.liteColor,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          RaisedButton.icon(
                            icon: const Icon(Icons.add),
                            label: const Text('Add some Great Places'),
                            textColor: MyColors.deepColor,
                            color: MyColors.accentColor,
                            onPressed: () => Navigator.of(context)
                                .pushNamed(AddPlaceScreen.routeName),
                          )
                        ],
                      ),
                    ),
                    builder: (ctx, place, child) => place.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: place.items.length,
                            itemBuilder: (ctx, i) => PlaceCard(
                              id: place.items[i].id,
                              title: place.items[i].title,
                              image: place.items[i].image,
                              address: place.items[i].location.address,
                            ),
                          ),
                  ),
      ),
    );
  }
}
