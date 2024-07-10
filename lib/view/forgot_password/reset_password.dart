import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/view/forgot_password/components/new_password_form.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.token});

  final String token;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    const textTitle = 'Reset password';

    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        textTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Enter your new password",
                        style: TextStyle(
                          color: TColor.inputGray,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 30),
              const NewPasswordForm(),
              Expanded(
                  child:
                      Container()), // This expands to fill the available space
              Container(
                alignment: Alignment.center,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Text(
                      "By signing up you agree to our ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    CustomAnchor(
                      text: "Terms of use ",
                      clicked: () {},
                      textColor: TColor.primary,
                      myFontSize: 14,
                    ),
                    const Text(
                      "and our ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    CustomAnchor(
                      text: "Privacy Policy",
                      clicked: () {},
                      textColor: TColor.primary,
                      myFontSize: 14,
                    ),
                  ],
                ),
              ),
              // Text(
              //   'Received token: ${widget.token}', // Display the token
              //   style: const TextStyle(color: Colors.white),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
