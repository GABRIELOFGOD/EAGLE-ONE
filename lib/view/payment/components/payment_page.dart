import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/view/payment/components/payment_webview.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key, required this.backTo});

  final Widget backTo;

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _amountController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    _amountController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String? paymentCode;

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

  void _initializePayment(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response =
          await baseRequest.initDeposit(double.parse(_amountController.text));
      String message = response.message;
      String error = response.error;
      String link = response.link;
      String reference = response.reference;

      if (error == "") {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (ctx) => PaymentWebview(
              link: link,
              reference: reference,
              backTo: widget.backTo,
            ),
          ),
          (route) => false,
        );
      } else {
        _showMessageDialog(
          message,
          () {
            Navigator.of(context).pop();
          },
          "Error",
          "Something went wrong!",
          "Close",
          Colors.red,
        );
      }
    } catch (e) {
      print(e);
      _showMessageDialog(
        e.toString(),
        () {
          Navigator.of(context).pop();
        },
        "Error",
        "Something went wrong",
        "Close",
        Colors.red,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 50,
      ),
      child: Align(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    // padding: const EdgeInsets.symmetric(
                    //   vertical: 20,
                    //   horizontal: 20,
                    // ),
                    // color: TColor.primaryBg,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Top up wallet",
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
                                  "Enter amount to add to your wallet",
                                  style: TextStyle(
                                    color: TColor.inputGray,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
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
                        const SizedBox(height: 36),
                        Container(
                          height: 43.0,
                          decoration: BoxDecoration(
                            color: TColor.inputBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _amountController,
                            decoration: const InputDecoration(
                              prefixText: "₦ ",
                              hintText: "Enter amount",
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15.0),
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),
                        MaterialButton(
                          onPressed: _amountController.text.isEmpty || isLoading
                              ? () {}
                              : () {
                                  _initializePayment(context);
                                },
                          color: _amountController.text.isEmpty || isLoading
                              ? TColor.inactiveBtn
                              : TColor.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minWidth: double.infinity,
                          height: 45.0,
                          child: Center(
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 4,
                                  )
                                : Text(
                                    "Proceed to pay",
                                    style: TextStyle(
                                      color: _amountController.text.isEmpty
                                          ? TColor.bottomBar
                                          : Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  // return Container(
  //   padding: const EdgeInsets.symmetric(
  //     vertical: 20,
  //     horizontal: 20,
  //   ),
  //   color: TColor.primaryBg,
  //   child: Column(
  //     children: [
  //       Center(
  //         child: Text(
  //           "Deposit",
  //           style: TextStyle(
  //             color: TColor.inputGray,
  //             fontSize: 20,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 36),
  //       Container(
  //         height: 43.0,
  //         decoration: BoxDecoration(
  //           color: TColor.inputBg,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         child: TextField(
  //           keyboardType: TextInputType.number,
  //           controller: _amountController,
  //           decoration: const InputDecoration(
  //             prefixText: "₦ ",
  //             hintText: "Amount",
  //             contentPadding: EdgeInsets.symmetric(vertical: 15.0),
  //             border: InputBorder.none,
  //             hintStyle: TextStyle(
  //               color: Colors.white70,
  //               fontSize: 14,
  //             ),
  //           ),
  //           style: const TextStyle(
  //             color: Colors.white70,
  //             fontWeight: FontWeight.w500,
  //             fontSize: 14,
  //           ),
  //         ),
  //       ),
  //       const SizedBox(height: 36),
  //       MaterialButton(
  //         onPressed: _amountController.text.isEmpty
  //             ? () {}
  //             : () {
  //                 _initializePayment(context);
  //               },
  //         color: _amountController.text.isEmpty
  //             ? TColor.inactiveBtn
  //             : TColor.primary,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(5),
  //         ),
  //         minWidth: double.infinity,
  //         height: 45.0,
  //         child: Center(
  //           child: isLoading
  //               ? const CircularProgressIndicator(
  //                   color: Colors.white,
  //                   strokeWidth: 4,
  //                 )
  //               : Text(
  //                   "Proceed to pay",
  //                   style: TextStyle(
  //                     color: _amountController.text.isEmpty
  //                         ? TColor.bottomBar
  //                         : Colors.white,
  //                     fontSize: 20,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //         ),
  //       )
  //     ],
  //   ),
  // );
  // }
}
