import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/common/line_text_field.dart';
import 'package:youdoc/view/forgot_password/request_password.dart';
import 'package:youdoc/view/register/register_password_view.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordVisible = false;

  bool get isFormValid {
    return email.text.isNotEmpty && password.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          textController: email,
          placeholder: 'Enter email',
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 15),
        Container(
          height: 43.0,
          decoration: BoxDecoration(
            color: TColor.inputBg,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: TextField(
              controller: password,
              obscureText: !passwordVisible,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                hintText: 'Enter password',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: TColor.inputGray,
                  fontSize: 12,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white70,
                  ),
                  onPressed: () {
                    setState(() {
                      passwordVisible = !passwordVisible;
                    });
                  },
                ),
              ),
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 15,),
        Container(
          alignment: Alignment.centerLeft,
          child: CustomAnchor(text: "Forgot password?", clicked: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RequestForgetPasswordLink(),
              ),
            );
          }),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: CustomButton(
            title: "Login",
            onpress: isFormValid ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPasswordView(token: "token",),
                ),
              );
            } : null,
            enabled: isFormValid,
          ),
        ),
      ],
    );
  }
}
