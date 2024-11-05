import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/assets_constants.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';
import 'package:task_management_app_flutter/constants/global_variables.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';

import '../../constants/custom_textfield.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _checkUsernamePasswordKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
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
              SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 0.5,
                          width: 100,
                          color: MyColors.fadedBlack,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                            'or continue with email',
                            style: TextStyle(
                              color: MyColors.fadedBlack,
                              fontFamily: MyFonts.poppins,
                              fontSize: 10
                            ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 0.5,
                          //width: 100,
                          color: MyColors.fadedBlack,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}
