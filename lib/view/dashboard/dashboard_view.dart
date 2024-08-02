import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/custom_dashboard_card.dart';
import 'package:youdoc/view/dashboard/components/appointment.dart';
import 'package:youdoc/view/search_screen/search_screen.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({
    super.key,
    required this.noAddress,
    required this.name,
  });
  final bool noAddress;
  final String name;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  // final TextEditingController search = TextEditingController();
  bool showSearch = false;

  void closeSearch() {
    setState(() {
      showSearch = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    showSearch = true;
                  });
                  // print('TextField tapped');
                },
                child: SizedBox(
                  height: 42,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/icons/search_icon.png",
                          width: 10,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Search for a practice or service",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      // Replace TColor.textGrad and TColor.primary with your actual colors
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
                  child: widget.name == ""
                      ? const SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 4.0,
                          ),
                        )
                      : Row(
                          children: [
                            const Text(
                              "Hello",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )),
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
        // if (!widget.noAddress) const NoAddressOverlay(),
        if (showSearch) SearchScreen(closeSearch: closeSearch),
      ],
    );
  }
}
