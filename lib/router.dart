import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/auth/screens/login_screen.dart';
import 'package:task_management_app_flutter/home/screens/home_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {

  switch (routeSettings.name) {

    case LoginSceen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginSceen(),
      );

    case HomeScreen.routeName: // Assuming you have a HomeScreen
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Page not found 404!"),
          ),
        ),
      );
  }
}