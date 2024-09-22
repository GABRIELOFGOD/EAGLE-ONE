import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/model/payment.dart';
import 'package:youdoc/model/practices.dart';
import 'package:youdoc/model/transaction.dart';
import 'package:youdoc/model/user.dart';

// const String baseUrl = 'http://192.168.0.104:3002';
// const String baseUrl = 'http://192.168.0.104:3002';
const String baseUrl = 'http://lambda.youdoc.co';
const String webUrl = "http://api.youdoc.co/api";

class BaseRequest {
  var client = http.Client();

  late SharedPreferences prefs;

  BaseRequest() {
    _initializeSharedPreferences();
  }

  Future<void> _initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<UserRegistrationResponse> register(UserRegister userRegister) async {
    Uri url = Uri.parse("$baseUrl/patient/register");
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
        response.statusCode == 404 ||
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
        response.statusCode == 404 ||
        response.statusCode == 409) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request Failed, ${response.body}");
    }
  }

  Future<ConfirmTokenResponse> confirmToken(OtpRequest request) async {
    Uri url = Uri.parse("$baseUrl/patient/verify");

    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(request.toJson()));

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 409) {
      return ConfirmTokenResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request Failed");
    }
  }

  Future<ProfileResponse> profile() async {
    Uri url = Uri.parse("$baseUrl/patient/profile");
    await _initializeSharedPreferences();
    String? userToken = prefs.getString('token');

    final response =
        await http.get(url, headers: {'authorization': 'Bearer $userToken'});

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
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
        response.statusCode == 404 ||
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
        response.statusCode == 404 ||
        response.statusCode == 409) {
      return FindEmailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Request Failed");
    }
  }

  Future<List<Practice>> getAllPractices() async {
    Uri url = Uri.parse("$webUrl/users");

    try {
      final response = await http.get(url);
      print(
          'Response: ${response.body}'); // Print the raw response for debugging

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<dynamic> body = json.decode(response.body);
        return Practice.fromJsonList(body);
      } else {
        print("Failed with status code: ${response.statusCode}");
        throw Exception("Request Failed with status: ${response.body}");
      }
    } catch (e) {
      print("Error caught: $e"); // This will help log the error
      rethrow; // Rethrow to ensure it's caught in the calling function
    }
  }

  Future<Practice> getPractice(int id) async {
    final response = await http.get(Uri.parse('$webUrl/users/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return Practice.fromJson(json);
    } else {
      throw Exception('Failed to load practice');
    }
  }

  Future<DepositInitResponse> initDeposit(double amount) async {
    Uri url = Uri.parse("$baseUrl/payment/deposit");
    await _initializeSharedPreferences();
    String? userToken = prefs.getString('token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $userToken'
      },
      body: json.encode({'amount': amount}),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 409) {
      return DepositInitResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Request Failed');
    }
  }

  Future<ConfrimDepositResponse> confirmDeposit(String reference) async {
    Uri url = Uri.parse("$baseUrl/payment/confirm");
    await _initializeSharedPreferences();
    String? userToken = prefs.getString('token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $userToken'
      },
      body: json.encode({'reference': reference}),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 409) {
      return ConfrimDepositResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Request Failed');
    }
  }

  Future<AppointmentResponse> bookAppointment(
      CreateAppointmentDto appointment) async {
    Uri url = Uri.parse("$baseUrl/appointment");
    await _initializeSharedPreferences();
    String? userToken = prefs.getString('token');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': 'Bearer $userToken'
      },
      body: jsonEncode(appointment.toJson()),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 409) {
      return AppointmentResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Request Failed');
    }
  }

  Future<List<GetAllTransactions>> allAppointment() async {
    Uri url = Uri.parse("$baseUrl/appointment");

    final response = await http.get(url);

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 409) {
      // Decode the response body
      var body = jsonDecode(response.body);
      print("body here $body");
      // Check if the decoded body is a list or a map
      if (body is List) {
        // If it's already a list, we can parse it directly
        return GetAllTransactions.fromJsonList(body);
      } else if (body is Map) {
        // If it's a map, try to extract the list from the appropriate key
        if (body.containsKey('data')) {
          return GetAllTransactions.fromJsonList(body['data']);
        } else {
          // Handle other cases if the list is nested under another key or format
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Unexpected response format");
      }
    } else {
      throw Exception("Request Failed with status: ${response.statusCode}");
    }
  }

  // Future<String> checkUserExists(
  //     CreateAppointmentDto appointment) async {
  //   Uri url = Uri.parse("$baseUrl/email-exist");
  //   await _initializeSharedPreferences();
  //   String? userToken = prefs.getString('token');

  //   final response = await http.post(
  //     url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'authorization': 'Bearer $userToken'
  //     },
  //     body: jsonEncode(appointment.toJson()),
  //   );

  //   if (response.statusCode == 200 ||
  //       response.statusCode == 201 ||
  //       response.statusCode == 400 ||
  //       response.statusCode == 401 ||
  //       response.statusCode == 404 ||
  //       response.statusCode == 409) {
  //     return AppointmentResponse.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Request Failed');
  //   }
  // }
}
