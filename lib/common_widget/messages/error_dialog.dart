import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class CustomDialog extends StatelessWidget {
  final String message;
  final String title;
  final String sub;
  final String closeText;
  final Color btnColor;
  final Color? btnTextColor;
  final VoidCallback onClose;

  const CustomDialog({
    super.key,
    required this.message,
    required this.onClose,
    required this.title,
    required this.sub,
    required this.closeText,
    required this.btnColor,
    this.btnTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          sub,
                          style: TextStyle(
                            color: TColor.textGray,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
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
                    ),
                  ],
                ),
                const SizedBox(height: 36),
                Text(
                  message,
                  style: TextStyle(
                    color: TColor.btnText,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: onClose,
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(btnColor),
                      foregroundColor:
                          WidgetStateProperty.all<Color>(Colors.white),
                      textStyle: WidgetStateProperty.all<TextStyle>(
                        const TextStyle(fontSize: 16),
                      ),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    child: Text(
                      closeText,
                      style: TextStyle(
                        color: btnTextColor ?? Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
