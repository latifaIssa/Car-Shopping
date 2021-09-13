import 'package:car_shopping/providers/car_provider.dart';
import 'package:car_shopping/ui/pages/spash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // DbHelper.dbHelper.initDatabase();
  runApp(ChangeNotifierProvider<CarProvider>(
    create: (context) => CarProvider(),
    child: MaterialApp(
      home: SplashScreen(),
    ),
  ));
}
