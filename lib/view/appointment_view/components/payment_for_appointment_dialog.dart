import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/common_widget/messages/pop_up.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/model/practices.dart';
import 'package:youdoc/model/transaction.dart';
import 'package:youdoc/view/home/home_navigator.dart';

class PaymentForAppointmentDialog extends StatefulWidget {
  PaymentForAppointmentDialog(
      {super.key, required this.service, required this.appointment});

  Service service;
  CreateAppointmentDto appointment;

  @override
  State<PaymentForAppointmentDialog> createState() =>
      _PaymentForAppointmentDialogState();
}

class _PaymentForAppointmentDialogState
    extends State<PaymentForAppointmentDialog> {
  AppointmentPay? _selectedPay;
  double? amountToPay;

  final List<AppointmentPay> _payments = const [
    AppointmentPay(abbr: "part", label: "Part appointment fee"),
    AppointmentPay(abbr: "full", label: "Full appointment fee"),
  ];

  bool _isLoading = false;
  double? balance;

  bool _bookLoading = false;

  @override
  void initState() {
    _getUserDetails();
    super.initState();
  }

  void _getUserDetails() async {
    setState(() {
      _isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.profile();

      String message = response.message;
      String error = response.error;
      dynamic data = response.data;

      if (error == '') {
        setState(() {
          balance = double.parse(data['balance'].toString());
        });
      } else {
        _showMessageDialog(
          message,
          () {
            Navigator.of(context).pop();
          },
          "Error",
          "Something went wrong",
          "close",
          Colors.red,
        );
      }
    } catch (e) {
      _showMessageDialog(
        e.toString(),
        () {
          Navigator.of(context).pop();
        },
        "Error",
        "Something went wrong",
        "Retry",
        Colors.red,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMessageDialog(
    String message,
    VoidCallback closeFunction,
    String title,
    String sub,
    String closeText,
    Color btnColor,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return CustomDialog(
          message: message,
          onClose: closeFunction,
          title: title,
          sub: sub,
          closeText: closeText,
          btnColor: btnColor,
        );
      },
    );
  }

  String formatToCurrency(double value) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(value);
  }

  bool get isBookValid {
    bool isValid = false;
    if (amountToPay != null &&
        _selectedPay != null &&
        balance! > amountToPay!) {
      isValid = true;
    }
    return isValid;
  }

  void _bookAnAppointment() async {
    setState(() {
      _bookLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.bookAppointment(widget.appointment);

      String message = response.message;
      String error = response.error;
      dynamic data = response.data;

      if (error == "") {
        showDialog(
          context: context,
          builder: (ctx) => PopUp(
            message: message,
            primaryButtonText: "Complete",
            onPrimaryButtonPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (ctx) => const HomeNavigator()),
              (route) => false,
            ),
            secondaryButtonText: "View appointment",
            onSecondaryButtonPressed: () {},
          ),
        );
      } else {
        _showMessageDialog(
          message,
          () {
            Navigator.of(context).pop();
          },
          "Error",
          "Something went wrong",
          "close",
          Colors.red,
        );
      }
    } catch (e) {
      _showMessageDialog(
        e.toString(),
        () {
          Navigator.of(context).pop();
        },
        "Error",
        "Something went wrong",
        "Retry",
        Colors.red,
      );
    } finally {
      setState(() {
        _bookLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            child: _isLoading
                ? SizedBox(
                    height: 200,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: TColor.primary,
                        strokeWidth: 6,
                      ),
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pay",
                                style: TextStyle(
                                  color: TColor.btnText,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Pay for appointment",
                                style: TextStyle(
                                  color: TColor.textGray,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: TColor.inputBg,
                              ),
                              padding: const EdgeInsets.all(6),
                              child: Icon(
                                Icons.close,
                                size: 12,
                                color: TColor.btnText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        width: double.infinity,
                        height: 43,
                        decoration: BoxDecoration(
                          color: TColor.btnBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.centerRight,
                        child: DropdownButton(
                          dropdownColor: Colors.black,
                          hint: Text(
                            "Select payment",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: TColor.textGray,
                            ),
                          ),
                          isExpanded: true,
                          underline: Container(),
                          icon: const Icon(Icons.keyboard_arrow_down_sharp),
                          iconEnabledColor: TColor.inputGray,
                          iconDisabledColor: TColor.inputGray,
                          // iconEnabledColor: TColor.btnBg,
                          // iconDisabledColor: TColor.btnBg,
                          value: _selectedPay,
                          items: _payments
                              .map((service) => DropdownMenuItem(
                                    // alignment: AlignmentDirectional(10, 10/),
                                    value: service,
                                    child: Text(
                                      service.label,
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
                            setState(
                              () {
                                _selectedPay = value;
                                value.abbr == "part"
                                    ? amountToPay = double.parse(widget
                                        .service.requiredDownPayment
                                        .toString())
                                    : value.abbr == "full"
                                        ? amountToPay = double.parse(widget
                                            .service.bookingFee
                                            .toString())
                                        : amountToPay = null;
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Appointment fee",
                            style: TextStyle(
                              fontSize: 14,
                              color: TColor.textGray,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          _selectedPay == null || amountToPay == null
                              ? Text(
                                  "Select payment",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: TColor.btnText,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              : Text(
                                  "₦${formatToCurrency(amountToPay!)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: TColor.btnText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Available balance",
                            style: TextStyle(
                              fontSize: 14,
                              color: TColor.textGray,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "₦${formatToCurrency(balance!)}",
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  amountToPay != null && balance! < amountToPay!
                                      ? Colors.red
                                      : TColor.btnText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      MaterialButton(
                        onPressed: _bookLoading || !isBookValid
                            ? () {}
                            : _bookAnAppointment,
                        color:
                            isBookValid ? TColor.primary : TColor.inactiveBtn,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        minWidth: double.infinity,
                        height: 45.0,
                        child: _bookLoading
                            ? const SizedBox(
                                width: 25.0,
                                height: 25.0,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 4.0,
                                ),
                              )
                            : Text(
                                "Book an appointment",
                                style: TextStyle(
                                  color: isBookValid
                                      ? Colors.white
                                      : TColor.bottomBar,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
