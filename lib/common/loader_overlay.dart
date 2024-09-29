import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;

  const LoadingOverlay({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return const SizedBox.shrink(); // Return an empty widget if not loading
    }
    return Stack(
      children: [
        const Opacity(
          opacity: 1,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/logo-y.png",
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              CircularProgressIndicator(
                color: TColor.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
