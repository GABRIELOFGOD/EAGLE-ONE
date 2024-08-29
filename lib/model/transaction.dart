
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

class CreateAppointmentDto {
  final DateTime date;
  final String time;
  final int practiceId;
  final int physicianId;
  final int serviceId;

  CreateAppointmentDto({
    required this.date,
    required this.time,
    required this.practiceId,
    required this.physicianId,
    required this.serviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'time': time,
      'practice_id': practiceId,
      'physician_id': physicianId,
      'service_id': serviceId,
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
