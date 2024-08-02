import "package:flutter/material.dart";
import "package:youdoc/view/dashboard/components/no_appointment.dart";

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key, required this.appointments});
  final String appointments;

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
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
            SizedBox(
              height: 18.0,
            ),
            NoAppointmentCard()
          ],
        ),
      ],
    );
  }
}
