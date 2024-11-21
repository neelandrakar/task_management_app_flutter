import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management_app_flutter/auth/services/auth_services.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/assets_constants.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';
import 'package:task_management_app_flutter/constants/global_variables.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';
import 'package:task_management_app_flutter/constants/secured_storage.dart';
import 'package:task_management_app_flutter/home/screens/home_screen.dart';

import '../../constants/custom_textfield.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  TextEditingController _inputController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _checkUsernamePasswordKey = GlobalKey<FormState>();
  AuthServices authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MyColors.actionsButtonColorFaded
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontal_padding).copyWith(top: horizontal_padding + 30, bottom: 5),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
              onClick: ()async{
                print("Facebook");
                String? token = await fetchData('auth_key');
                print(token);
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
                    'or continue with different method',
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
              controller: _inputController,
              decoration: InputDecoration(
                hintText: 'Email/Username/Mobile No',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 15),
            CustomButton(
              onClick: ()async{
                print("Login");
                authServices.login(
                    context: context,
                    input: _inputController.text.trim(),
                    password: _passwordController.text.trim(),
                    onSuccess: (){
                      print('done');
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },);
              },
              buttonText: "Login",
              borderRadius: 10,
              buttonColor: MyColors.appBarColor,
              textColor: MyColors.boneWhite,
              buttonTextSize: 18,
              showPrefixIcon: false,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
