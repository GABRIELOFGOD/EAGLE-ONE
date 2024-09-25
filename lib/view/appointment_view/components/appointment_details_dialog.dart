import 'package:flutter/material.dart';
import 'package:youdoc/common/close_dialogue.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/model/practices.dart';

class AppointmentDetailsDialog extends StatelessWidget {
  const AppointmentDetailsDialog({
    super.key,
    required this.practice,
    required this.service,
  });

  final Practice practice;
  final String service;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 50,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: TColor.dialog,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 12.5,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Appointment details",
                              style: TextStyle(
                                color: TColor.btnText,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "Practice: ${practice.practiceName}",
                              style: TextStyle(
                                color: TColor.textGray,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const CloseDialogue()
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: TColor.btnBg,
                            border: Border.all(
                                width: 1.0, color: TColor.inactiveBtn),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "Cancel appointment",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: TColor.btnBg,
                            border: Border.all(
                                width: 1.0, color: TColor.inactiveBtn),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.phone_in_talk_outlined,
                                color: Colors.white,
                                size: 12,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "Contact",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              "assets/icons/bank.png",
                              width: 18,
                              color: TColor.inputGray,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Services offered",
                              style: TextStyle(
                                color: TColor.inputGray,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: TColor.btnBg,
                          ),
                          child: Text(
                            service,
                            style: TextStyle(
                              color: TColor.btnText,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/icons/location.png",
                                  width: 18,
                                  color: TColor.inputGray,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Location",
                                  style: TextStyle(
                                    color: TColor.inputGray,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Row(
                              children: [
                                Text(
                                  practice.practiceAddress,
                                  style: TextStyle(
                                    color: TColor.btnText,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
