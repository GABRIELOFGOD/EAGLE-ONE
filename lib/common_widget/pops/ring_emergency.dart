import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';

class RingEmergency extends StatelessWidget {
  const RingEmergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          decoration: BoxDecoration(
            color: TColor.dialog,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Emergency hotline",
                        style: TextStyle(
                          color: TColor.btnText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            "Reach out to any of these numbers if you \n need immediate medical help",
                            style: TextStyle(
                              color: TColor.textGray,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: TColor.inputBg,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Icon(
                        Icons.close,
                        size: 12,
                        color: TColor.btnText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: TColor.inputBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                height: 43,
                child: Text(
                  "Fire help line - 08033235892",
                  style: TextStyle(
                    color: TColor.btnText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: TColor.inputBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                height: 43,
                child: Text(
                  "Suicide prevention - 08062106493",
                  style: TextStyle(
                    color: TColor.btnText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: TColor.inputBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                height: 43,
                child: Text(
                  "HEI (Health Emergency Initiative) - 08155554459",
                  style: TextStyle(
                    color: TColor.btnText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
