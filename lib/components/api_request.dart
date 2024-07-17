import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youdoc/components/user.dart';

// const String baseUrl = 'http://localhost:3002';
const String baseUrl = 'http://lambda.youdoc.co';

class BaseRequest {
  var client = http.Client();

  Future<UserRegistrationResponse> register(UserRegister userRegister) async {
    Uri url = Uri.parse("$baseUrl/patient");
    final response = await http.post(url, body: userRegister.toJson());
    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 409) {
      return UserRegistrationResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request failed");
    }
  }

  Future<UserRegistrationCompleteResponse> complete(
      UserRegistrationComplete userRegistrationComplete) async {
    var email = userRegistrationComplete.email;
    Uri url = Uri.parse('$baseUrl/patient/confirm-email?email=$email');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'password': userRegistrationComplete.password}),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 409) {
      return UserRegistrationCompleteResponse.fromJson(
          json.decode(response.body));
    } else {
      throw Exception('Request Failed');
    }
  }

  Future<LoginResponse> login(UserLogin userLogin) async {
    Uri url = Uri.parse("$baseUrl/patient/login");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userLogin.toJson()),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 409) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request Failed");
    }
  }

  Future<ProfileResponse> profile(String token) async {
    Uri url = Uri.parse("$baseUrl/patient/profile?token=$token");

    final response = await http.get(url);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 409) {
      return ProfileResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request Failed");
    }
  }

  Future<FindEmailResponse> findUserEmail(String email) async {
    Uri url = Uri.parse("$baseUrl/patient/email?email=$email");

    final response = await http.get(url);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 409) {
      return FindEmailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request Failed");
    }
  }

  Future<FindEmailResponse> forgotPassword(String email) async {
    Uri url = Uri.parse("$baseUrl/patient/email?email=$email");

    final response = await http.get(url);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 409) {
      return FindEmailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request Failed");
    }
  }
}
