import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/dashboard/services/dashboard_services.dart';

import '../../constants/utils.dart';
import '../../socket/services/socket_service.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = "/dashboard-screen";

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardServices dashboardService = DashboardServices();
  late Future<void> _fetchDashboardFuture;

  Future<void> _fetchDashboardData() async {
    try {
      dashboardService.fetchDashboardData(
        context: context,
        onSuccess: () {
          print("Dashboard data fetched successfully!");
        },
      );
    } catch (e) {
      // Handle errors
      showSnackbar("Failed to fetch dashboard data: $e");
      rethrow; // Rethrow so FutureBuilder catches the error
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Connect to Socket
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.connectToRoom(getUserId(context), context);

      // Initiate Dashboard Data Fetch
    });
    _fetchDashboardFuture = _fetchDashboardData();

  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _fetchDashboardFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: MyColors.boneWhite,
            child: Center(
              child: LoadingAnimationWidget.inkDrop(
                color: MyColors.appBarColor,
                size: 40,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Failed to load data.',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _fetchDashboardFuture = _fetchDashboardData();
                    });
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else {
          // Replace with your actual dashboard content
          return Container(
            color: MyColors.boneWhite,
            child: Center(
              child: Text(
                "Dashboard Content",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
      },
    );
  }
}
