import 'package:flutter/material.dart';

class PopUp extends StatelessWidget {
  final String message;
  final String primaryButtonText;
  final String? secondaryButtonText; // Optional for the conditional button
  final VoidCallback onPrimaryButtonPressed;
  final VoidCallback? onSecondaryButtonPressed; // Optional for the conditional button

  const PopUp({
    super.key,
    required this.message,
    required this.primaryButtonText,
    this.secondaryButtonText,
    required this.onPrimaryButtonPressed,
    this.onSecondaryButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message),
      actions: [
        TextButton(
          onPressed: onPrimaryButtonPressed,
          child: Text(primaryButtonText),
        ),
        if (secondaryButtonText != null && onSecondaryButtonPressed != null)
          TextButton(
            onPressed: onSecondaryButtonPressed,
            child: Text(secondaryButtonText!),
          ),
      ],
    );
  }
}
