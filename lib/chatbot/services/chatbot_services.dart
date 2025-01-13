import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ChatbotServices {
  Future<void> initiateChatbot({
    required Uint8List fileBytes, // Accept the file as bytes
    required String fileName, // File name for the uploaded file
  }) async {
    try {
      print("Chatbot is initiated");

      String chatBotUrl = "http://192.168.160.6:5000/process_audio";

      var postUri = Uri.parse(chatBotUrl);
      var request = http.MultipartRequest("POST", postUri);

      // Attach the file with the correct content type
      request.files.add(
        http.MultipartFile.fromBytes(
          'audio_file', // Key for the file
          fileBytes, // File bytes
          filename: fileName, // File name
          contentType: MediaType('audio', 'wav'), // Set content type
        ),
      );

      // Send the request and await response
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 200) {
        print("Uploaded successfully!");
        final responseBody = await response.stream.bytesToString();
        print("Response: $responseBody");
      } else {
        print("Failed to upload. Status code: ${response.statusCode}");
        final errorResponse = await response.stream.bytesToString();
        print("Error: $errorResponse");
      }
    } catch (e) {
      print("Error occurred: $e");
      // Additional error handling if needed
    }
  }
}
