import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class ChatCardForMessageView extends StatelessWidget {
  const ChatCardForMessageView({
    super.key,
    required this.lastMessage,
    required this.practiceName,
    required this.time,
    required this.practiceImage,
  });

  final String time;
  final String practiceName;
  final String lastMessage;
  final String practiceImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$time mins ago",
            style: TextStyle(
              color: TColor.bottomBar,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              practiceImage == ""
                  ? Image.asset(
                      "assets/images/chat_logo.png",
                      width: 45,
                      height: 45,
                    )
                  : Image.network(practiceImage),
              const SizedBox(
                width: 3.5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    practiceName,
                    style: TextStyle(
                      color: TColor.btnText,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  lastMessage == ""
                      ? Text(
                          "Tap to send a message",
                          style: TextStyle(
                            color: TColor.inputGray,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        )
                      : Text(
                          lastMessage,
                          style: TextStyle(
                            color: TColor.inputGray,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
