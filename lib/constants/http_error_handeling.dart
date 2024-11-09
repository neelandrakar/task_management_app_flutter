import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_management_app_flutter/constants/utils.dart';

void HttpErroHandeling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  if (response.statusCode >= 200 && response.statusCode < 300) {
    // Handle success responses
    onSuccess();
  } else if (response.statusCode >= 300 && response.statusCode < 400) {
    // Handle redirection responses
    showSnackbar(context, 'Redirection: ${response.statusCode}');
  } else if (response.statusCode >= 400 && response.statusCode < 500) {
    // Handle client error responses
    showSnackbar(context, jsonDecode(response.body)['msg']);
  } else if (response.statusCode >= 500) {
    // Handle server error responses
    showSnackbar(context, jsonDecode(response.body)['error']);
  } else {
    // Handle other unexpected responses
    showSnackbar(context, jsonDecode(response.body));
  }
}

