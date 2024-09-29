import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/view/search_screen/search_screen.dart';

class NoAppointmentCard extends StatefulWidget {
  const NoAppointmentCard({super.key});

  @override
  State<NoAppointmentCard> createState() => _NoAppointmentCardState();
}

class _NoAppointmentCardState extends State<NoAppointmentCard> {
  final gradient = LinearGradient(colors: [TColor.textGrad, TColor.primary]);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: TColor.cardBg,
      ),
      child: SizedBox(
        height: 123,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/no_appointment.png",
                width: 176,
              ),
              const SizedBox(
                height: 18,
              ),
              ShaderMask(
                  shaderCallback: (bounds) {
                    return gradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                  },
                  child: TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        useSafeArea: true,
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => const SearchScreen(),
                      );
                    },
                    child: const Text(
                      "Book your first appointment",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),),
            ],
          ),
        ),
      ),
    );
  }
}
