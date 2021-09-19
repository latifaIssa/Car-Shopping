import 'package:car_shopping/data/api_helper.dart';
import 'package:car_shopping/data/db_helper.dart';
import 'package:car_shopping/models/car_response_model.dart';
import 'package:flutter/cupertino.dart';

class CarProvider extends ChangeNotifier {
  List<CarResponse> allCars, AvailableCars, cartProducts, favouriteProducts;
  CarResponse selectedCar;
  getAllCars() async {
    List<dynamic> cars = await ApiHelper.apiHelper.getAllCars();
    allCars = cars.map((e) => CarResponse.fromJson(e)).toList();
    notifyListeners();
  }

  getAvailableCars() {
    AvailableCars =
        allCars.where((element) => element.availability == true).toList();
    notifyListeners();
  }

  addToCart(CarResponse productResponse) async {
    bool productInCart = cartProducts == null
        ? false
        : cartProducts.any((x) {
            return x.id == productResponse.id;
          });

    if (productInCart) {
      productResponse.quantity = cartProducts
          .where((element) => element.id == productResponse.id)
          .first
          .quantity;
      await DbHelper.dbHelper.updateProductQuantity(productResponse);
    } else {
      await DbHelper.dbHelper.addProductToCart(productResponse);
    }

    getAllCartProdcts();
  }

  updateProductInCart(CarResponse productResponse) async {
    await DbHelper.dbHelper.updateProductQuantity(productResponse);
    getAllCartProdcts();
  }

  addToFavourite(CarResponse productResponse) async {
    bool productInFavourite = favouriteProducts == null
        ? false
        : favouriteProducts.any((x) {
            return x.id == productResponse.id;
          });

    if (productInFavourite) {
      deleteFromFavourite(productResponse.id);
    } else {
      await DbHelper.dbHelper.addProductToFavourite(productResponse);
    }

    getAllFavouriteProdcts();
  }

  deleteFromCart(int id) async {
    await DbHelper.dbHelper.deleteProductFromCart(id);
    getAllCartProdcts();
  }

  deleteFromFavourite(int id) async {
    await DbHelper.dbHelper.deleteProductFromFavourite(id);
    getAllFavouriteProdcts();
  }

  getAllCartProdcts() async {
    List<CarResponse> products = await DbHelper.dbHelper.getAllCart();
    this.cartProducts = products;
    cartProducts.forEach((element) {
      print(element.quantity);
    });
    notifyListeners();
  }

  getAllFavouriteProdcts() async {
    List<CarResponse> products = await DbHelper.dbHelper.getAllFavourite();
    this.favouriteProducts = products;
    notifyListeners();
  }

  // addOrRemoveFromFavourite(int id) async {
  //   await ApiHelper.apiHelper.addOrRemoveFromFavourite(id);
  // }

  // getFavourite() async {
  //   await ApiHelper.apiHelper.getFavourite();
  // }
}
