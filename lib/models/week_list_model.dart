// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeekListModel {
  final String day;
  final String date;
  final bool isToday;
  WeekListModel({
    required this.day,
    required this.date,
    required this.isToday,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'day': day,
      'date': date,
      'isToday': isToday,
    };
  }

  factory WeekListModel.fromMap(Map<String, dynamic> map) {
    return WeekListModel(
      day: map['day'] as String,
      date: map['date'] as String,
      isToday: map['isToday'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeekListModel.fromJson(String source) =>
      WeekListModel.fromMap(json.decode(source));
}
