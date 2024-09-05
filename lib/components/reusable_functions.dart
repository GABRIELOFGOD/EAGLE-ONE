import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Add this for JSON serialization

enum AuthMethod { email, auth }

class UserSettings {
  final String? name;
  final String? email;
  final AuthMethod authMethod;

  UserSettings({
    this.name,
    this.email,
    required this.authMethod,
  });

  // Convert to JSON-like Map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'authMethod': authMethod.index, // Save index for enum
    };
  }

  // Create object from JSON-like Map
  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      authMethod: AuthMethod.values[json['authMethod']],
    );
  }
}

Future<void> saveUserSettings(UserSettings settings) async {
  final prefs = await SharedPreferences.getInstance();
  String jsonString = jsonEncode(settings.toJson());
  await prefs.setString('userSettings', jsonString);
}

// Retrieve from SharedPreferences
Future<UserSettings?> getUserSettings() async {
  final prefs = await SharedPreferences.getInstance();
  final settingsString = prefs.getString('userSettings');

  if (settingsString != null) {
    Map<String, dynamic> json = jsonDecode(settingsString);
    return UserSettings.fromJson(json);
  }
  return null;
}


