import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';
import 'package:task_management_app_flutter/dashboard/services/dashboard_services.dart';
import 'package:task_management_app_flutter/dashboard/widgets/day_widget.dart';
import 'package:task_management_app_flutter/models/dashboard_model.dart';

import '../../constants/utils.dart';
import '../../providers/dashboard_provider.dart';
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
  late DashboardModel dashboardModel;
  bool isLoading = true;

  Future<void> _fetchDashboardData() async {
    try {
      dashboardService.fetchDashboardData(
        context: context,
        onSuccess: () {
          setState(() {
            print("Dashboard data fetched successfully!");
            dashboardModel = Provider
                .of<DashboardProvider>(context, listen: false).dashboardModel;
            isLoading = false;
          });
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
        if (isLoading) {
          return Container(
            color: MyColors.darkBlack,
            child: Center(
              child: LoadingAnimationWidget.inkDrop(
                color: MyColors.boneWhite,
                size: 40,
              ),
            ),
          );
        } else {
          // Replace with your actual dashboard content
          return Scaffold(
            backgroundColor: MyColors.darkBlack,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      dashboardModel.greeting_text,
                      style: TextStyle(
                        color: MyColors.boneWhite, // Base text color
                        fontSize: 25,
                        fontFamily: MyFonts.poppins,
                        fontWeight: FontWeight.w500, // Slightly bolder for a modern feel
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3), // Subtle shadow for depth
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                        letterSpacing: 1.2, // Slightly spaced-out letters for a modern touch
                      ),
                    ),
                    ListView.separated(
                        itemBuilder: (context, index){
                          return DayWidget(
                              day: dashboardModel.week_range[index].day,
                              isToday: dashboardModel.week_range[index].isToday,
                              date: dashboardModel.week_range[index].date
                          );
                        },
                        separatorBuilder: (context, index){
                          return SizedBox(width: 10);
                        },
                        itemCount: dashboardModel.day_task.length
                    )
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
