import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    super.key,
    required this.mainLabel,
    required this.rightLabel,
    required this.subLabel,
    this.status,
    this.viewController,
  });

  final String mainLabel;
  final String subLabel;
  final String rightLabel;
  final Widget? status;
  final void Function()? viewController;
  

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mainLabel,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                rightLabel,
                style: const TextStyle(
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
                subLabel,
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: TColor.inputBg,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: GestureDetector(
                  onTap: viewController,
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
