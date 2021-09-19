import 'dart:io';
import 'package:car_shopping/models/car_response_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String carIdCol = 'id';
final String carCol = 'car';
final String carModelCol = 'car_model';
final String carColorCol = 'car_color';
final String carModelYearCol = 'car_model_year';
final String carVinCol = 'car_vin';
final String priceCol = 'price';
final String quantityCol = 'quantity';

// final String availabilityCol = 'availability';

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  Database database;
  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + '/myEcommerce.db';
    Database database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''CREATE TABLE Cart (
            id INTEGER PRIMARY KEY, 
            $carCol TEXT, 
            $carModelCol TEXT, 
            $carColorCol TEXT, 
            $carModelYearCol INTEGER, 
            $carVinCol TEXT,
            $priceCol TEXT,
            $quantityCol INTEGER)''');
      db.execute('''CREATE TABLE Favourite ( id INTEGER PRIMARY KEY,  
            $carCol TEXT, 
            $carModelCol TEXT, 
            $carColorCol TEXT, 
            $carModelYearCol INTEGER, 
            $carVinCol TEXT,
            $priceCol TEXT)''');
    });
    return database;
  }

  addProductToCart(CarResponse carResponse) async {
    int x = await database.insert('Cart', carResponse.todBJson());
    print(x);
  }

  addProductToFavourite(CarResponse carResponse) async {
    Map map = carResponse.todBJson();
    map.remove('quantity');
    int x = await database.insert('Favourite', map);
    print(x);
  }

  Future<List<CarResponse>> getAllCart() async {
    List<Map<String, Object>> list = await database.query('Cart');

    return list.map((e) => CarResponse.fromJson(e)).toList();
  }

  Future<List<CarResponse>> getAllFavourite() async {
    List<Map<String, Object>> list = await database.query('Favourite');
    return list.map((e) => CarResponse.fromJson(e)).toList();
  }

  deleteProductFromCart(int id) async {
    database.delete('Cart', where: 'id=?', whereArgs: [id]);
  }

  deleteProductFromFavourite(int id) async {
    database.delete('Favourite', where: 'id=?', whereArgs: [id]);
  }

  updateProductQuantity(CarResponse productResponse) async {
    // productResponse.quantity = productResponse.quantity++;

    productResponse.quantity = ++productResponse.quantity;

    database.update('Cart', productResponse.todBJson(),
        where: 'id=?', whereArgs: [productResponse.id]);
  }
}
