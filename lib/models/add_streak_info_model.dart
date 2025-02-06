// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'add_streak_week_range.dart';

class AddStreakInfoModel {
  final int streak;
  final String streak_text;
  final List<AddStreakWeekRange> add_streak_week_range;
  AddStreakInfoModel({
    required this.streak,
    required this.streak_text,
    required this.add_streak_week_range,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'streak': streak,
      'streak_text': streak_text,
      'add_streak_week_range':
          add_streak_week_range.map((x) => x.toMap()).toList(),
    };
  }

  factory AddStreakInfoModel.fromMap(Map<String, dynamic> map) {
    return AddStreakInfoModel(
      streak: map['streak'] as int,
      streak_text: map['streak_text'] as String,
      add_streak_week_range: List<AddStreakWeekRange>.from(map['week_range']
          .map((x) => AddStreakWeekRange.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory AddStreakInfoModel.fromJson(String source) =>
      AddStreakInfoModel.fromMap(json.decode(source));
}
