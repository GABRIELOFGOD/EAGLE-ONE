import 'package:flutter/material.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/common/color_extention.dart';
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

  // Future<void> _submitForm() async {
  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     BaseRequest baseRequest = BaseRequest();
  //     var response = await baseRequest.findUserEmail(email.text);
  //     String message = response.message;
  //     String btn = response.error;
  //     bool existed = response.existed;

  //     if (btn == "") {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) =>
  //               ResetPassword(email: email.text, token: "confirm"),
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(message),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //       // _showMessageDialog(
  //       //   message,
  //       //   Navigator.of(context).pop(),
  //       //   // () {
  //       //   //   Navigator.of(context).push(
  //       //   //     MaterialPageRoute(builder: (context) => OnBoardingView())
  //       //   //   );
  //       //   // },
  //       //   "Error",
  //       //   "Something went wrong! ",
  //       //   "Back",
  //       //   Colors.red,
  //       // );
  //       // setState(() {
  //       //   isError = true;
  //       //   errorMessage = message;
  //       // });
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           e.toString(),
  //         ),
  //       ),
  //     );
  //     // _showMessageDialog(
  //     //   e.toString(),
  //     //   () {
  //     //     _submitForm();
  //     //     Navigator.of(context).pop();
  //     //   },
  //     //   "Error",
  //     //   "Something went wrong",
  //     //   "Retry",
  //     //   Colors.red,
  //     // );
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  // void _showMessageDialog(
  //   String message,
  //   void closeFunction,
  //   String title,
  //   String sub,
  //   String closeText,
  //   Color btnColor,
  // ) {
  //   showDialog(
  //     context: context,
  //     barrierColor: Colors.black.withOpacity(0.5),
  //     builder: (context) {
  //       return CustomDialog(
  //           message: message,
  //           onClose: () => closeFunction,
  //           title: title,
  //           sub: sub,
  //           closeText: closeText,
  //           btnColor: btnColor);
  //     },
  //   );
  // }

  bool _emailExists = false;

  Future<void> _checkMailExists(String email) async {
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.findUserEmail(email);
      if (response.error.isEmpty) {
        setState(() {
          _emailExists = false;
        });
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       response.message,
        //     ),
        //   ),
        // );
      } else {
        setState(() {
          _emailExists = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 43.0,
            decoration: BoxDecoration(
                color: TColor.inputBg,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _emailExists ? TColor.error : TColor.inputBg,
                  width: 2.0,
                )),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: email,
              onChanged: (value) => setState(() {
                _checkMailExists(value);
                email.text = value;
              }),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                hintText: 'Enter email address',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: TColor.inputGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                suffixIcon: Icon(
                  Icons.warning_amber_outlined,
                  color: _emailExists ? Colors.red : TColor.inputBg,
                ),
              ),
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 11),
          _emailExists
              ? Text(
                  "This email doesn’t exist on Youdoc",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: TColor.error,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                )
              : Container(),
          // style: const TextStyle(
          //   color: Colors.white70,
          //   fontWeight: FontWeight.w500,
          //   fontSize: 12,
          // ),
          const SizedBox(
            height: 48,
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
                      color: isFormValid && !isLoading && !_emailExists
                          ? Colors.white
                          : TColor.bottomBar,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            title: "Continue",
            onpress: isFormValid
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResetPassword(email: email.text, token: "confirm"),
                      ),
                    );
                  }
                : null,
            enabled: isFormValid && !isLoading && !_emailExists,
          ),
        ],
      ),
    );
  }
}
