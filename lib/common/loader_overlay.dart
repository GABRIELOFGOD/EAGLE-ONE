import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;

  const LoadingOverlay({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return SizedBox.shrink(); // Return an empty widget if not loading
    }
    return Stack(
      children: [
        const Opacity(
          opacity: 0.5,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: CircularProgressIndicator(
            color: TColor.primary,
          ),
        ),
      ],
    );
  }
}
