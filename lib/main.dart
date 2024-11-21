import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/auth/screens/login_screen.dart';
import 'package:task_management_app_flutter/auth/screens/welcome_screen.dart';
import 'package:task_management_app_flutter/constants/secured_storage.dart';
import 'package:task_management_app_flutter/providers/user_privider.dart';
import 'package:task_management_app_flutter/router.dart';

import 'constants/MyColors.dart';
import 'constants/assets_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserProvider()),
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
  String? jwtToken = "";

  @override
  void initState() {
    super.initState();
    print("hi");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      jwtToken = await getToken('auth_key');
      print('token ===> $jwtToken');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1)), // replace this with your async operation
      builder: (context, snapshot) {
        if (!fullyLoaded) {
          return Container(
            color: MyColors.appBarColor,
            child: Center(
              child: Image.asset(AssetsConstants.facebook_logo),
            ),
          ); // or any other loading indicator
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Task Management App',
            onGenerateRoute: (settings) => generateRoute(settings),
            theme: ThemeData(
              // colorScheme: ColorScheme.light(),
              primaryColor: MyColors.mainYellowColor,
              useMaterial3: true,
            ),
            home: WelcomeScreen(),
          );
        }
      },
    );
  }
}