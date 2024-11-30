import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = "/profile-screen";
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.boneWhite,
      body: Column(
        children: [

        ],
      ),
    );
  }
}
