import 'package:flutter/cupertino.dart';
import 'package:task_management_app_flutter/models/user_model.dart';

class UserProvider extends ChangeNotifier{

  UserModel _user = UserModel(
      user_id: 0,
      username: '',
      name: '',
      mobno: 0,
      email_id: '',
      profile_pic: '',
      password: '',
      jwt_token: '',
      creation_date: DateTime.now()
  );

  UserModel get user => _user;

  void setUser(String userStr){
    _user = UserModel.fromJson(userStr);
    notifyListeners();
  }

}