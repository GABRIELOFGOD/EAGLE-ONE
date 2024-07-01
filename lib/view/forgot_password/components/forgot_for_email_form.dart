import 'package:flutter/material.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/common/line_text_field.dart';
import 'package:youdoc/view/forgot_password/reset_password.dart';

class ForgotFormForEmail extends StatefulWidget {
  const ForgotFormForEmail({super.key});

  @override
  State<ForgotFormForEmail> createState() => _ForgotFormForEmailState();
}

class _ForgotFormForEmailState extends State<ForgotFormForEmail> {
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomTextField(
              textController: email,
              placeholder: "Enter email address",
              onChanged: (value) {
                setState(() {});
              }),
          const SizedBox(
            height: 35,
          ),
          CustomButton(
            title: "Request link",
            enabled: true,
            onpress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPassword(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
