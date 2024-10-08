import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';

class DateOfBirthInput extends StatelessWidget {
  final TextEditingController dateController;
  final VoidCallback onTap;

  const DateOfBirthInput({
    super.key,
    required this.dateController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43.0,
      decoration: BoxDecoration(
        color: TColor.inputBg,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: TColor.inputBg,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                hintText: 'Date of birth',
                hintStyle: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: TColor.inputBg),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                fillColor: TColor.inputBg,
                filled: true,
                suffixIcon: GestureDetector(
                  onTap: onTap,
                  child: const Icon(
                    Icons.calendar_today,
                    color: Colors.white70,
                  ),
                ),
              ),
              style: const TextStyle(color: Colors.white70),
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }
}
