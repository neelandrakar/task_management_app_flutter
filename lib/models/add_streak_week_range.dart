// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddStreakWeekRange {
  final String day;
  final int date;
  final DateTime full_date;
  final bool isToday;
  final bool hasDone;
  AddStreakWeekRange({
    required this.day,
    required this.date,
    required this.full_date,
    required this.isToday,
    required this.hasDone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'date': date,
      'full_date': full_date,
      'isToday': isToday,
      'hasDone': hasDone,
    };
  }

  factory AddStreakWeekRange.fromMap(Map<String, dynamic> map) {
    return AddStreakWeekRange(
      day: map['day'] as String,
      date: map['date'] as int,
      full_date: DateTime.parse(map['full_date'] as String),
      isToday: map['isToday'] as bool,
      hasDone: map['hasDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddStreakWeekRange.fromJson(String source) =>
      AddStreakWeekRange.fromMap(json.decode(source));
}
