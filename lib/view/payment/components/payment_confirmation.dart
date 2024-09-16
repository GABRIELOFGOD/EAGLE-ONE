import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/components/api_request.dart';

class PaymentConfirmation extends StatefulWidget {
  const PaymentConfirmation({super.key, required this.reference, required this.backTo});

  final String reference;
  final Widget backTo;

  @override
  State<PaymentConfirmation> createState() => _PaymentConfirmationState();
}

class _PaymentConfirmationState extends State<PaymentConfirmation> {
  bool isLoading = false;
  String displayMessage = 'Please wait while we verify your deposit';
  num confirmationCode = 0;

  @override
  void initState() {
    _confirmDepositStatus();
    super.initState();
  }

  void _confirmDepositStatus() async {
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.confirmDeposit(widget.reference);
      String message = response.message;
      String error = response.error;
      bool status = response.status;
      num confirmationId = response.confirmationId;

      if (error.isEmpty && status == true) {
        setState(() {
          confirmationCode = 0;
          displayMessage = message;
        });
      } else {
        setState(() {
          displayMessage = message;
          confirmationCode = 9;
        });
      }
    } catch (e) {
      displayMessage = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isLoading
                  ? CircularProgressIndicator(
                      color: TColor.primary,
                      strokeWidth: 4,
                    )
                  : confirmationCode != 0
                      ? const Icon(
                          Icons.close,
                          size: 80,
                          color: Colors.red,
                        )
                      : Icon(
                          Icons.check_circle,
                          color: TColor.success,
                          size: 80,
                        ),
              const SizedBox(
                height: 20,
              ),
              Text(
                displayMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              isLoading
                  ? Container()
                  : MaterialButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => widget.backTo,
                          ),
                          (route) => false,
                        );
                      },
                      color: TColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      minWidth: double.infinity,
                      height: 45.0,
                      child: const Center(
                          child: Text(
                        "Go back",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
