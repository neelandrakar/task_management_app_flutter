import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
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
  final record = AudioRecorder();
  bool isRecording = false; // Track recording state

  void recordAudio() async {
    try {
      if (isRecording) {
        // Stop recording
        await record.stop();
        setState(() {
          isRecording = false; // Update state
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recording stopped')),
        );
      } else {
        // Start recording
        if (await record.hasPermission()) {
          await record.start(const RecordConfig(), path: 'aFullPath/myFile.m4a');
          setState(() {
            isRecording = true; // Update state
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Recording started')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Permission denied')),
          );
        }
      }
    } catch (e) {
      print('Error recording audio: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error recording audio: $e')),
      );
    }
  }

  @override
  void dispose() {
    record.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SocketService socketService = Provider.of<SocketService>(context, listen: false);
      socketService.connectToRoom(getUserId(context), context);
    });
  }

  ImageProvider<Object> getProfilePic(String profilePicUrl) {
    print("profile pic: ${profilePicUrl}");
    if (profilePicUrl.isEmpty) {
      print("Not available");
      return const AssetImage(AssetsConstants.no_profile_pic);
    } else {
      return NetworkImage(profilePicUrl);
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
            backgroundImage: getProfilePic(userProvider.user.profile_pic!),
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
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: recordAudio,
          child: Icon(isRecording ? Icons.stop : Icons.mic), // Change icon based on recording state
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('HOME: ${userProvider.user.username}')),
            CustomButton(
              onClick: () async {
                // Navigator.pushNamed(context, HomeTwoScreen.routeName);
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