class Transaction {}

class AppointmentPay {
  final String label;
  final String abbr;

  const AppointmentPay({
    required this.abbr,
    required this.label,
  });
}

class Payment {
  const Payment({
    required this.id,
    required this.amount,
    required this.practiceName,
    required this.service,
    required this.transactionStatus,
    required this.status,
  });

  final int id;
  final double amount;
  final String practiceName;
  final String service;
  final String transactionStatus;
  final String status;
}

class PaymentPayload {
  final DateTime date;
  final String time;
  final int practiceId;
  final int physicianId;
  final int serviceId;

  PaymentPayload({
    required this.date,
    required this.time,
    required this.practiceId,
    required this.physicianId,
    required this.serviceId,
  });
}

class CreateAppointmentDto {
  final DateTime date;
  final String time;
  final int practiceId;
  final int physicianId;
  final int serviceId;
  final String type;

  CreateAppointmentDto({
    required this.date,
    required this.time,
    required this.practiceId,
    required this.physicianId,
    required this.serviceId,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'time': time,
      'practice_id': practiceId,
      'physician_id': physicianId,
      'service_id': serviceId,
      'type': type,
    };
  }
}

class AppointmentResponse {
  final String message;
  final String error;
  final dynamic data;

  AppointmentResponse({
    required this.message,
    required this.error,
    required this.data,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
        message:
            json['message'].runtimeType != String && json['message'] != null
                ? json['message'][0]
                : json['message'] ?? '',
        error: json['error'] ?? "",
        data: json['data'] ?? "");
  }
}

class GetAllTransactions {
  final int id;
  // final dynamic status;
  // final DateTime date;
  final String time;
  final int practiceId;
  final int physicianId;
  final int serviceId;
  final String error;
  final String message;

  GetAllTransactions({
    required this.id,
    // required this.status,
    // required this.date,
    required this.time,
    required this.practiceId,
    required this.physicianId,
    required this.serviceId,
    required this.error,
    required this.message,
  });

  factory GetAllTransactions.fromJson(Map<String, dynamic> json) {
    return GetAllTransactions(
      id: json['id'] ?? 0,
      // status: json['status'],
      // date: json['date'] ?? "",
      time: json['time'] ?? "",
      error: json['error'] ?? "",
      message:
            json['message'].runtimeType != String && json['message'] != null
                ? json['message'][0]
                : json['message'] ?? '',
      practiceId: json['practice_id'] ?? 0,
      physicianId: json['physician_id'] ?? 0,
      serviceId: json["service_id"] ?? 0,
    );
  }

  static List<GetAllTransactions> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => GetAllTransactions.fromJson(json)).toList();
  }
}
