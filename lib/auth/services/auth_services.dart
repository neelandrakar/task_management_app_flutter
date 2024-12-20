import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/global_variables.dart';
import 'package:task_management_app_flutter/constants/http_error_handeling.dart';
import 'package:task_management_app_flutter/constants/secured_storage.dart';
import 'package:task_management_app_flutter/constants/utils.dart';
import 'package:task_management_app_flutter/providers/user_provider.dart';

class AuthServices{

  void login({
      required BuildContext context,
      required String input,
      required String password,
      required VoidCallback onSuccess
})async{

    try{

      Map data = {
        "input": input,
        "password": password,
        "brand": brand_name,
        "model": model_name,
        "device_id": device_id,
        "os_type": os_type,
        "os_version": os_version
      };

      String jsonBody = jsonEncode(data);
      http.Response res = await http.post(Uri.parse('$uri/v1/auth/sign-in'),
          body: jsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      HttpErroHandeling(
          response: res,
          onSuccess: () async {
            print('hello');

            final Map<String, dynamic> _jsonResponse = jsonDecode(res.body);
            final Map<String, dynamic> _jsonMsg = _jsonResponse['msg'];
            String _jsonMsgString = jsonEncode(_jsonMsg);
            String _jwt_token = _jsonMsg['jwt_token'];

            await storeData(_jsonMsgString, 'auth_key');
            Provider.of<UserProvider>(context, listen: false).setUser(_jsonMsgString);
            onSuccess.call();
          }
      );

    }catch(e){
      print("Error: $e");
      showSnackbar(e.toString());
    }
  }

  Future<void> getUserData({
    required String jwtToken,
    required BuildContext context,
    required String? storedUser,
    required VoidCallback onSuccess,
    required VoidCallback onSessionTimeout,
  })async{

    try{

      Map data = {
        "device_id": device_id,
      };

      String jsonBody = jsonEncode(data);
      // print(jsonBody);

      http.Response res = await http.post(Uri.parse('$uri/v1/auth/checkToken'),
          body: jsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': jwtToken
          });
      print(device_id);
      if(res.statusCode==401){
        showSnackbar("NEEL");
        print(jsonDecode(res.body)['error']);
        onSessionTimeout.call();

      } else {
        HttpErroHandeling(
            response: res,
            onSuccess: () async {
              print('hello===> ${res.body}');
              if (res.statusCode == 200) {
                Provider.of<UserProvider>(context, listen: false).setUser(
                    storedUser!);
              }
              onSuccess.call();
            }
        );
      }

    }catch(e){
      print("Error: $e");
      showSnackbar(e.toString());
    }
  }
}