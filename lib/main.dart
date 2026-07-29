import 'dart:async';

import 'package:flutter/material.dart';
import 'services/revenuecat_service.dart';
import 'services/clock_service.dart';
import 'services/alarm_service.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ClockService.instance.start();
  runApp(const App());

  unawaited(_initializeServices());
}

Future<void> _initializeServices() async {
  try {
    await AlarmService.instance.init();
  } catch (e, st) {
    debugPrint('AlarmService init failed: $e');
    debugPrintStack(stackTrace: st);
  }

  try {
    await RevenueCatService.instance.init();
  } catch (e, st) {
    debugPrint('RevenueCat init failed: $e');
    debugPrintStack(stackTrace: st);
  }
}
