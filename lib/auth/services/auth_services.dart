import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/global_variables.dart';
import 'package:task_management_app_flutter/constants/http_error_handeling.dart';
import 'package:task_management_app_flutter/constants/secured_storage.dart';
import 'package:task_management_app_flutter/constants/utils.dart';
import 'package:task_management_app_flutter/providers/user_privider.dart';

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
        "password": password
      };

      String jsonBody = jsonEncode(data);
      http.Response res = await http.post(Uri.parse('$uri/v1/auth/sign-in'),
          body: jsonBody,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      HttpErroHandeling(
          response: res,
          context: context,
          onSuccess: () async {
            print('hello');

            final Map<String, dynamic> jsonResponse = jsonDecode(res.body);
            final Map<String, dynamic> jsonMsg = jsonResponse['msg'];
            String jsonMsgString = jsonEncode(jsonMsg);
            String jwt_token = jsonMsg['jwt_token'];

            await saveToken(jwt_token, 'auth_key');
            Provider.of<UserProvider>(context, listen: false).setUser(jsonMsgString);
            onSuccess.call();
          }
      );

    }catch(e){
      print("Error: $e");
      showSnackbar(context, e.toString());
    }





  }
}