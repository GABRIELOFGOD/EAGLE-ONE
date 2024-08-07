
class Message {
  final String sender;
  final String receiver;
  final String message;
  final bool read;

  Message({
    required this.message,
    required this.read,
    required this.receiver,
    required this.sender,
  });

}
