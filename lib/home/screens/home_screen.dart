import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/assets_constants.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';
import 'package:task_management_app_flutter/constants/utils.dart';
import 'package:task_management_app_flutter/home/screens/home_two.dart';
import 'package:task_management_app_flutter/socket/services/socket_service.dart';
import '../../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String titleName = "NA";
  String profile_pic = "";

  @override
  void initState() {
    super.initState();
    // Use WidgetsBinding to ensure context is available
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SocketService socketService = Provider.of<SocketService>(context, listen: false);
      socketService.connectToRoom(getUserId(context), context); // Ensure getUser Id is defined
    });
  }

  ImageProvider<Object> getProfilePic(String profilePicUrl) {
    print("profile pic: ${profilePicUrl}");
    if (profilePicUrl.isEmpty) {
      print("Not available");
      return const AssetImage(AssetsConstants.no_profile_pic); // Use a default image asset
    } else {
      return NetworkImage(profilePicUrl); // Return a NetworkImage for the URL
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    print("NAME: ${userProvider.user.name}");
    titleName = (userProvider.user.name != "NA" ? userProvider.user.name : userProvider.user.username)!;


    return WillPopScope(
      onWillPop: () async {
        return false; // Prevent back navigation
      },
      child: Scaffold(
        backgroundColor: MyColors.boneWhite,
        appBar: AppBar(

          leading: CircleAvatar(
            backgroundImage: getProfilePic(userProvider.user.profile_pic!), // Use backgroundImage instead of foregroundImage
          ),
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello!",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: MyFonts.poppins
                ),
              ),
              Text(
                  titleName,
                  style: TextStyle(
                    fontFamily: MyFonts.poppins,
                    fontSize: 17
                  ),
              ),
            ],
          ) ,
        ),
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