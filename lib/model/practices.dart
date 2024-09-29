class Service {
  int id;
  String serviceName;
  int bookingFee;
  int requiredDownPayment;

  Service({
    required this.id,
    required this.serviceName,
    required this.bookingFee,
    required this.requiredDownPayment,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] ?? 0,
      serviceName: json['serviceName'] ?? "",
      bookingFee: json['bookingFee'] ?? 0,
      requiredDownPayment: json['requiredDownPayment'] ?? 0,
    );
  }

  static List<Service> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Service.fromJson(json)).toList();
  }
}

class Specialty {
  int id;
  String name;

  Specialty({
    required this.id,
    required this.name,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) {
    return Specialty(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
    );
  }
}

class PracticeHourlySlots {
  int id;
  int day;
  String startTime;
  String endTime;
  // String? physicianAvailability; // Set to nullable

  PracticeHourlySlots({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
    // this.physicianAvailability, // Make optional
  });

  factory PracticeHourlySlots.fromJson(Map<String, dynamic> json) {
    return PracticeHourlySlots(
      id: json["id"] ?? 0,
      day: json["day"] ?? 0,
      startTime: json["start_time"] ?? "",
      endTime: json["end_time"] ?? "",
      // physicianAvailability:
      //     json["physicianAvailability"] as String?, // Handle nullable value
    );
  }

  static List<PracticeHourlySlots> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PracticeHourlySlots.fromJson(json)).toList();
  }
}

class DaysOfTheWeekForAppointMent {
  String day;
  bool isActive;
  bool isSelected;
  int id;
  DateTime date;

  DaysOfTheWeekForAppointMent({
    required this.id,
    required this.day,
    required this.isActive,
    required this.isSelected,
    required this.date,
  });
}

class PhysicianRole {
  int id;
  String roleName;

  PhysicianRole({
    required this.id,
    required this.roleName,
  });

  factory PhysicianRole.fromJson(Map<String, dynamic> json) {
    return PhysicianRole(
      id: json['id'] ?? 0,
      roleName: json['roleName'] ?? "",
    );
  }
}

class Physician {
  int id;
  String physicianPhoto;
  String firstName;
  String lastName;
  String middleName;
  String employeeId;
  bool isDeleted;
  PhysicianRole role;

  Physician({
    required this.id,
    required this.physicianPhoto,
    required this.firstName,
    required this.lastName,
    required this.employeeId,
    required this.middleName,
    required this.isDeleted,
    required this.role,
  });

  factory Physician.fromJson(Map<String, dynamic> json) {
    return Physician(
      id: json["id"] ?? 0,
      physicianPhoto: json["physicianPhoto"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      employeeId: json["employeeId"] ?? "",
      middleName: json["middleName"] ?? "",
      isDeleted: json["isDeleted"] ?? false,
      role: PhysicianRole.fromJson(json["role"] ?? {}),
    );
  }

  static List<Physician> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Physician.fromJson(json)).toList();
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

class PracticeOpening {
  int id;
  int day;
  String openingTime;
  String closingTime;

  PracticeOpening({
    required this.id,
    required this.day,
    required this.openingTime,
    required this.closingTime,
  });

  factory PracticeOpening.fromJson(Map<String, dynamic> json) {
    return PracticeOpening(
      id: json["id"] ?? 0,
      day: json["day"] ?? 0,
      openingTime: json["opening_time"] ?? "",
      closingTime: json["closing_time"] ?? "",
    );
  }

  static List<PracticeOpening> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PracticeOpening.fromJson(json)).toList();
  }
}

class Practice {
  int id;
  String practiceName;
  String practiceEmail;
  String practiceImage;
  String practiceAboutText;
  String practiceAddress;
  Specialty specialty;
  String city;
  List<Service> services;
  List<UserOpeningTimes> userOpeningTimes;
  List<PracticeOpening> openingHours;
  List<Physician> physicians;
  List<PracticeHourlySlots> hourlySlots;
  double latitude;
  double longitude;

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
    required this.openingHours,
    required this.physicians,
    required this.hourlySlots,
    required this.latitude,
    required this.longitude,
  });

  factory Practice.fromJson(Map<String, dynamic> json) {
    return Practice(
      id: json["id"] ?? 0,
      practiceAboutText: json['practiceAboutText'] ?? "",
      practiceName: json['practiceName'] ?? "",
      practiceEmail: json['practiceEmail'] ?? "",
      practiceAddress: json['practiceAddress'] ?? "",
      practiceImage: json['practiceImage'] ?? "",
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      specialty: Specialty.fromJson(json['specialty'] ?? {}),
      city: json['city'] ?? "",
      services: Service.fromJsonList(json['services'] as List<dynamic>? ?? []),
      userOpeningTimes: UserOpeningTimes.fromJsonList(
          json["UserOpeningTimes"] as List<dynamic>? ?? []),
      openingHours: PracticeOpening.fromJsonList(
          json["openingHours"] as List<dynamic>? ?? []),
      physicians:
          Physician.fromJsonList(json["physicians"] as List<dynamic>? ?? []),
      hourlySlots: PracticeHourlySlots.fromJsonList(
          json["hourlySlots"] as List<dynamic>? ?? []),
    );
  }

  static List<Practice> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Practice.fromJson(json)).toList();
  }
}

// class DayConverted {
//   final 
// }
