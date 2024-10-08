import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/custom_dashboard_card.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/model/transaction.dart';
import 'package:youdoc/view/home/home_navigator.dart';
import 'package:youdoc/view/payment/components/payment_card.dart';
import 'package:youdoc/view/payment/components/payment_page.dart';
import 'package:intl/intl.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  double balance = 0;
  String email = "";

  bool isLoading = false;

  @override
  void initState() {
    _getUerProfile(context);
    super.initState();
  }

  // void _showMessageDialog(
  //   String message,
  //   VoidCallback closeFunction,
  //   String title,
  //   String sub,
  //   String closeText,
  //   Color btnColor,
  //   BuildContext context,
  // ) {
  //   showDialog(
  //     context: context,
  //     barrierColor: Colors.black.withOpacity(0.5),
  //     builder: (context) {
  //       return CustomDialog(
  //         message: message,
  //         onClose: closeFunction,
  //         title: title,
  //         sub: sub,
  //         closeText: closeText,
  //         btnColor: btnColor,
  //       );
  //     },
  //   );
  // }

  void _getUerProfile(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.profile();

      String message = response.message;
      String error = response.error;
      dynamic data = response.data;

      if (error.isEmpty) {
        setState(() {
          balance = double.parse(data['balance'].toString());
          email = data['email'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message,
            ),
          ),
        );
        // _showMessageDialog(
        //   message,
        //   () {
        //     Navigator.of(context).pop();
        //   },
        //   "Error",
        //   "Something went wrong",
        //   "close",
        //   Colors.red,
        //   context,
        // );
      }
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

  final List<Payment> payments = [
    // Chat(
    //   chatOn: true,
    //   messages: [
    //     Message(
    //       message: "Hello doctor",
    //       read: true,
    //       receiver: "Evergreen Hostital",
    //       sender: "Sam",
    //     ),
    //     Message(
    //       message: "Hi Mr. Sam, how is your health?",
    //       read: false,
    //       receiver: "Sam",
    //       sender: "Evergreen Hostital",
    //     ),
    //   ],
    //   patient: Patient(
    //       dob: "2024-01-02",
    //       email: "gabriel@google.com",
    //       firstName: "Gabriel",
    //       lastName: "Ayodele",
    //       sex: "male"),
    //   practiceName: "Evergreen Hostital",
    // ),
  ];

  List<String> possiblePaymentFilter = ["all", "pending", "paid"];

  String paymentFilter = 'all';
  void _openFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Container(
          color: TColor.primaryBg,
          width: double.infinity,
          child: Column(
            children: [
              for (var possible in possiblePaymentFilter)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      paymentFilter = possible;
                    });
                  },
                  child: Text(
                    possible,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        );
      },
    );
  }

  Widget _paymentStatusFormatter(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: status == 'pending'
            ? TColor.btnBg
            : status == 'paid'
                ? TColor.success
                : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: status == 'pending'
          ? Row(
              children: [
                Icon(
                  Icons.warning,
                  color: TColor.warning,
                  size: 12,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ],
            )
          : Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 10,
              ),
            ),
    );
  }

  void _openDepositBottomSheet() {
    showDialog(
      context: context,
      builder: (ctx) => const PaymentPage(
        backTo: HomeNavigator(
          displayScreen: 4,
        ),
      ),
    );
    // showModalBottomSheet(
    //   useSafeArea: true,
    //   context: context,
    //   builder: (ctx) => const PaymentPage(
    //     backTo: HomeNavigator(
    //       displayScreen: 4,
    //     ),
    //   ),
    // );
  }

  String formatToCurrency(double value) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Payments",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Review hisory",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: TColor.textGray,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: _openDepositBottomSheet,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/icons/money_icon.png",
                          width: 18,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Deposit",
                          style: TextStyle(
                            color: TColor.textGray,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              SizedBox(
                height: 115,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomCard(
                          carIcon: Image.asset(
                            "assets/icons/money_icon.png",
                            color: Colors.white,
                            width: 20,
                          ),
                          cardName: "Account balance",
                          value: "₦${formatToCurrency(balance)}",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomCard(
                          carIcon: Image.asset(
                            "assets/icons/card_minus.png",
                            color: Colors.white,
                            width: 20,
                          ),
                          cardName: "Outstanding payments",
                          value: "₦0",
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomCard(
                          carIcon: Image.asset(
                            "assets/icons/money_icon.png",
                            color: Colors.white,
                            width: 20,
                          ),
                          cardName: "Total payments",
                          value: "₦0",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    paymentFilter,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: _openFilterBottomSheet,
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_list,
                          size: 18,
                          color: TColor.textGray,
                        ),
                        const SizedBox(
                          width: 4.9,
                        ),
                        Text(
                          "Filter",
                          style: TextStyle(
                            color: TColor.textGray,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Expanded(
                child: Center(
                  child: payments.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/empty_payment.png"),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              "Payments are empty",
                              style: TextStyle(
                                color: TColor.btnText,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: payments
                              .map(
                                (Payment payment) => PaymentCard(
                                  mainLabel: payment.amount.toString(),
                                  rightLabel: payment.practiceName,
                                  subLabel: payment.service,
                                  status:
                                      _paymentStatusFormatter(payment.status),
                                ),
                              )
                              .toList(),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
