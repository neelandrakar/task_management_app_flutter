import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/auth/screens/login_screen.dart';
import 'package:task_management_app_flutter/constants/secured_storage.dart';
import '../providers/user_provider.dart';
import 'MyColors.dart';
import 'global_variables.dart';

void showSnackbar(String text) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: MyColors.fadedAppbarColor,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: MyColors.boneWhite,
        textColor: Colors.yellow,
        onPressed: () {},
      ),
      content: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: MyColors.boneWhite,
        ),
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}

Future<String> getDeviceId() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String? deviceId;

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.brand; // Unique ID for Android
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceId = iosInfo.model; // Unique ID for iOS
  }

  return deviceId ?? 'Failed to get Device ID';
}

Future<void> fetchDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    device_id = androidInfo.id; // Unique ID for Android
    model_name = androidInfo.model;
    brand_name = androidInfo.brand;
    os_type = Platform.operatingSystem;
    os_version = androidInfo.version.release; // OS version for Android
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    device_id = iosInfo.identifierForVendor!; // Unique ID for iOS
    model_name = iosInfo.model;
    brand_name = iosInfo.systemName;
    os_type = iosInfo.systemVersion;
    os_version = Platform.operatingSystemVersion;
  }
}

int getUserId(BuildContext context){
  UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
  int? user_id = userProvider.user.user_id;

  return user_id;
}
logOut(BuildContext context)async{
  await deleteToken('auth_key');
  Navigator.pushNamed(context, LoginSceen.routeName);
}