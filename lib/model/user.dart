class UserRegister {
  String firstName;
  String lastName;
  String email;
  String? sex;
  String? dob;

  UserRegister({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.sex,
    this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName.trim(),
      'lastName': lastName.trim(),
      'email': email.trim(),
      'sex': sex,
      'dob': dob,
    };
  }
}

class Patient {
  final String firstName;
  final String lastName;
  final String email;
  final String sex;
  final String dob;

  Patient({
    required this.dob,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.sex
  });
}

class UserRegistrationComplete {
  String password;
  String confirmPassword;
  String email;

  UserRegistrationComplete(
      {required this.password,
      required this.confirmPassword,
      required this.email});

  Map<String, dynamic> toJson() {
    return {
      "password": password.trim(),
    };
  }
}

class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      "email": email.trim(),
      "password": password.trim(),
    };
  }
}

class UserRegistrationResponse {
  final String message;
  final String error;
  final String email;

  UserRegistrationResponse({
    required this.message,
    required this.error,
    required this.email,
  });

  factory UserRegistrationResponse.fromJson(Map<String, dynamic> json) {
    // print(json);
    return UserRegistrationResponse(
      message: json['message'].runtimeType != String && json['message'] != null
          ? json['message'][0]
          : json['message'] ?? '',
      error: json['error'] ?? "",
      email: json['email'] ?? "",
    );
  }
}

class UserRegistrationCompleteResponse {
  final String message;
  final String error;

  UserRegistrationCompleteResponse({
    required this.message,
    required this.error,
  });

  factory UserRegistrationCompleteResponse.fromJson(Map<String, dynamic> json) {
    // print(json);
    return UserRegistrationCompleteResponse(
      message: json['message'].runtimeType != String && json['message'] != null
          ? json['message'][0]
          : json['message'] ?? '',
      error: json['error'] ?? "",
    );
  }
}

class ConfirmTokenResponse {
  final String message;
  final String error;
  final String token;

  ConfirmTokenResponse({
    required this.message,
    required this.error,
    required this.token,
  });

  factory ConfirmTokenResponse.fromJson(Map<String, dynamic> json) {
    // print(json);
    return ConfirmTokenResponse(
      message: json['message'].runtimeType != String && json['message'] != null
          ? json['message'][0]
          : json['message'] ?? '',
      error: json['error'] ?? "",
      token: json['token'] ?? "",
    );
  }
}

// class UserRegistrationResponse {
//   final String message;
//   final String error;

//   UserRegistrationResponse({required this.message, required this.error});

//   factory UserRegistrationResponse.fromJson(Map<String, dynamic> json) {
//     print(json);
//     return UserRegistrationResponse(
//         message:
//             json['message'].runtimeType != String && json['message'] != null
//                 ? json['message'][0]
//                 : json['message'] ?? '',
//         error: json['error'] ?? "");
//   }
// }

class LoginResponse {
  final String message;
  final String error;
  final String token;

  LoginResponse({
    required this.message,
    required this.error,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        message:
            json['message'].runtimeType != String && json['message'] != null
                ? json['message'][0]
                : json['message'] ?? '',
        error: json['error'] ?? "",
        token: json['token'] ?? "");
  }
}

class ProfileResponse {
  final String message;
  final String error;
  final dynamic data;

  ProfileResponse({
    required this.message,
    required this.error,
    required this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
        message:
            json['message'].runtimeType != String && json['message'] != null
                ? json['message'][0]
                : json['message'] ?? '',
        error: json['error'] ?? "",
        data: json['data'] ?? "");
  }
}

class FindEmailResponse {
  final String message;
  final bool existed;
  final String error;

  FindEmailResponse(
      {required this.message, required this.existed, required this.error});

  factory FindEmailResponse.fromJson(Map<String, dynamic> json) {
    return FindEmailResponse(
      message: json['message'].runtimeType != String && json['message'] != null
          ? json['message'][0]
          : json['message'] ?? '',
      error: json['error'] ?? "",
      existed: json["existed"] ?? false,
    );
  }
}
