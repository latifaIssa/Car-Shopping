class CarResponse {
  int id;
  String car;
  String carModel;
  String carColor;
  int carModelYear;
  String carVin;
  String price;
  bool availability;
  int quantity = 0;

  CarResponse(
      {this.id,
      this.car,
      this.carModel,
      this.carColor,
      this.carModelYear,
      this.carVin,
      this.price,
      this.availability});

  CarResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'];
    carModel = json['car_model'];
    carColor = json['car_color'];
    carModelYear = json['car_model_year'];
    carVin = json['car_vin'];
    price = json['price'];
    availability = json['availability'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car'] = this.car;
    data['car_model'] = this.carModel;
    data['car_color'] = this.carColor;
    data['car_model_year'] = this.carModelYear;
    data['car_vin'] = this.carVin;
    data['price'] = this.price;
    data['availability'] = this.availability;
    return data;
  }

  Map<String, dynamic> todBJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car'] = this.car;
    data['car_model'] = this.carModel;
    data['car_color'] = this.carColor;
    data['car_model_year'] = this.carModelYear;
    data['car_vin'] = this.carVin;
    data['price'] = this.price;
    data['quantity'] = quantity ?? 1;

    return data;
  }
}
