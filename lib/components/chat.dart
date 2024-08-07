import 'package:youdoc/components/message.dart';
import 'package:youdoc/components/user.dart';

class Chat {
  // Practice practice;
  String practiceName; // placeholder for practice
  Patient patient;
  List<Message> messages;
  bool chatOn;

  Chat({
    required this.chatOn,
    required this.messages,
    required this.patient,
    required this.practiceName,
  });
}
