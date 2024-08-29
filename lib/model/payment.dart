class Deposit {
  double amount;

  Deposit({required this.amount});

  Map<String, dynamic> toJson() {
    return {
      "amount": amount,
    };
  }
}

class DepositInitResponse {
  final String link;
  final String reference;
  final String message;
  final String error;

  DepositInitResponse({
    required this.link,
    required this.error,
    required this.message,
    required this.reference,
  });

  factory DepositInitResponse.fromJson(Map<String, dynamic> json) {
    return DepositInitResponse(
      message: json['message'].runtimeType != String && json['message'] != null
          ? json['message'][0]
          : json['message'] ?? '',
      error: json['error'] ?? "",
      link: json['link'] ?? '',
      reference: json['reference'] ?? '',
    );
  }
}

class ConfrimDepositResponse {
  final String error;
  final bool status;
  final String message;
  final num confirmationId;

  ConfrimDepositResponse({
    required this.error,
    required this.status,
    required this.message,
    required this.confirmationId,
  });

  factory ConfrimDepositResponse.fromJson(Map<String, dynamic> json) {
    return ConfrimDepositResponse(
      message: json['message'].runtimeType != String && json['message'] != null
          ? json['message'][0]
          : json['message'] ?? '',
      error: json['error'] ?? "",
      status: json['link'] ?? false,
      confirmationId: json['confirmationId'] ?? 0,
    );
  }
}
