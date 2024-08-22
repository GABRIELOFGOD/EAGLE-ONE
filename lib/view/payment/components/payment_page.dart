import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/view/payment/components/payment_webview.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

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

      if (error == "") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => PaymentWebview(link: link),
          ),
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
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      color: TColor.primaryBg,
      child: Column(
        children: [
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
                hintText: "Amount",
                contentPadding: EdgeInsets.symmetric(vertical: 15.0),
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
            onPressed: _amountController.text.isEmpty
                ? () {}
                : () {
                    _initializePayment(context);
                  },
            color: _amountController.text.isEmpty
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
                      )),
          )
        ],
      ),
    );
  }
}
