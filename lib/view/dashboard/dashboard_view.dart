import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/custom_dashboard_card.dart';
import 'package:youdoc/view/dashboard/components/appointment.dart';
import 'package:youdoc/view/dashboard/components/no_address_overlay.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key, required this.noAddress});
  final bool noAddress;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final TextEditingController search = TextEditingController();
  // bool _noAddress = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 42,
                child: TextField(
                  controller: search,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search for a practice or service",
                    prefixIcon: Image.asset(
                      "assets/icons/search_icon.png",
                      width: 10,
                    ),
                    hintStyle: const TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      TColor.textGrad,
                      TColor.primary,
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: const Text(
                  "Health hub",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomCard(
                        carIcon: Image.asset(
                          "assets/icons/calendar_icon.png",
                          color: Colors.white,
                          width: 20,
                        ),
                        cardName: "Appointments",
                        value: "0",
                      ),
                      const SizedBox(
                        height: 42,
                      ),
                      const AppointmentView(appointments: "0"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (!widget.noAddress) const NoAddressOverlay(),
      ],
    );
  }
}
