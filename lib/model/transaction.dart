class Transaction {}

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
