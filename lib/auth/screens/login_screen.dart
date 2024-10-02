import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';

class LoginSceen extends StatefulWidget {
  static const String routeName = "/login-screen";
  const LoginSceen({super.key});

  @override
  State<LoginSceen> createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginSceen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Text(
                'This is Google Fonts',
                style: TextStyle(
                  fontFamily: MyFonts.poppins
                ),
              ),
            ],
          )
      ),
    );
  }
}
