import 'dart:math';

import 'package:ablecredit/models/car.dart';

class Utils {
  static Car generateRandomCar() {
    final List<String> models = [
      "Toyota Corolla",
      "Honda Civic",
      "Ford Mustang",
      "BMW X5",
      "Audi A4"
    ];
    final Random random = Random();
    return Car(
      model: models[random.nextInt(models.length)],
      year: 2000 + random.nextInt(25),
      vehicleTag:
          "KL${random.nextInt(100).toString().padLeft(2, '0')}XYZ${random.nextInt(9999).toString().padLeft(4, '0')}",
    );
  }
}
