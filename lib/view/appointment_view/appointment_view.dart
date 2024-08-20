import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/model/practices.dart';
import 'package:youdoc/view/appointment_view/components/appointment_day_ball.dart';
import 'package:youdoc/view/appointment_view/components/physician.dart';

class AppointmentView extends StatefulWidget {
  const AppointmentView({super.key, required this.practice});

  final Practice practice;

  @override
  State<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends State<AppointmentView> {
  // List<Service> availableServices = [];

  Physician? selectedPhysician;
  List<PracticeHourlySlots> openingTimes = [];
  PracticeHourlySlots? selectedTime;

  bool isLoading = false;
  bool get isFormValid {
    bool isValid = false;
    if (selectedDay != null &&
        selectedPhysician != null &&
        selectedTime != null &&
        selectedService != null) {
      isValid = true;
    }
    return isValid;
  }

  String convertTo12HourFormat(String time24) {
    List<String> parts = time24.split(':');
    int hours = int.parse(parts[0]);
    String period = hours >= 12 ? 'PM' : 'AM';
    hours = hours % 12;
    if (hours == 0) hours = 12;
    return '$hours$period';
  }

  Service? selectedService;
  DaysOfTheWeekForAppointMent? selectedDay;

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

  List<PracticeOpening> openingDays = [];

  final List<DaysOfTheWeekForAppointMent> appointmentData = [
    DaysOfTheWeekForAppointMent(
      id: 0,
      day: "Sun",
      isActive: false,
      isSelected: false,
    ),
    DaysOfTheWeekForAppointMent(
      id: 1,
      day: "Mon",
      isActive: false,
      isSelected: false,
    ),
    DaysOfTheWeekForAppointMent(
      id: 2,
      day: "Tue",
      isActive: false,
      isSelected: false,
    ),
    DaysOfTheWeekForAppointMent(
      id: 3,
      day: "Wed",
      isActive: false,
      isSelected: false,
    ),
    DaysOfTheWeekForAppointMent(
      id: 4,
      day: "Thu",
      isActive: false,
      isSelected: false,
    ),
    DaysOfTheWeekForAppointMent(
      id: 5,
      day: "Fri",
      isActive: false,
      isSelected: false,
    ),
    DaysOfTheWeekForAppointMent(
      id: 6,
      day: "Sat",
      isActive: false,
      isSelected: false,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openingDays = widget.practice.openingHours;
    setAppointmentDayBalls();
  }

  void setAppointmentDayBalls() {
    setState(() {
      for (var opened in openingDays) {
        for (var data in appointmentData) {
          if (opened.day == data.id) {
            data.isActive = true;
          }
        }
      }
    });
  }

  void _submitForm() {}

  // void setSelectedDay(DaysOfTheWeekForAppointMent day) {}

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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: TColor.warning,
                      size: 18,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    const Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
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
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: TColor.textGray,
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
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: appointmentData
                              .map(
                                (data) => GestureDetector(
                                  // onTap: () {
                                  //   setState(() {
                                  //     List<PracticeOpening> oneTime = [];
                                  //     for (var item in appointmentData) {
                                  //       item.isSelected = false;
                                  //     }
                                  //     if (!data.isActive) {
                                  //       // selectedDay = selectedDay;
                                  //       data.isSelected = false;
                                  //     } else {
                                  //       data.isSelected = true;
                                  //     }
                                  //     selectedDay = data;
                                  //     widget.practice.openingHours.map((time) => {
                                  //           if (time.day == data.id)
                                  //             {oneTime.add(time)}
                                  //         });
                                  //     openingTimes = oneTime;
                                  //   });
                                  // },
                                  onTap: () {
                                    setState(() {
                                      List<PracticeHourlySlots> oneTime = [];
                                      for (var item in appointmentData) {
                                        item.isSelected = false;
                                      }
                                      if (!data.isActive) {
                                        data.isSelected = false;
                                      } else {
                                        data.isSelected = true;
                                      }
                                      selectedDay = data;
                                      for (var time in widget.practice.hourlySlots) {
                                        if (time.day == data.id) {
                                          oneTime.add(time);
                                        }
                                      }

                                      // Set the new openingTimes list
                                      openingTimes = oneTime;
                                    });
                                  },
                                  child: SizedBox(
                                    width: 36,
                                    child: AppointmentBall(
                                      day: data.day,
                                      isActive: data.isActive,
                                      isSelected: data.isSelected,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),

                        // const AppointmentBall(
                        //   day: "Mon",
                        //   isActive: true,
                        //   isSelected: true,
                        // ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Available hours",
                          style: TextStyle(
                            color: TColor.inputGray,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        selectedDay == null
                            ? Text(
                                "Select a date to reveal",
                                style: TextStyle(
                                  color: TColor.textGray,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: openingTimes
                                    .map(
                                      (data) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedTime = data;
                                          });
                                        },
                                        child: SizedBox(
                                          width: 36,
                                          child: AppointmentBall(
                                            day: convertTo12HourFormat(
                                                data.startTime),
                                            isActive: true,
                                            isSelected: selectedTime != null &&
                                                    selectedTime!.id == data.id
                                                ? true
                                                : false,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),

                        // const AppointmentBall(
                        //   day: "Mon",
                        //   isActive: true,
                        //   isSelected: true,
                        // ),
                      ],
                    ),
                    // ======== AVAILABLE HOURS BALL HERE ======================= //
                    const SizedBox(height: 36),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Available physician",
                          style: TextStyle(
                            color: TColor.inputGray,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        selectedDay == null || selectedService == null
                            ? Text(
                                "Select a service and date to reveal",
                                style: TextStyle(
                                  color: TColor.textGray,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : Column(
                                children: widget.practice.physicians
                                    .map(
                                      (physician) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedPhysician = physician;
                                          });
                                        },
                                        child: PhysicianCard(
                                            image: physician.physicianPhoto,
                                            name:
                                                "${physician.firstName} ${physician.lastName} ${physician.middleName}",
                                            practice: widget
                                                .practice.practiceName,
                                            role: physician.role.name,
                                            isSelected:
                                                selectedPhysician != null &&
                                                    selectedPhysician!.id ==
                                                        physician.id),
                                      ),
                                    )
                                    .toList(),
                              ),
                        const SizedBox(
                          height: 36,
                        ),
                        MaterialButton(
                          onPressed: isLoading || !isFormValid
                              ? () {}
                              : () {
                                  // if (practice != null) {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => AppointmentView(
                                  //         practice: practice!,
                                  //       ),
                                  //     ),
                                  //   );
                                  // } else {
                                  //   return;
                                  // }
                                },
                          color:
                              isFormValid ? TColor.primary : TColor.inactiveBtn,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minWidth: double.infinity,
                          height: 45.0,
                          child: isLoading
                              ? const SizedBox(
                                  width: 25.0,
                                  height: 25.0,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 4.0,
                                  ),
                                )
                              : Text(
                                  "Pay for appointment",
                                  style: TextStyle(
                                    color: isFormValid
                                        ? Colors.white
                                        : TColor.bottomBar,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
