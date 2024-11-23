import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/auth/screens/login_screen.dart';
import 'package:task_management_app_flutter/auth/screens/welcome_screen.dart';
import 'package:task_management_app_flutter/auth/services/auth_services.dart';
import 'package:task_management_app_flutter/constants/secured_storage.dart';
import 'package:task_management_app_flutter/constants/utils.dart';
import 'package:task_management_app_flutter/home/screens/home_screen.dart';
import 'package:task_management_app_flutter/providers/user_privider.dart';
import 'package:task_management_app_flutter/router.dart';
import 'package:task_management_app_flutter/socket/services/socket_service.dart';
import 'constants/MyColors.dart';
import 'constants/assets_constants.dart';
import 'constants/global_variables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
      ChangeNotifierProvider(create: (_) => SocketService()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool fullyLoaded = false;
  String? jwtToken;
  final AuthServices authServices = AuthServices();
  late Future<void> _getUserData;

  getUserData(VoidCallback onSuccess) async {
    await fetchDeviceInfo();
    String? storedUserData = await fetchData('auth_key');

    if(storedUserData!=null){
      jwtToken = jsonDecode(storedUserData)['jwt_token'];
      print('jwt: ${jwtToken}');

      await authServices.getUserData(
          jwtToken: jwtToken!,
          context: context,
          storedUser: storedUserData,
          onSuccess: () {
            setState(() {
              fullyLoaded = true;
            });
      });
    } else {
      showSnackbar("JWT token is empty...");
      setState(() {
        fullyLoaded = true;
      });
    }
    onSuccess.call();
  }

  @override
  void initState() {
    super.initState();
    _getUserData = getUserData(
        () {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData, // replace this with your async operation
      builder: (context, snapshot) {
        if (!fullyLoaded) {
          return Container(
            color: MyColors.boneWhite,
            child: Center(
              child: LoadingAnimationWidget.inkDrop(color: MyColors.appBarColor, size: 40),
            ),
          ); // or any other loading indicator
        } else {
          return MaterialApp(
            navigatorKey: duplicateLoginKey,
            debugShowCheckedModeBanner: false,
            title: 'Retail CRM Flutter',
            onGenerateRoute: (settings) => generateRoute(settings),
            theme: ThemeData(
              // colorScheme: ColorScheme.light(),
              primaryColor: MyColors.mainYellowColor,
              useMaterial3: true,
            ),
            home: Provider.of<UserProvider>(context).user.jwt_token.isNotEmpty
                ? HomeScreen()
                : WelcomeScreen(),
          );
        }
      },
    );
  }
}