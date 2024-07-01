import 'package:flutter/material.dart';

class PasswordFieldWithValidation extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool isVisible;
  final void Function() toggleVisibility;
  final bool Function(String)? validationCheck; // Optional validation check function

  const PasswordFieldWithValidation({super.key, 
    required this.controller,
    required this.placeholder,
    required this.isVisible,
    required this.toggleVisibility,
    this.validationCheck,
  });

  @override
  Widget build(BuildContext context) {
    String p = controller.text;
    bool isValid = validationCheck?.call(p) ?? true; // Perform validation check if provided

    return Column(
      children: [
        Container(
          height: 43.0,
          decoration: BoxDecoration(
            color: Colors.grey[850], // Change to your input background color
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: TextField(
              controller: controller,
              obscureText: !isVisible,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                hintText: placeholder,
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  color: Colors.grey, // Change to your hint color
                  fontSize: 12,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white70,
                  ),
                  onPressed: toggleVisibility,
                ),
              ),
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ),
        if (validationCheck != null) ...[
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(
                isValid ? Icons.check_circle : Icons.cancel,
                color: isValid ? Colors.green : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                isValid ? "Password is valid" : "Password is invalid",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
