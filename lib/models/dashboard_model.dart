// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:task_management_app_flutter/models/week_list_model.dart';

import 'day_task_model.dart';

class DashboardModel {
  final String greeting_text;
  final List<WeekListModel> week_range;
  final List<DayTaskModel> day_task;
  DashboardModel({
    required this.greeting_text,
    required this.week_range,
    required this.day_task,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'greeting_text': greeting_text,
      'week_range': week_range.map((x) => x.toMap()).toList(),
      'day_task': day_task.map((x) => x.toMap()).toList(),
    };
  }

  factory DashboardModel.fromMap(Map<String, dynamic> map) {
    return DashboardModel(
      greeting_text: map['greeting_text'] as String,
      week_range: List<WeekListModel>.from(map['week_range']
          .map((x) => WeekListModel.fromMap(x))),
      day_task: List<DayTaskModel>.from(map['day_task']
          .map((x) => DayTaskModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardModel.fromJson(String source) =>
      DashboardModel.fromMap(json.decode(source));
}
