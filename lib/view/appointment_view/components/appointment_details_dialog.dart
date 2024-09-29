import 'package:flutter/material.dart';
import 'package:youdoc/common/close_dialogue.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/model/practices.dart';

class AppointmentDetailsDialog extends StatefulWidget {
  const AppointmentDetailsDialog({
    super.key,
    required this.appointmentId,
  });

  final int appointmentId;

  @override
  State<AppointmentDetailsDialog> createState() =>
      _AppointmentDetailsDialogState();
}

class _AppointmentDetailsDialogState extends State<AppointmentDetailsDialog> {
  Practice? practice;
  // int? practiceId;
  // int? physicianId;
  // int? serviceId;
  String? time;
  Physician? physician;
  Service? service;

  bool _isLoading = false;

  void _getTheAppointmentDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.getAppointment(widget.appointmentId);
      if (response.error.isEmpty) {
        setState(() {
          // practiceId = response.practiceId;
          // physicianId = response.physicianId;
          // serviceId = response.serviceId;
          time = response.time;
        });

        // ================ GETTING THE PRACTICE DETAILS ================ //
        try {
          var practiceResponse =
              await baseRequest.getPractice(response.practiceId);
          setState(() {
            practice = practiceResponse;
          });

          // ================ GETTING THE SERVICE NAME, Physician NAME ================ //
          try {
            setState(() {
              service = practice!.services
                  .firstWhere((element) => element.id == response.serviceId);
              physician = practice!.physicians
                  .firstWhere((element) => element.id == response.physicianId);
            });
          } catch (e) {
            SnackBar snackBar = SnackBar(
              content: Text(e.toString()),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pop(context);
          }
        } catch (e) {
          SnackBar snackBar = SnackBar(
            content: Text(e.toString()),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pop(context);
        }
      } else {
        SnackBar snackBar = SnackBar(
          content: Text(response.error),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(context);
      }
    } catch (e) {
      SnackBar snackBar = const SnackBar(
        content: Text("Please check your internet connection"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  initState() {
    super.initState();
    _getTheAppointmentDetails();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 4,
            ),
          )
        : SingleChildScrollView(
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
                                    "Practice: ${practice!.practiceName}",
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
                                  service!.serviceName,
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
                                        "assets/icons/user.png",
                                        width: 18,
                                        color: TColor.inputGray,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Physician",
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
                                      Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child:
                                              //  image == "" ?
                                              Image.asset(
                                            "assets/icons/user.png",
                                            width: 24,
                                            height: 24,
                                          )
                                          // : Image.network(image),
                                          ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "${physician!.firstName} ${physician!.lastName}",
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
                          ),
                          const SizedBox(
                            height: 36,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                        practice!.practiceAddress,
                                        style: TextStyle(
                                          color: TColor.btnText,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      // const SizedBox(
                                      //   width: ,
                                      // ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: const TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2,
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "Open in Google maps",
                                          style: TextStyle(
                                            color: TColor.primary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationThickness: 2,
                                          ),
                                        ),
                                      )
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
