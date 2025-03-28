import 'package:ablecredit/models/car.dart';
import 'package:ablecredit/services/database_service.dart';
import 'package:ablecredit/services/isolate_service.dart';
import 'package:ablecredit/services/platform_channel_service.dart';
import 'package:ablecredit/services/workmanager_service.dart';
import 'package:ablecredit/view/widgets/car_item.dart';
import 'package:ablecredit/view/widgets/custom_button.dart';
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
                return CarItem(car: car);
              },
            ),
          ),
          const SizedBox(height: 10),
          const CustomButton(
            onPressed: IsolateService.executeBackgroundTask,
            text: "Add Car using Isolate",
            icon: Icons.add_rounded,
          ),
          const SizedBox(height: 10),
          CustomButton(
            onPressed: workManagerService.startWorkManager,
            text: "Start WorkManager",
            icon: Icons.add_rounded,
          ),
          const SizedBox(height: 10),
          CustomButton(
            onPressed: workManagerService.stopWorkManager,
            text: "Stop WorkManager",
            icon: Icons.add_rounded,
          ),
          const SizedBox(height: 10),
          CustomButton(
            onPressed: platformChannelService.startForegroundService,
            text: "Start Foreground Service",
            icon: Icons.add_rounded,
          ),
          const SizedBox(height: 10),
          CustomButton(
            onPressed: platformChannelService.stopForegroundService,
            text: "Stop Foreground Service",
            icon: Icons.add_rounded,
          ),
        ],
      ),
    );
  }
}
