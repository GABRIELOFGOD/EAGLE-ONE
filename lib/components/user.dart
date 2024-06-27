// class UserRegister {
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String sex;
//   final String dob;

//   UserRegister({
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.sex,
//     required this.dob,
//   });

//   Map<String, dynamic> toJson() => {
//         'first_name': firstName,
//         'last_name': lastName,
//         'email': email,
//         'sex': sex,
//         'dob': dob,
//       };
// }

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

class UserRegistrationComplete {
  String password;
  String confirmPassword;
  String token;

  UserRegistrationComplete({
    required this.password,
    required this.confirmPassword,
    required this.token
  });

  Map<String, dynamic> toJson() {
    return {"password": password.trim()};
  }
}

class UserRegistrationResponse {
  final String message;
  final String error;

  UserRegistrationResponse({required this.message, required this.error});

  factory UserRegistrationResponse.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserRegistrationResponse(
        message:
            json['message'].runtimeType != String && json['message'] != null
                ? json['message'][0]
                : json['message'] != null
                    ? json['message']
                    : '',
        error: json['error'] != null ? json['error'] : "");
  }
}
