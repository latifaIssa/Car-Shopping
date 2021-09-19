import 'dart:io';
import 'package:dio/dio.dart';

class ApiHelper {
  ApiHelper._();
  static ApiHelper apiHelper = ApiHelper._();
  Dio dio = Dio();

  Future<List<dynamic>> getAllCars() async {
    String url = 'https://myfakeapi.com/api/cars/';
    Response response = await dio.get(url);
    List<dynamic> cars = response.data['cars'];
    return cars;
  }
}
