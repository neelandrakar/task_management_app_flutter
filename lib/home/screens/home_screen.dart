import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';
import 'package:task_management_app_flutter/constants/utils.dart';
import 'package:task_management_app_flutter/home/screens/home_two.dart';
import 'package:task_management_app_flutter/socket/services/socket_service.dart';

import '../../constants/global_variables.dart';
import '../../providers/user_privider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SocketService socketService = Provider.of<SocketService>(context, listen: false);
      socketService.connectToRoom(getUserId(context), context); // Ensure getUser Id is defined
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent back navigation
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('HOME: ${userProvider.user.username}')),
            CustomButton(
              onClick: () {
                Navigator.pushNamed(context, HomeTwoScreen.routeName);
              },
              buttonText: "CLICK",
              borderRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}