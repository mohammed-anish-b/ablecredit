import 'package:ablecredit/models/car.dart';
import 'package:ablecredit/services/database_service.dart';
import 'package:ablecredit/services/platform_channel_service.dart';
import 'package:ablecredit/services/workmanager_service.dart';
import 'package:ablecredit/utils/utils.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseService dbService = DatabaseService();
  final WorkManagerService workManagerService = WorkManagerService();
  final PlatformChannelService platformChannelService = PlatformChannelService();

  @override
  void initState() {
    workManagerService.initializeWorkManager();
    super.initState();
  }

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
              Car newCar = Utils.generateRandomCar();
              dbService.addCar(newCar);
            },
            child: const Text("Add Car"),
          ),
          ElevatedButton(
            onPressed: workManagerService.startWorkManager,
            child: const Text("Start WorkManager"),
          ),
          ElevatedButton(
            onPressed: workManagerService.stopWorkManager,
            child: const Text("Stop WorkManager"),
          ),
          ElevatedButton(
            onPressed: platformChannelService.startForegroundService,
            child: const Text("Start Foreground Service"),
          ),
          ElevatedButton(
            onPressed: platformChannelService.stopForegroundService,
            child: const Text("Stop Foreground Service"),
          ),
        ],
      ),
    );
  }
}
