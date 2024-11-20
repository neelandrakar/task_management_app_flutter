import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app_flutter/constants/custom_button.dart';

import '../../constants/global_variables.dart';
import '../../providers/user_privider.dart';

class HomeTwoScreen extends StatefulWidget {
  static const String routeName = "/home-two";
  const HomeTwoScreen({super.key});

  @override
  State<HomeTwoScreen> createState() => _HomeTwoScreenState();
}

class _HomeTwoScreenState extends State<HomeTwoScreen> {
  late IO.Socket socket;

  void connectToRoom(int roomName) {
    print('Connecting to room: $roomName');
    socket = IO.io(uri, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    // Connect to the socket
    socket.connect();

    // Listen for connection event
    socket.onConnect((_) {
      print('Connected to the server');
      socket.emit('/join_room', roomName);
      print('User  has joined room: $roomName');
    });

    // Listen for the 'device_logged_in' event
    socket.on('device_logged_in', (data) {
      print('Device logged in event received: $data');
      // Handle the event data (e.g., show a dialog or update the UI)
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Device Logged In'),
          content: Text(data['message']),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });


    // // Handle disconnection
    // socket.onDisconnect((_) {
    //   socket.emit('/leave_room', roomName);
    //   print('Disconnected from the server');
    // });

    // Handle connection errors
    socket.onError((error) {
      print('Socket error: $error');
    });
  }



  @override
  void initState() {
    super.initState();
    print("hi");
    WidgetsBinding.instance.addPostFrameCallback((_) {
      connectToRoom(7);
    });
  }

  @override
  void dispose() {
    socket.dispose(); // Dispose the socket when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        return true; // Prevent back navigation
      },
      child: Scaffold(
        body: Center(child: CustomButton(onClick: (){
          socket.emit('/test_xxx', 7);
        }, buttonText: 'Call IO', borderRadius: 20)),
      ),
    );
  }
}