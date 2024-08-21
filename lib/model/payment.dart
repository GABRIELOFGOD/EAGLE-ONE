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
  final dynamic accessCode;
  final String message;
  final String error;

  DepositInitResponse({
    required this.accessCode,
    required this.error,
    required this.message,
  });

  factory DepositInitResponse.fromJson(Map<String, dynamic> json) {
    return DepositInitResponse(
      message:
          json['message'].runtimeType != String && json['message'] != null
              ? json['message'][0]
              : json['message'] ?? '',
      error: json['error'] ?? "",
      accessCode: json['access_code'] ?? ''
    );
  }
}
