class Service {
  int id;
  String serviceName;
  int bookingFee;
  int requiredDownPayment;
  int step;

  Service({
    required this.id,
    required this.serviceName,
    required this.bookingFee,
    required this.requiredDownPayment,
    required this.step,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? 0,
      serviceName: json['serviceName'] ?? "",
      bookingFee: json['bookingFee'] ?? 0,
      requiredDownPayment: json['requiredDownPayment'] ?? 0,
      step: json['step'] ?? 0,
    );
  }

  static List<Service> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Service.fromJson(json)).toList();
  }
}

class UserOpeningTimes {
  int id;
  String openingTime;
  String closingTime;

  UserOpeningTimes({
    required this.id,
    required this.openingTime,
    required this.closingTime,
  });

  factory UserOpeningTimes.fromJson(Map<String, dynamic> json) {
    return UserOpeningTimes(
      id: json["id"] ?? 0,
      openingTime: json["opening_time"] ?? "",
      closingTime: json["closing_time"] ?? "",
    );
  }

  static List<UserOpeningTimes> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => UserOpeningTimes.fromJson(json)).toList();
  }
}

class Practice {
  int id;
  String practiceName;
  String practiceEmail;
  String practiceImage;
  String practiceAboutText;
  String practiceAddress;
  String specialty;
  String city;
  List<Service> services;
  List<UserOpeningTimes> userOpeningTimes;

  Practice({
    required this.id,
    required this.practiceEmail,
    required this.practiceAboutText,
    required this.practiceAddress,
    required this.practiceImage,
    required this.practiceName,
    required this.specialty,
    required this.services,
    required this.userOpeningTimes,
    required this.city,
  });

  factory Practice.fromJson(Map<String, dynamic> json) {
    var servicesFromJson = json['services'] as List<dynamic>? ?? [];
    List<Service> servicesList = Service.fromJsonList(servicesFromJson);

    var userOpeningFromJson = json["UserOpeningTimes"] as List<dynamic>? ?? [];
    List<UserOpeningTimes> openingTime =
        UserOpeningTimes.fromJsonList(userOpeningFromJson);

    return Practice(
      id: json["id"] ?? 0,
      practiceAboutText: json['practiceAboutText'] ?? "",
      practiceName: json['practiceName'] ?? "",
      practiceEmail: json['practiceEmail'] ?? "",
      practiceAddress: json['practiceAddress'] ?? "",
      practiceImage: json['practiceImage'] ?? "",
      specialty: json['specialty']?['name'] ?? "",
      city: json['city'] ?? "",
      services: servicesList,
      userOpeningTimes: openingTime,
    );
  }

  static List<Practice> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Practice.fromJson(json)).toList();
  }
}
