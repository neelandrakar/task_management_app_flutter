import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

// String getBrandName(){
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   String deviceName = "NA";
//   deviceName = deviceInfo.
//
//
//   return deviceName;
// }