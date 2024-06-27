import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youdoc/components/user.dart';

const String baseUrl = 'http://192.168.0.104:3000';

class BaseRequest {
  var client = http.Client();

  Future<UserRegistrationResponse> register(UserRegister userRegister) async {
    Uri url = Uri.parse("http://192.168.0.104:3000/user");
    final response = await http.post(url, body: userRegister.toJson());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 409) {
      return UserRegistrationResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request failed");
    }
  }

  Future<UserRegistrationResponse> complete(
      UserRegistrationComplete userRegistrationComplete) async {
    print("got here");
    var token = userRegistrationComplete.token;
    Uri url = Uri.parse("http://192.168.0.104:3000/user/confirm-email?$token");
    final response =
        await http.post(url, body: userRegistrationComplete.password);
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 409) {
      return UserRegistrationResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request Failed");
    }
  }
}

// try {
//       var payload = json.encode(object);
//       var url = Uri.parse(baseUrl + path);
//       var response = await client.post(
//         url,
//         headers: {"Content-Type": "application/json"},
//         body: payload,
//       );

//       if (response.statusCode == 201 || response.statusCode == 200) {
//         // Successful registration
//         return json.decode(response.body)["message"]; // Parse JSON response
//       } else {
        
//         throw Exception(response.body);
//       }
//     } catch (error, stackTrace) {
//       throw Exception('Failed to register user: $error');
//     }
