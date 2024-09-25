import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class CloseDialogue extends StatelessWidget {
  const CloseDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: TColor.inputBg,
              ),
              padding: const EdgeInsets.all(6),
              child: Icon(
                Icons.close,
                size: 12,
                color: TColor.btnText,
              ),
            ),
          );
  }
}