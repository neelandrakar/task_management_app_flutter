import 'package:flutter/cupertino.dart';
import 'package:task_management_app_flutter/dashboard/services/dashboard_services.dart';

class DashboardProvider extends ChangeNotifier{

  final _dashboardService = DashboardServices();
  bool isLoading = false;
}