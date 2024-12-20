import 'package:flutter/material.dart';

import '../providers/user_provider.dart';

double horizontal_padding = 15;
String uri = 'http://192.168.113.6:3000';
String? device_os_version = "0";
String device_id = "NA";
String model_name = "NA";
String brand_name = "NA";
String os_type = "NA"; //0==> Android, 1==> iOS
String os_version = "NA";
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> duplicateLoginKey = GlobalKey<NavigatorState>();
bool duplicateLoginDetected = false;
//late UserProvider userProvider;

