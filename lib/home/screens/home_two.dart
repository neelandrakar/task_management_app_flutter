import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';

import '../../constants/global_variables.dart';
import '../../providers/user_provider.dart';

class HomeTwoScreen extends StatefulWidget {
  static const String routeName = "/home-two";
  const HomeTwoScreen({super.key});

  @override
  State<HomeTwoScreen> createState() => _HomeTwoScreenState();
}

class _HomeTwoScreenState extends State<HomeTwoScreen> {


  @override
  void initState() {
    super.initState();
    print("hi");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //connectToRoom(7);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return true; // Prevent back navigation
      },
      child: Scaffold(
        body: Center(child: CustomButton(onClick: (){
        }, buttonText: 'Call IO', borderRadius: 20)),
      ),
    );
  }
}