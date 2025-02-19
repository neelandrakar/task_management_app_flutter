import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/models/add_streak_info_model.dart';
import 'package:task_management_app_flutter/models/dashboard_model.dart';
import 'package:task_management_app_flutter/providers/add_streak_info_provider.dart';
import 'package:task_management_app_flutter/providers/dashboard_provider.dart';
import 'package:task_management_app_flutter/providers/user_provider.dart';

import '../../constants/global_variables.dart';
import '../../constants/http_error_handeling.dart';
import '../../constants/utils.dart';

class DashboardServices{

  void fetchDashboardData({
    required BuildContext context,
    required VoidCallback onSuccess
  })async{

    try{

      Map data = {
        "date": "2025-01-23"
      };
    print("neel");
    var dashboard_provider = Provider.of<DashboardProvider>(context, listen: false);
    final user = Provider
          .of<UserProvider>(context, listen: false).user;

      String jsonBody = jsonEncode(data);
      http.Response res = await http.post(Uri.parse('$uri/v1/home/get-dashboard'),
          body: jsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.jwt_token
          });

      HttpErroHandeling(
          response: res,
          onSuccess: () async {
            print("Starting");
            var messageArray = jsonDecode(res.body)['msg'];
            print(messageArray);
            dashboard_provider.getDashboardData(DashboardModel.fromJson(jsonEncode(messageArray)), context);
            print("greet_text ${dashboard_provider.dashboardModel.greeting_text}");
            onSuccess.call();
          }
      );

    }catch(e){
      print("Error: $e");
      //showSnackbar(e.toString());
    }
  }

  void callAddStreakInfo({
    required BuildContext context,
    required VoidCallback onSuccess,
    required int task_id
  })async{

    try{

      Map data = {
        "task_id": task_id
      };
      final user = Provider
          .of<UserProvider>(context, listen: false).user;
      final addStreakProvider = Provider.of<AddStreakInfoProvider>(context, listen: false);


      String jsonBody = jsonEncode(data);
      http.Response res = await http.post(Uri.parse('$uri/v1/home/add-streak-info'),
          body: jsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.jwt_token
      });

      HttpErroHandeling(
          response: res,
          onSuccess: () async {
            print("Starting");
            print(res.body);

            var messageArray = jsonDecode(res.body)['msg'];
            addStreakProvider.getAddStreakInfo(AddStreakInfoModel.fromJson(jsonEncode(messageArray)), context);

            onSuccess.call();
          }
      );

    }catch(e){
      print("Error: $e");
      //showSnackbar(e.toString());
    }
  }
}