import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/components/practices.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key, required this.practice});

  final Practice practice;

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  // List<Service> availableServices = [];

  Service? selectedService;

  void _openDateSelector() {
    final now = DateTime.now();
    final lastDate = DateTime(
      now.year,
      now.month + 2,
      now.day,
    );
    showDatePicker(
      context: context,
      firstDate: now,
      lastDate: lastDate,
    );
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   setState(() {
  //     availableServices = widget.practice.services;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryBg,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            size: 12,
            color: TColor.btnText,
          ),
        ),
        title: Text(
          "Book an appointment",
          style: TextStyle(
            color: TColor.btnText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: TColor.primaryBg,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 54,
            child: Container(
              color: TColor.btnBg,
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                child: SingleChildScrollView(
                  // controller: ScrollContr,
                  child: Column(
                    children: [
                      Text(
                        "For a full refund, change or cancel this appointment at least 48hrs prior.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "Any change or cancellation made within 48hrs of an appointment will result in a 50% refund",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 24,
              horizontal: 20,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  height: 43,
                  decoration: BoxDecoration(
                    color: TColor.btnBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.black,
                        hint: Text(
                          "Select service",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: TColor.btnText,
                          ),
                        ),
                        underline: Container(),
                        // icon: Icon(Icons.keyboard_arrow_down),
                        iconEnabledColor: TColor.btnBg,
                        iconDisabledColor: TColor.btnBg,
                        value: selectedService,
                        items: widget.practice.services
                            .map((service) => DropdownMenuItem(
                                  // alignment: AlignmentDirectional(10, 10/),
                                  value: service,
                                  child: Text(
                                    service.serviceName,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: TColor.btnText,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            selectedService = value;
                          });
                        },
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 18,
                        color: TColor.inputGray,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/money_icon.png",
                          color: TColor.inputGray,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Appointment fee",
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
                    selectedService == null
                        ? Text(
                            "Select a service to reveal",
                            style: TextStyle(
                              color: TColor.inputGray,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            "₦${selectedService!.bookingFee}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/icons/money_icon.png",
                          color: TColor.inputGray,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Required deposited",
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
                    selectedService == null
                        ? Text(
                            "Select a service to reveal",
                            style: TextStyle(
                              color: TColor.inputGray,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            "₦${selectedService!.requiredDownPayment}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Available dates",
                          style: TextStyle(
                            color: TColor.inputGray,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [TColor.textGrad, TColor.primary],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ).createShader(bounds);
                          },
                          child: GestureDetector(
                              onTap: _openDateSelector,
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "Pick a custom date",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              )),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
