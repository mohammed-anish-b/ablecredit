import 'package:flutter/services.dart';

class PlatformChannelService {
  static const platform = MethodChannel('foreground_service');

  Future<void> startForegroundService() async {
    await platform.invokeMethod('startService');
  }

  Future<void> stopForegroundService() async {
    await platform.invokeMethod('stopService');
  }
}
