import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart'; // Ensure this package is added in pubspec.yaml
import 'package:task_management_app_flutter/chatbot/services/chatbot_services.dart';
import 'package:task_management_app_flutter/constants/MyColors.dart';
import 'package:task_management_app_flutter/constants/assets_constants.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';
import 'package:task_management_app_flutter/constants/my_fonts.dart';
import 'package:task_management_app_flutter/constants/utils.dart';
import 'package:task_management_app_flutter/home/screens/home_two.dart';
import 'package:task_management_app_flutter/socket/services/socket_service.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../providers/user_provider.dart';
import 'package:path/path.dart' as p;


class HomeScreen extends StatefulWidget {
  static const String routeName = "/home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String titleName = "NA";
  String profilePic = "";
  final AudioRecorder audioRecorder = AudioRecorder();
  final AudioPlayer audioPlayer = AudioPlayer();
  String? recordingPath;
  String? audioFileMp3;
  bool isRecording = false, isPlaying = false;
  final ChatbotServices chatbotServices = ChatbotServices();


  /// Dispose the recorder to free resources
  @override
  void dispose() {
    audioRecorder.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SocketService socketService =
      Provider.of<SocketService>(context, listen: false);
      socketService.connectToRoom(getUserId(context), context);
    });
  }

  Future<Uint8List> getWavFileBytes(String filePath)async{
    final file = File(filePath);
    return await file.readAsBytes();
  }

  Future<void> sendWavFileToApi(String filePath) async {
    final Uint8List fileBytes = await getWavFileBytes(filePath);
    chatbotServices.initiateChatbot(fileBytes: fileBytes, fileName: filePath);
  }




  /// Fetch the correct profile picture (default or network)
  ImageProvider<Object> getProfilePic(String profilePicUrl) {
    print("Profile pic: $profilePicUrl");
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
    titleName = (userProvider.user.name != "NA"
        ? userProvider.user.name
        : userProvider.user.username)!;

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
              Text(
                "Hello!",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: MyFonts.poppins,
                ),
              ),
              Text(
                titleName,
                style: TextStyle(
                  fontFamily: MyFonts.poppins,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print("sam");
            if (isRecording) {
              String? filePath = await audioRecorder.stop();
              if (filePath != null) {
                setState(() {
                  isRecording = false;
                  recordingPath = filePath;
                });
                print("Recording stopped. File saved at: $filePath");

                // Convert WAV to MP3
              }
            } else {
              print("HELLO");
              if (await audioRecorder.hasPermission()) {
                final Directory appDocumentsDir =
                await getApplicationDocumentsDirectory();
                final String filePath =
                p.join(appDocumentsDir.path, "recording.wav");
                print("filepath: ${filePath}");
                await audioRecorder.start(
                  const RecordConfig(),
                  path: filePath,
                );
                setState(() {
                  isRecording = true;
                  recordingPath = null;
                });
              }
            }
          },
          child: Icon(
            isRecording ? Icons.stop : Icons.mic,
          ),
        ),
        body: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (recordingPath != null)
                MaterialButton(
                  onPressed: () async {
                    if (audioPlayer.playing) {
                      audioPlayer.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      print("Playing ${audioFileMp3}");
                      await audioPlayer.setFilePath(recordingPath!);
                      audioPlayer.play();
                      setState(() {
                        isPlaying = true;
                      });
                      String outputMp3Path = "/path/to/output.mp3";

                      await sendWavFileToApi(recordingPath!);
                    }
                  },
                  color: Theme.of(context).colorScheme.primary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isPlaying
                            ? "Stop Playing Recording"
                            : "Start Playing Recording",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "audio_path: ",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              if (recordingPath == null)
                const Text(
                  "User, say something...",
                ),
            ],
          ),
        ),
      ),
    );
  }
}


