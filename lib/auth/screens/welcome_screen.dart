import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:task_management_app_flutter/auth/screens/login_screen.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/assets_constants.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String _deviceId = 'Unknown'; // State variable to hold device ID

  @override
  void initState() {
    super.initState();
    // Optionally fetch device ID here
    _fetchDeviceId();
  }

  Future<void> _fetchDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceId;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // Unique ID for Android
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor; // Unique ID for iOS
    }

    setState(() {
      _deviceId = deviceId ?? 'Failed to get Device ID'; // Update state
      print("My device: ${_deviceId}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // Call the function here if you want, but it's not recommended
    // _fetchDeviceId(); // Uncommenting this will cause issues

    return Scaffold(
      backgroundColor: MyColors.boneWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset(AssetsConstants.welcome_screen_human, width: 250, height: 250)),
              const SizedBox(height: 150),
              const Text(
                "Task Management &\nTo-Do List",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: MyFonts.poppins,
                  color: MyColors.blackColor,
                ),
              ),
              SizedBox(height: 15),
              const Text(
                "This productive tool is designed to help you better manage your task project-wise conveniently!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: MyFonts.poppins,
                  color: MyColors.fadedBlack,
                ),
              ),
              SizedBox(height: 30),
              CustomButton(
                width: double.infinity,
                onClick: () async {
                  // You can use _deviceId here if needed
                  print("Device ID: $_deviceId"); // Example of using device ID
                  _fetchDeviceId();
                  // Navigator.pushNamed(context, LoginSceen.routeName);
                },
                buttonText: "Let's Start",
                borderRadius: 20,
                buttonColor: MyColors.indigoColor,
                textColor: MyColors.boneWhite,
                fontWeight: FontWeight.bold,
                buttonTextSize: 17,
                showSuffixIcon: true,
              ),
              SizedBox(height: 20),
              Text("Device ID: $_deviceId"), // Display device ID if needed
            ],
          ),
        ),
      ),
    );
  }
}