import "package:flutter/material.dart";
import "package:youdoc/common_widget/messages/error_dialog.dart";
import "package:youdoc/components/api_request.dart";
import "package:youdoc/view/dashboard/components/appointment_card.dart";
import "package:youdoc/view/dashboard/components/no_appointment.dart";
import "package:youdoc/view/dashboard/components/some_appointments.dart";
import "package:youdoc/model/transaction.dart";

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key});

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  bool isLoading = false;
  late List<GetAllTransactions> allAppointments = [];

  @override
  void initState() {
    super.initState();
    _getAppointments();
  }

  Future<void> _getAppointments() async {
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.allAppointment();
      print("Response here fa $response");
      setState(() {
        allAppointments = response;
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
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Appointments",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 18.0,
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 5,
                    ),
                  )
                : allAppointments.isEmpty
                    ? const NoAppointmentCard()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: allAppointments.length,
                        itemBuilder: (context, index) {
                          final appointment = allAppointments[index];
                          return AppointmentCard(
                            // mainLabel: appointment.status ?? "waiting",
                            mainLabel: "ahh",
                            rightLabel: appointment.time,
                            subLabel: "Hey",
                            // subLabel: appointment.date.toIso8601String(),
                          );
                        }),
          ],
        ),
      ],
    );
  }
}
