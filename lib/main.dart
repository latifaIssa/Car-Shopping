import 'package:car_shopping/providers/car_provider.dart';
import 'package:car_shopping/services/routes.dart';
import 'package:car_shopping/ui/pages/Favourite_page.dart';
import 'package:car_shopping/ui/pages/avaliable_cars.dart';
import 'package:car_shopping/ui/pages/cart_page.dart';
import 'package:car_shopping/ui/pages/home_page.dart';
import 'package:car_shopping/ui/pages/search_page.dart';
import 'package:car_shopping/ui/pages/spash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // DbHelper.dbHelper.initDatabase();
  runApp(ChangeNotifierProvider<CarProvider>(
    create: (context) => CarProvider(),
    child: MaterialApp(
      routes: {
        CartPage.routeName: (context) => CartPage(),
        FavouritePage.routeName: (context) => FavouritePage(),
        HomePage.routeName: (context) => HomePage(),
        SearchPage.routeName: (context) => SearchPage(),
        AvaliableCarsPage.routeName: (context) => AvaliableCarsPage(),
      },
      navigatorKey: RouteHelper.routeHelper.navKey,
      home: SplashScreen(),
    ),
  ));
}
