import 'dart:async';
import 'package:flutter/foundation.dart';

class ClockService {
  ClockService._();
  static final instance = ClockService._();

  final ValueNotifier<DateTime> now = ValueNotifier(DateTime.now());
  Timer? _timer;

  void start() {
    _timer?.cancel();
    now.value = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 30), (_) {
      now.value = DateTime.now();
    });
  }

  void dispose() {
    _timer?.cancel();
  }
}
