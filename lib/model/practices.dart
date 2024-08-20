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

class PracticeHourlySlots {
  int id;
  int day;
  String startTime;
  String endTime;
  String physicianAvailability;

  PracticeHourlySlots({
    required this.day,
    required this.endTime,
    required this.startTime,
    required this.id,
    required this.physicianAvailability,
  });

  factory PracticeHourlySlots.fromJson(Map<String, dynamic> json) {
    return PracticeHourlySlots(
        id: json["id"] ?? 0,
        day: json["day"] ?? 0,
        startTime: json["start_time"] ?? "",
        endTime: json["end_time"] ?? "",
        physicianAvailability: json["physicianAvailability"] ?? "");
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

  DaysOfTheWeekForAppointMent({
    required this.id,
    required this.day,
    required this.isActive,
    required this.isSelected,
  });
}

class PhysicianRole {
  int id;
  String name;

  PhysicianRole({
    required this.id,
    required this.name,
  });

  factory PhysicianRole.fromJson(Map<String, dynamic> json) {
    return PhysicianRole(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }
}

class Physician {
  int id;
  String physicianPhoto;
  String firstName;
  String lastName;
  String middleName;
  bool leadPhysician;
  PhysicianRole role;

  Physician({
    required this.id,
    required this.physicianPhoto,
    required this.firstName,
    required this.lastName,
    required this.leadPhysician,
    required this.middleName,
    required this.role,
  });

  factory Physician.fromJson(Map<String, dynamic> json) {
    var roleFromJson = json["role"] as dynamic ?? "";
    PhysicianRole physicianRole = PhysicianRole.fromJson(roleFromJson);

    return Physician(
      id: json["id"] ?? 0,
      physicianPhoto: json["physicianPhoto"] ?? "",
      firstName: json["firstName"] ?? "",
      lastName: json["lastName"] ?? "",
      leadPhysician: json["leadPhysician"] ?? "",
      middleName: json["middleName"] ?? "",
      role: physicianRole,
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
  String specialty;
  String city;
  List<Service> services;
  List<UserOpeningTimes> userOpeningTimes;
  List<PracticeOpening> openingHours;
  List<Physician> physicians;
  List<PracticeHourlySlots> hourlySlots;

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
  });

  factory Practice.fromJson(Map<String, dynamic> json) {
    var servicesFromJson = json['services'] as List<dynamic>? ?? [];
    List<Service> servicesList = Service.fromJsonList(servicesFromJson);

    var userOpeningFromJson = json["UserOpeningTimes"] as List<dynamic>? ?? [];
    List<UserOpeningTimes> openingTime =
        UserOpeningTimes.fromJsonList(userOpeningFromJson);

    var practiceOpeningFromJson = json["openingHours"] as List<dynamic>? ?? [];
    List<PracticeOpening> practiceOpeningTime =
        PracticeOpening.fromJsonList(practiceOpeningFromJson);

    var physicianFromJson = json["physicians"] as List<dynamic>? ?? [];
    List<Physician> physician = Physician.fromJsonList(physicianFromJson);

    var hourlySlotsFromJson = json["hourlySlots"] as List<dynamic>? ?? [];
    List<PracticeHourlySlots> hourlySlots =
        PracticeHourlySlots.fromJsonList(hourlySlotsFromJson);

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
      openingHours: practiceOpeningTime,
      physicians: physician,
      hourlySlots: hourlySlots,
    );
  }

  static List<Practice> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Practice.fromJson(json)).toList();
  }
}

// class DayConverted {
//   final 
// }
