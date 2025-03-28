import 'dart:math';

import 'package:ablecredit/models/car.dart';
import 'package:ablecredit/services/database_service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final DatabaseService dbService = DatabaseService();
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: StreamBuilder<Car?>(
              stream: dbService.getLastInsertedCar(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Text("No car data available");
                }
                Car car = snapshot.data!;
                return Column(
                  children: [
                    Text("Model: ${car.model}"),
                    Text("Year: ${car.year}"),
                    Text("Vehicle Tag: ${car.vehicleTag}"),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Car newCar = generateRandomCar();
              dbService.addCar(newCar);
            },
            child: const Text("Add Car"),
          ),
        ],
      ),
    );
  }

  Car generateRandomCar() {
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
