import 'dart:convert';

class AlarmData {
  final int id;
  final int hour;
  final int minute;
  final List<int> weekdays; // 1=Mon … 7=Sun, empty = one-shot
  final String name;
  final String? voice;
  final String frequency; // 'once', 'daily', 'custom'
  bool active;

  AlarmData({
    required this.id,
    required this.hour,
    required this.minute,
    this.weekdays = const [],
    this.name = 'Alarma',
    this.voice,
    this.frequency = 'daily',
    this.active = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'hour': hour,
        'minute': minute,
        'weekdays': weekdays,
        'name': name,
        'voice': voice,
        'frequency': frequency,
        'active': active,
      };

  factory AlarmData.fromJson(Map<String, dynamic> json) => AlarmData(
        id: json['id'] as int,
        hour: json['hour'] as int,
        minute: json['minute'] as int,
        weekdays: (json['weekdays'] as List<dynamic>).cast<int>(),
        name: json['name'] as String? ?? 'Alarma',
        voice: json['voice'] as String?,
        frequency: json['frequency'] as String? ?? 'daily',
        active: json['active'] as bool? ?? true,
      );

  AlarmData copyWith({
    int? id,
    int? hour,
    int? minute,
    List<int>? weekdays,
    String? name,
    String? voice,
    String? frequency,
    bool? active,
  }) =>
      AlarmData(
        id: id ?? this.id,
        hour: hour ?? this.hour,
        minute: minute ?? this.minute,
        weekdays: weekdays ?? this.weekdays,
        name: name ?? this.name,
        voice: voice ?? this.voice,
        frequency: frequency ?? this.frequency,
        active: active ?? this.active,
      );

  static List<AlarmData> listFromJsonString(String jsonString) {
    final List<dynamic> list = json.decode(jsonString) as List<dynamic>;
    return list
        .map((e) => AlarmData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static String listToJsonString(List<AlarmData> alarms) =>
      json.encode(alarms.map((a) => a.toJson()).toList());
}
