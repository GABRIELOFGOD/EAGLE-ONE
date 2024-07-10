import 'package:flutter/material.dart';

class CustomAnchor extends StatelessWidget {
  final String text;
  final VoidCallback clicked;
  final Color? textColor;
  final double? myFontSize;
  final TextStyle? textStyle;

  const CustomAnchor({
    super.key,
    required this.text,
    required this.clicked,
    this.myFontSize,
    this.textColor,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clicked,
      child: Text(
        text,
        style: textStyle ??
            TextStyle(
              color: textColor ?? Colors.white,
              decoration: TextDecoration.underline,
              decorationColor: textColor ?? Colors.white,
              decorationThickness: 3,
              decorationStyle: TextDecorationStyle.solid,
              fontSize: myFontSize ?? 16,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
