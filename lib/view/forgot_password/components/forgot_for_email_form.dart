import 'package:flutter/material.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/line_text_field.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/view/forgot_password/reset_password.dart';

class ForgotFormForEmail extends StatefulWidget {
  const ForgotFormForEmail({super.key});

  @override
  State<ForgotFormForEmail> createState() => _ForgotFormForEmailState();
}

class _ForgotFormForEmailState extends State<ForgotFormForEmail> {
  TextEditingController email = TextEditingController();

  bool isLoading = false;
  bool isError = false;
  String errorMessage = '';

  bool get isFormValid {
    return email.text.isNotEmpty;
  }

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });

    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.findUserEmail(email.text);
      String message = response.message;
      String btn = response.error;
      bool existed = response.existed;

      if (btn == "") {
      } else {
        setState(() {
          isError = true;
          errorMessage = message;
        });
      }
    } catch (e) {
      _showMessageDialog(
        e.toString(),
        () {
          _submitForm();
          Navigator.of(context).pop();
        },
        "Error",
        "Something went wrong",
        "Retry",
        Colors.red,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showMessageDialog(
    String message,
    void closeFunction,
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
            onClose: () => closeFunction,
            title: title,
            sub: sub,
            closeText: closeText,
            btnColor: btnColor);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
              controller: email,
              onChanged: (value) => setState(() {
                email.text = value;
              }),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                hintText: 'Enter email address',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: TColor.inputGray,
                  fontSize: 12,
                ),
                suffixIcon: Icon(
                  Icons.warning_amber_outlined,
                  color: isError ? Colors.red : TColor.inputBg,
                ),
              ),
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          // style: const TextStyle(
          //   color: Colors.white70,
          //   fontWeight: FontWeight.w500,
          //   fontSize: 12,
          // ),
          const SizedBox(
            height: 35,
          ),
          CustomButton(
            loader: isLoading
                ? const SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4.0,
                    ),
                  )
                : Text(
                    "Continue",
                    style: TextStyle(
                      color: isFormValid ? Colors.white : TColor.bottomBar,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            title: "Continue",
            onpress: isFormValid ? _submitForm : null,
            enabled: isFormValid,
          ),
        ],
      ),
    );
  }
}
