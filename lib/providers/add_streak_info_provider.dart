import 'package:flutter/cupertino.dart';
import 'package:task_management_app_flutter/models/add_streak_info_model.dart';

class AddStreakInfoProvider extends ChangeNotifier {
  bool isLoading = false;

  AddStreakInfoModel addStreakInfoModel = AddStreakInfoModel(
      streak: 0,
      streak_text: "",
      add_streak_week_range: []
  );

  void getAddStreakInfo(AddStreakInfoModel _addStreakInfoModel, BuildContext context) {
    print("HELLO");
    addStreakInfoModel = _addStreakInfoModel;
    notifyListeners();
  }
}
