import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';

import '../../constants/utils.dart';
import '../../socket/services/socket_service.dart';
import '../services/dashboard_services.dart';

class AddStreakScreen extends StatefulWidget {
  static const String routeName = "/add-streak-screen";
  final int task_id;
  final String task_type_name;
  const AddStreakScreen({super.key, required this.task_id, required this.task_type_name});

  @override
  State<AddStreakScreen> createState() => _AddStreakScreenState();
}

class _AddStreakScreenState extends State<AddStreakScreen> {

  final DashboardServices dashboardService = DashboardServices();
  bool isLoading = true;
  late Future<void> _fetchAddStreakInfo;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Connect to Socket
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.connectToRoom(getUserId(context), context);

      // Initiate Dashboard Data Fetch
    });
    _fetchAddStreakInfo = _fetchAddStreakInfoFun();


  }

  Future<void> _fetchAddStreakInfoFun() async {
    try {
      dashboardService.callAddStreakInfo(
        task_id: widget.task_id,
        context: context,
        onSuccess: () {
          setState(() {
            print("Dashboard data fetched successfully!");

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
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _fetchAddStreakInfo,
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
            appBar: AppBar(
              title: Text(
                widget.task_type_name
              ),
              foregroundColor: MyColors.boneWhite,
              backgroundColor: MyColors.darkBlack,
              centerTitle: true,
              actions: [
                Icon(Icons.more_horiz_outlined),
                SizedBox(width: 10,)
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [

                ],
              ),
            ),
          );
        }
      },
    );
  }
}
