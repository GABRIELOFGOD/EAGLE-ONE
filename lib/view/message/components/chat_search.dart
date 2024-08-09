import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class ChatSearchModal extends StatefulWidget {
  const ChatSearchModal({super.key});

  @override
  State<ChatSearchModal> createState() => _ChatSearchModalState();
}

class _ChatSearchModalState extends State<ChatSearchModal> {
  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 24,
      ),
      color: TColor.primaryBg,
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: 42,
                child: TextField(
                  controller: search,
                  // onChanged: (value) => {
                  //   se
                  // },
                  // ),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search for a message",
                    prefixIcon: GestureDetector(
                      onTap: () {
                        if (search.text.isNotEmpty) {
                          setState(() {
                            search.text = "";
                            // tempSearchList = [];
                          });
                        } else {
                          // widget.closeSearch();
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Icons.close,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      TColor.textGrad,
                      TColor.primary,
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
