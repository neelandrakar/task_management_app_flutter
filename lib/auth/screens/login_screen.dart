import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_management_app_flutter/auth/widgets/login_widget.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';

import '../../constants/assets_constants.dart';
import '../../constants/custom_appbar.dart';
import '../../constants/custom_button.dart';
import '../../constants/global_variables.dart';

class LoginSceen extends StatefulWidget {
  static const String routeName = "/login-screen";
  const LoginSceen({super.key});

  @override
  State<LoginSceen> createState() => _LoginSceenState();
}

class _LoginSceenState extends State<LoginSceen> {
  Color bg_color = MyColors.boneWhite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(

          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
              backgroundColor: bg_color,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(210),
                child: CustomAppBar(
                  module_name: "",
                  emp_name: '',
                  module_font_weight: FontWeight.w600,
                  show_emp_name: false,
                  appBarColor: bg_color,
                  titleTextColor: MyColors.appBarColor,
                  leadingIconColor: MyColors.appBarColor,

                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Container(
                      color: bg_color,
                      // padding: EdgeInsets.symmetric(horizontal: horizonal_padding),
                      child: Column(
                        children: [
                          const Text(
                            "Welcome",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: MyFonts.poppins,
                                fontSize: 22,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Login or sign up to access your\naccount',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: MyFonts.poppins,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300
                                ),
                              ),

                            ],
                          ),
                          const SizedBox(height: 20),

                          Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.boneWhite,

                            ),
                            child: TabBar(
                              indicator: BoxDecoration(
                                color: MyColors.actionsButtonColorFaded,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              labelColor: MyColors.appBarColor,
                              dividerHeight: 0,
                              tabs: const [
                                Tab(
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      fontFamily: MyFonts.poppins,
                                      fontSize: 16
                                    ),
                                  ),
                                ),

                                Tab(
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                      fontFamily: MyFonts.poppins,
                                      fontSize: 16
                                    ),
                                  ),
                                ),
                              ],
                              labelPadding:  EdgeInsets.symmetric(horizontal: horizontal_padding), // add padding to the tabs
                              indicatorSize: TabBarIndicatorSize.tab, // control the size of the tab indicator
                            )
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              body: TabBarView(
                children: [
                  LoginWidget(),
                  Center(child: Text("Page 2")),
                ],
              ),
            ),
          )
      ),
    );
  }
}
