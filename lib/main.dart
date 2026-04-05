import 'package:flutter/material.dart';
import 'services/revenuecat_service.dart';
import 'services/clock_service.dart';
import 'services/alarm_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RevenueCatService.instance.init();
  ClockService.instance.start();
  await AlarmService.instance.init();

  runApp(const App());
}
