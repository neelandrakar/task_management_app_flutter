import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';
import 'package:task_management_app_flutter/dashboard/services/dashboard_services.dart';
import 'package:task_management_app_flutter/dashboard/widgets/day_task_widget.dart';
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
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dashboardModel.greeting_text,
                      style: TextStyle(
                        color: MyColors.boneWhite, // Base text color
                        fontSize: 28,
                        fontFamily: MyFonts.poppins,
                        fontWeight: FontWeight.w500, // Slightly bolder for a modern feel

                        letterSpacing: 1.2, // Slightly spaced-out letters for a modern touch
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 70, // Set the desired height
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spread items evenly
                        children: List.generate(dashboardModel.week_range.length, (index) {
                          return Container(
                            width: 50,
                            child: DayWidget(
                              day: dashboardModel.week_range[index].day,
                              isToday: dashboardModel.week_range[index].isToday,
                              date: dashboardModel.week_range[index].date,
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'TODAY',
                      style: TextStyle(
                        color: MyColors.greyColor, // Base text color
                        fontSize: 16,
                        fontFamily: MyFonts.kumbhSans,
                        fontWeight: FontWeight.w500, // Slightly bolder for a modern feel

                        letterSpacing: 1.2, // Slightly spaced-out letters for a modern touch
                      ),
                    ),
                    SizedBox(height: 15),
                    Expanded( // Use Expanded to constrain the height of the GridView
                      child: GridView.count(
                        primary: false,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: List.generate(dashboardModel.day_task.length, (index) {
                          return DayTaskWidget(
                              task_type_name: dashboardModel.day_task[index].task_type_name,
                              task_icon: dashboardModel.day_task[index].task_icon,
                              target: dashboardModel.day_task[index].target,
                              total_done: dashboardModel.day_task[index].total_done,
                              task_color: dashboardModel.day_task[index].color,
                              task_unit: dashboardModel.day_task[index].task_unit,
                              streak: dashboardModel.day_task[index].streak,
                          );
                        }),
                      ),
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
