import 'package:flutter/cupertino.dart';
import 'package:task_management_app_flutter/dashboard/services/dashboard_services.dart';
import 'package:task_management_app_flutter/models/dashboard_model.dart';

class DashboardProvider extends ChangeNotifier {
  final _dashboardService = DashboardServices();
  bool isLoading = false;

  DashboardModel dashboardModel = DashboardModel(
      greeting_text: "",
      week_range: [],
      day_task: []
  );

  void getDashboardData(DashboardModel dashboard, BuildContext context) {
    print("HELLO");
    dashboardModel = dashboard;
    notifyListeners();
  }
}
