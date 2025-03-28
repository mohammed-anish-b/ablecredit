class Car {
  String model;
  int year;
  String vehicleTag;

  Car({required this.model, required this.year, required this.vehicleTag});

  Map<String, dynamic> toJson() {
    return {
      'model': model,
      'year': year,
      'vehicle_tag': vehicleTag,
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      model: json['model'],
      year: json['year'],
      vehicleTag: json['vehicle_tag'],
    );
  }
}
