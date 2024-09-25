import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common_widget/skelton/skelton.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/model/practices.dart';
import 'package:youdoc/view/appointment_view/components/appointment_details_dialog.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({
    super.key,
    required this.practiceId,
    required this.serviceId,
    required this.appointmentId,
  });

  final int practiceId;
  final int appointmentId;
  final int serviceId;

  @override
  State<AppointmentCard> createState() => _AppointmentCardState();
}

class _AppointmentCardState extends State<AppointmentCard> {
  bool _isLoading = false;

  String? service;
  String? practiceName;
  int? appointmentId;
  Practice? practice;

  void _showAppointmentDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AppointmentDetailsDialog(
        practice: practice!,
        service: service!,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getSinglePractice();
    setState(() {
      appointmentId = widget.appointmentId;
    });
  }

  String _serviceFinder(int serviceId, Practice practice) {
    String theServiceName = "";

    for (var theService in practice.services) {
      if (theService.id == serviceId) {
        theServiceName = theService.serviceName;
        break;
      }
    }

    return theServiceName;
  }

  Future<void> getSinglePractice() async {
    setState(() {
      _isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var practicer = await baseRequest.getPractice(widget.practiceId);
      setState(() {
        service = _serviceFinder(widget.serviceId, practicer);
        practiceName = practicer.practiceName;
        practice = practicer;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showAppointmentDialog,
      child: Container(
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
                _isLoading || service == null
                    ? const Skelton(
                        width: 150,
                      )
                    : Text(
                        service!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                _isLoading || appointmentId == null
                    ? const Skelton(
                        width: 80,
                      )
                    : Text(
                        "YDC-AP$appointmentId",
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
                _isLoading || practiceName == null
                    ? const Skelton(
                        width: 120,
                      )
                    : Text(
                        practiceName!,
                        style: TextStyle(
                          color: TColor.textGray,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                _isLoading || practice == null
                    ? const Skelton(
                        width: 20,
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: TColor.inputBg,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: GestureDetector(
                          onTap: _showAppointmentDialog,
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
      ),
    );
  }
}
