import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/common/color_extention.dart';

class OtpExceeds extends StatefulWidget {
  const OtpExceeds({super.key});

  @override
  State<OtpExceeds> createState() => _OtpExceedsState();
}

class _OtpExceedsState extends State<OtpExceeds> {
  late Timer _timer;
  int _remainingTime = 1800; // 30 minutes in seconds

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  bool expander = false;

  void _startCountdown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _remainingTime = prefs.getInt('otp_exceeds_time') ?? 1800;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime > 0) {
        setState(() {
          _remainingTime--;
        });

      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Time remaining: ${_formatTime(_remainingTime)}",
              //   style: TextStyle(
              //     color: TColor.btnText,
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Try again in ${_formatTime(_remainingTime)} minutes",
                        style: TextStyle(
                          color: TColor.btnText,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: () => Navigator.pop(context),
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(100),
                  //       color: TColor.inputBg,
                  //     ),
                  //     padding: const EdgeInsets.all(6),
                  //     child: Icon(
                  //       Icons.close,
                  //       size: 12,
                  //       color: TColor.btnText,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                "You've entered an incorrect OTP five times in a row and have been temporarily blocked from retrying. Please try again in an hour.",
                style: TextStyle(
                  color: TColor.textGray,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              expander
                  ? Column(
                      children: [
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
                    )
                  : Container(
                      margin: const EdgeInsets.only(left: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Need quick aid?",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          CustomAnchor(
                            text: "Ring an emergency hotline",
                            myFontSize: 16,
                            textColor: TColor.primary,
                            clicked: () {
                              setState(() {
                                expander = true;
                              });
                            },
                          )
                        ],
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
//   const OtpExceeds({super.key});

//   @override
//   State<OtpExceeds> createState() => _OtpExceedsState();
// }

// class _OtpExceedsState extends State<OtpExceeds> {

//   late Timer _timer;
//   int _remainingTime = 60;

//   @override
//   void initState() {
//     super.initState();
//     _startCountdown();
//   }

//   void _startCountdown() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingTime > 0) {
//         setState(() {
//           _remainingTime--;
//         });
//       } else {
//         _timer.cancel();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Material(
//         color: Colors.transparent,
//         child: Container(
//           constraints: BoxConstraints(
//             maxHeight: MediaQuery.of(context).size.height * 0.9,
//           ),
//           decoration: BoxDecoration(
//             color: TColor.dialog,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           padding: const EdgeInsets.all(20),
//           width: MediaQuery.of(context).size.width * 0.9,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Emergency hotline",
//                         style: TextStyle(
//                           color: TColor.btnText,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 6,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "Reach out to any of these numbers if you \n need immediate medical help",
//                             style: TextStyle(
//                               color: TColor.textGray,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                             softWrap: true,
//                             overflow: TextOverflow.clip,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         color: TColor.inputBg,
//                       ),
//                       padding: const EdgeInsets.all(6),
//                       child: Icon(
//                         Icons.close,
//                         size: 12,
//                         color: TColor.btnText,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(
//                 height: 36,
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 14,
//                   horizontal: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: TColor.inputBg,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 width: double.infinity,
//                 height: 43,
//                 child: Text(
//                   "Fire help line - 08033235892",
//                   style: TextStyle(
//                     color: TColor.btnText,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 14,
//                   horizontal: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: TColor.inputBg,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 width: double.infinity,
//                 height: 43,
//                 child: Text(
//                   "Suicide prevention - 08062106493",
//                   style: TextStyle(
//                     color: TColor.btnText,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 12,
//               ),
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 14,
//                   horizontal: 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: TColor.inputBg,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 width: double.infinity,
//                 height: 43,
//                 child: Text(
//                   "HEI (Health Emergency Initiative) - 08155554459",
//                   style: TextStyle(
//                     color: TColor.btnText,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }