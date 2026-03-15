import 'package:flutter/material.dart';
import 'services/revenuecat_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize RevenueCat before the app renders.
  await RevenueCatService.instance.init();

  runApp(const App());
}
