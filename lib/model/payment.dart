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
  final String message;
  final String error;

  DepositInitResponse({
    required this.link,
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
      link: json['link'] ?? ''
    );
  }
}
