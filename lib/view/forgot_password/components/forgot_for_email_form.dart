import 'package:flutter/material.dart';
import 'package:youdoc/common/customButton.dart';
import 'package:youdoc/common/lineTextField.dart';
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
          SizedBox(
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
