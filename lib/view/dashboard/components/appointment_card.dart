import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: TColor.cardBg,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Eve/Vision",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "AID -S437",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "AID -S437",
                style: TextStyle(
                  color: TColor.textGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Text(
              //     "View",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 10,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     // padding: EdgeInsets.only(right: 50, left: 50),
              //     foregroundColor: TColor.btnText,
              //     backgroundColor: TColor.btnBg,
              //     elevation: 5,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(50),
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: TColor.inputBg,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "View",
                    style: TextStyle(
                      color: TColor.btnText,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
