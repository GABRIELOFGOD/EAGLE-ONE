import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/components/chat.dart';
import 'package:youdoc/components/message.dart';
import 'package:youdoc/components/user.dart';
import 'package:youdoc/view/message/components/chat_card.dart';
import 'package:youdoc/view/message/components/chat_search.dart';

class MessageView extends StatefulWidget {
  const MessageView({super.key});

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  List<Chat> chats = [
    Chat(
      chatOn: true,
      messages: [
        Message(
          message: "Hello doctor",
          read: true,
          receiver: "Evergreen Hostital",
          sender: "Sam",
        ),
        Message(
          message: "Hi Mr. Sam, how is your health?",
          read: false,
          receiver: "Sam",
          sender: "Evergreen Hostital",
        ),
      ],
      patient: Patient(
          dob: "2024-01-02",
          email: "gabriel@google.com",
          firstName: "Gabriel",
          lastName: "Ayodele",
          sex: "male"),
      practiceName: "Evergreen Hostital",
    ),
  ];

  void _openSearchBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const ChatSearchModal(),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Messages",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Chat with physicians",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: TColor.textGray,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _openSearchBottomSheet,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/search_icon.png",
                          width: 18,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Search",
                          style: TextStyle(
                            color: TColor.textGray,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Center(
                  child: chats.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/empty_message.png"),
                            const SizedBox(
                              height: 36,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Messages are empty",
                                  style: TextStyle(
                                    color: TColor.btnText,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(
                                  "Send and receive messages once you’ve booked and completed an appointment",
                                  style: TextStyle(
                                    color: TColor.textGray,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          ],
                        )
                      : Column(
                          children: chats
                              .map(
                                  (Chat chat) => const ChatCardForMessageView())
                              .toList(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
