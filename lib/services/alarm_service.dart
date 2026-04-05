import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import '../models/alarm_data.dart';

class AlarmService {
  AlarmService._();
  static final instance = AlarmService._();

  static const _storageKey = 'mantras_alarms';

  final ValueNotifier<List<AlarmData>> alarms = ValueNotifier([]);

  late final FlutterLocalNotificationsPlugin _notifications;
  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    tz.initializeTimeZones();
    try {
      final tzName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(tzName));
    } catch (_) {
      tz.setLocalLocation(tz.getLocation('America/Bogota'));
    }

    _notifications = FlutterLocalNotificationsPlugin();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await _notifications.initialize(initSettings);

    await AndroidAlarmManager.initialize();

    _loadAlarms();
  }

  // ── Permissions ──────────────────────────────────────────────────

  Future<bool> requestNotificationPermission() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<bool> requestExactAlarmPermission() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.scheduleExactAlarm.status;
    if (status.isGranted) return true;
    final result = await Permission.scheduleExactAlarm.request();
    return result.isGranted;
  }

  Future<bool> ensurePermissions() async {
    final notif = await requestNotificationPermission();
    final exact = await requestExactAlarmPermission();
    return notif && exact;
  }

  // ── CRUD ─────────────────────────────────────────────────────────

  void _loadAlarms() {
    final raw = _prefs.getString(_storageKey);
    if (raw != null && raw.isNotEmpty) {
      try {
        alarms.value = AlarmData.listFromJsonString(raw);
      } catch (_) {
        alarms.value = [];
      }
    }
  }

  Future<void> _saveAlarms() async {
    await _prefs.setString(
        _storageKey, AlarmData.listToJsonString(alarms.value));
  }

  Future<AlarmData> createAlarm({
    required int hour,
    required int minute,
    List<int> weekdays = const [],
    String name = 'Alarma',
    String? voice,
    String frequency = 'daily',
  }) async {
    final id = DateTime.now().millisecondsSinceEpoch % 0x7FFFFFFF;
    final alarm = AlarmData(
      id: id,
      hour: hour,
      minute: minute,
      weekdays: weekdays,
      name: name,
      voice: voice,
      frequency: frequency,
    );
    alarms.value = [...alarms.value, alarm];
    await _saveAlarms();
    await _scheduleAlarm(alarm);
    return alarm;
  }

  Future<void> toggleAlarm(int id) async {
    final list = [...alarms.value];
    final idx = list.indexWhere((a) => a.id == id);
    if (idx == -1) return;
    list[idx] = list[idx].copyWith(active: !list[idx].active);
    alarms.value = list;
    await _saveAlarms();

    if (list[idx].active) {
      await _scheduleAlarm(list[idx]);
    } else {
      await _cancelAlarm(id);
    }
  }

  Future<void> deleteAlarm(int id) async {
    await _cancelAlarm(id);
    alarms.value = alarms.value.where((a) => a.id != id).toList();
    await _saveAlarms();
  }

  // ── Scheduling ───────────────────────────────────────────────────

  Future<void> _scheduleAlarm(AlarmData alarm) async {
    if (!alarm.active) return;

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      alarm.hour,
      alarm.minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await AndroidAlarmManager.oneShotAt(
      scheduled,
      alarm.id,
      _alarmCallback,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  Future<void> _cancelAlarm(int id) async {
    await AndroidAlarmManager.cancel(id);
  }

  @pragma('vm:entry-point')
  static Future<void> _alarmCallback(int id) async {
    final plugin = FlutterLocalNotificationsPlugin();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await plugin.initialize(initSettings);

    const androidDetails = AndroidNotificationDetails(
      'mantras_alarms',
      'Alarmas Mantras',
      channelDescription: 'Alarmas de la app Mantras',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      fullScreenIntent: true,
    );
    const details = NotificationDetails(android: androidDetails);

    await plugin.show(
      id,
      'Mantras',
      'Tu alarma está sonando',
      details,
    );
  }
}
