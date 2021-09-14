import 'package:car_shopping/data/api_helper.dart';
import 'package:car_shopping/models/car_response_model.dart';
import 'package:flutter/cupertino.dart';

class CarProvider extends ChangeNotifier {
  List<CarResponse> allCars, AvailableCars;
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
}
