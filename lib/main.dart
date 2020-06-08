import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './constants/my_colors.dart';
import './providers/places_provider.dart';
import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PlacesProvider(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData.dark().copyWith(
          primaryColor: MyColors.primaryColor,
          accentColor: MyColors.accentColor,
          scaffoldBackgroundColor: MyColors.deepColor,
          errorColor: MyColors.errorColor,
          primaryTextTheme: TextTheme(
            headline6: TextStyle(
              color: MyColors.liteColor,
            ),
          ),
          primaryIconTheme: IconThemeData(
            color: MyColors.liteColor,
          ),
        ),
        home: PlaceListScreen(),
        routes: {
          AddPlaceScreen.routeName: (_) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (_) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
