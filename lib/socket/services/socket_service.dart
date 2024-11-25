import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:task_management_app_flutter/constants/secured_storage.dart';
import 'package:task_management_app_flutter/constants/utils.dart';

import '../../constants/global_variables.dart';

class SocketService with ChangeNotifier {
  IO.Socket? _socket;

  SocketService() {
    _initializeSocket();
  }

  void _initializeSocket() {
    _socket = IO.io(uri, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    _socket!.onConnect((_) {
      print('Connected to the socket server');
      notifyListeners();
    });

    _socket!.onDisconnect((_) {
      print('Disconnected from the socket server');
      notifyListeners();
    });
  }

  void getDuplicateLoginData(BuildContext context){
    if(_socket !=null){
        _socket!.on('device_logged_in', (data) async {
          print('Device logged in event received: $data');
          // Handle the event data (e.g., show a dialog or update the UI)
          String? auth_key = await fetchData('auth_key');
          print("auth_key===> ${auth_key}");
          if (!duplicateLoginDetected && (auth_key?.isNotEmpty ?? false)) {
          duplicateLoginDetected = true;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Device Logged In'),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () async {
                    duplicateLoginDetected = false;
                    await logOut(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }});
    }
  }

  void connectToRoom(int userId, BuildContext context) {
    if (_socket != null) {
      _socket!.connect();
      _socket!.emit('/join_room', userId); // Example event
      getDuplicateLoginData(context);
    }
  }

  void disconnect() {
    _socket?.disconnect();
  }

// Add more methods to interact with the socket as needed
}