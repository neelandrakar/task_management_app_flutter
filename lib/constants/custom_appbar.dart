import 'package:flutter/material.dart';

import 'MyColors.dart';
import 'my_fonts.dart';


class CustomAppBar extends StatelessWidget {
  final String module_name;
  final String emp_name;
  final bool show_back_button;
  final Widget? leading;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool? body_behind_appbar;
  final bool? show_emp_name;
  final Color? appBarColor;
  final Color? titleTextColor;
  final Color? leadingIconColor;
  final FontWeight? module_font_weight;
  const CustomAppBar({
    super.key,
    required this.module_name,
    required this.emp_name,
    this.show_back_button = true,
    this.bottom,
    this.leading,
    this.actions,
    this.body_behind_appbar = false,
    this.show_emp_name = true,
    this.appBarColor = MyColors.appBarColor,
    this.titleTextColor = MyColors.boneWhite,
    this.leadingIconColor = MyColors.actionsButtonColor,
    this.module_font_weight = FontWeight.w500
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColor,
      centerTitle: true,
      title: Text(
        module_name,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: MyFonts.poppins,
            fontSize: 18,
            fontWeight: FontWeight.w600
        ),
      ),
      bottom: bottom,
    );
  }
}
