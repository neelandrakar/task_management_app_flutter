import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

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
      String jsonBody = jsonEncode(data);
      http.Response res = await http.post(Uri.parse('$uri/v1/home/get-dashboard'),
          body: jsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NywiaWF0IjoxNzM2MTUzMTU3fQ.caFGSiME-swQnlLkrwz33RG9B6eGjN_qtkTEL-7GvmA'
          });

      HttpErroHandeling(
          response: res,
          onSuccess: () async {
            print("Starting");
            onSuccess.call();
          }
      );

    }catch(e){
      print("Error: $e");
      //showSnackbar(e.toString());
    }
  }
}