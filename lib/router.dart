import 'package:flutter/material.dart';
import 'package:task_management_app_flutter/auth/screens/login_screen.dart';
import 'package:task_management_app_flutter/dashboard/screens/add_streak_screen.dart';
import 'package:task_management_app_flutter/dashboard/screens/dashboard_screen.dart';
import 'package:task_management_app_flutter/home/screens/home_screen.dart';
import 'package:task_management_app_flutter/home/screens/home_two.dart';
import 'package:task_management_app_flutter/profile/screens/profile_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {

  switch (routeSettings.name) {

    case LoginSceen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginSceen(),
      );

    case DashboardScreen.routeName: // Assuming you have a HomeScreen
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DashboardScreen(),
      );

    case AddStreakScreen.routeName:
      AddStreakScreen addStreakScreen = routeSettings.arguments as AddStreakScreen;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddStreakScreen(
          task_id: addStreakScreen.task_id,
          task_type_name: addStreakScreen.task_type_name,),
      );

    case HomeScreen.routeName: // Assuming you have a HomeScreen
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case HomeTwoScreen.routeName: // Assuming you have a HomeScreen
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeTwoScreen(),
      );

    case ProfileScreen.routeName: // Assuming you have a HomeScreen
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ProfileScreen(),
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