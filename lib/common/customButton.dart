import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onpress;
  final bool enabled;
  final Widget? loader;

  const CustomButton({
    super.key,
    required this.title,
    this.onpress,
    this.enabled = true,
    this.loader,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: MaterialButton(
        onPressed: enabled ? onpress : null,
        color: enabled ? TColor.primary : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        minWidth: double.infinity,
        height: 45.0,
        child: loader ??
            Text(
              title,
              style: TextStyle(
                color: enabled ? Colors.white : TColor.inputBg,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
      ),
    );
  }
}
