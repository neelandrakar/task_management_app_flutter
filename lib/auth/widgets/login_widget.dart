import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/assets_constants.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';
import 'package:task_management_app_flutter/constants/global_variables.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            color: MyColors.actionsButtonColorFaded
          ),
        padding: EdgeInsets.symmetric(horizontal: horizontal_padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                onClick: (){
                  print("Google");
                },
                buttonText: "Login with Google",
                borderRadius: 10,
                textColor: MyColors.blackColor,
                buttonTextSize: 18,
                showPrefixIcon: true,
                prefixIcon: AssetsConstants.google_logo,
                width: double.infinity,
            ),
            SizedBox(height: 15),
            CustomButton(
              onClick: (){
                print("Facebook");
              },
              buttonText: "Login with Facebook",
              borderRadius: 10,
              textColor: MyColors.blackColor,
              buttonTextSize: 18,
              showPrefixIcon: true,
              prefixIcon: AssetsConstants.facebook_logo,
              width: double.infinity,
            ),
          ],
        ),
    );
  }
}
