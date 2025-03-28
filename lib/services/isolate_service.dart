import 'dart:async';
import 'dart:isolate';
import 'package:ablecredit/firebase_options.dart';
import 'package:ablecredit/models/car.dart';
import 'package:ablecredit/services/database_service.dart';
import 'package:ablecredit/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_isolate/flutter_isolate.dart';

class IsolateService {
  static Future<String> executeBackgroundTask() async {
    final receivePort = ReceivePort();
    await FlutterIsolate.spawn(_backgroundTask, receivePort.sendPort);
    return receivePort.first.toString();
  }

  static void _backgroundTask(SendPort sendPort) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Car car = Utils.generateRandomCar();
    DatabaseService databaseService = DatabaseService();
    databaseService.addCar(car);
    sendPort.send("Car added successfully");
  }
}
