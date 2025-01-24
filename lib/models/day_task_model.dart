// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DayTaskModel {
  final int task_id;
  final String task_type_name;
  final String task_unit;
  final int hour;
  final int task_done;
  final int target;
  final String color;
  final String task_icon;
  DayTaskModel({
    required this.task_id,
    required this.task_type_name,
    required this.task_unit,
    required this.hour,
    required this.task_done,
    required this.target,
    required this.color,
    required this.task_icon,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task_id': task_id,
      'task_type_name': task_type_name,
      'task_unit': task_unit,
      'hour': hour,
      'task_done': task_done,
      'target': target,
      'color': color,
      'task_icon': task_icon,
    };
  }

  factory DayTaskModel.fromMap(Map<String, dynamic> map) {
    return DayTaskModel(
      task_id: map['task_id'] as int,
      task_type_name: map['task_type_name'] as String,
      task_unit: map['task_unit'] as String,
      hour: map['hour'] as int,
      task_done: map['task_done'] as int,
      target: map['target'] as int,
      color: map['color'] as String,
      task_icon: map['task_icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DayTaskModel.fromJson(String source) =>
      DayTaskModel.fromMap(json.decode(source));
}
