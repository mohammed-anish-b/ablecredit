import 'package:ablecredit/firebase_options.dart';
import 'package:ablecredit/models/car.dart';
import 'package:ablecredit/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'database_service.dart';

const String workTag = "car_insertion_task";

class WorkManagerService {
  void initializeWorkManager() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  void startWorkManager() {
    Workmanager().registerPeriodicTask(
      workTag,
      "insert_car_task",
      frequency: const Duration(minutes: 15),
      existingWorkPolicy: ExistingWorkPolicy.keep,
    );
  }

  void stopWorkManager() {
    Workmanager().cancelByTag(workTag);
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    DatabaseService dbService = DatabaseService();
    Car newCar = Utils.generateRandomCar();
    await dbService.addCar(newCar);
    return Future.value(true);
  });
}
