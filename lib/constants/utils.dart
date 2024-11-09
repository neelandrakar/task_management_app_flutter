import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'MyColors.dart';

void showSnackbar(BuildContext context, String text){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: MyColors.fadedAppbarColor,
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Dismiss',
            disabledTextColor: MyColors.boneWhite,
            textColor: Colors.yellow,
            onPressed: () {
              //Do whatever you want
            },
          ),
          content:
          Text(
            text,
            style: const TextStyle(
                fontFamily: 'Poppins',
                color: MyColors.boneWhite
            ),
          ))
  );
}