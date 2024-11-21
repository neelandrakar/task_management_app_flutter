import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Define the Android options for secure storage
AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

// Create an instance of FlutterSecureStorage with the Android options
final androidStorage = FlutterSecureStorage(aOptions: _getAndroidOptions());

// Save token
Future<void> storeData(String toBeSaved, String keyName) async {
  try {
    await androidStorage.write(key: keyName, value: toBeSaved);
    print('$keyName is saved successfully');
  } catch (e) {
    print('Error saving token: $e');
  }
}

// Retrieve token
Future<String?> fetchData(String keyName) async {
  try {
    String? token = await androidStorage.read(key: keyName);
    if (token != null) {
      print('$keyName retrieved successfully: $token');
    } else {
      print('No token found for $keyName');
    }
    return token;
  } catch (e) {
    print('Error retrieving token: $e');
    return null;
  }
}

// Delete token
Future<void> deleteToken(String keyName) async {
  try {
    await androidStorage.delete(key: keyName);
    print('$keyName deleted successfully');
  } catch (e) {
    print('Error deleting token: $e');
  }
}