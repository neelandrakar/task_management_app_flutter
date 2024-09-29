import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/assets_constants.dart';
import 'package:task_management_app_flutter/constants/global_variables.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.boneWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizonal_padding),
        child: Column(
            children: [
              Image.asset(AssetsConstants.welcome_screen_human),

            ],
        ),
      ),

    );
  }
}
