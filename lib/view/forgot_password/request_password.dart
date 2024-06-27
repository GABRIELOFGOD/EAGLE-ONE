import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/view/forgot_password/components/forgot_for_email_form.dart';

class RequestForgetPasswordLink extends StatefulWidget {
  const RequestForgetPasswordLink({super.key});

  @override
  State<RequestForgetPasswordLink> createState() => _RequestForgetPasswordLinkState();
}

class _RequestForgetPasswordLinkState extends State<RequestForgetPasswordLink> {
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
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textTitle,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Provide the email address used during sign up",
                      style: TextStyle(
                        color: TColor.inputGray,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ),
              const SizedBox(height: 30),
              ForgotFormForEmail(),
              Expanded(child: Container()), // This expands to fill the available space
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
            ],
          ),
        ),
      ),
    );
  }
}