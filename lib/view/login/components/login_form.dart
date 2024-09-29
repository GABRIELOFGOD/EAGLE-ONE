import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/common/line_text_field.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/model/user.dart';
import 'package:youdoc/view/forgot_password/request_password.dart';
import 'package:youdoc/common_widget/otp/otp_dialog.dart';

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

  bool isLoading = false;

  UserLogin userLogin = UserLogin(
    email: "",
    password: "",
  );

  Future<void> _submitForm() async {
    // showDialog(
    //   context: context,
    //   builder: (ctx) => const OtpDialog(email: "email"),
    // );
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.login(userLogin);
      String message = response.message;
      String error = response.error;

      if (error.isEmpty) {
        showDialog(
          context: context,
          builder: (ctx) => OtpDialog(email: email.text),
        );
        // email.text = "";
        // password.text = "";
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
          ),
        );
        // _showMessageDialog(
        //   message == "Invalid credentials"
        //       ? "Check your email and password as the information entered is not correct"
        //       : message,
        //   () => Navigator.pop(context),
        //   "Error",
        //   message == "Invalid credentials"
        //       ? "Invalid credentials"
        //       : "Something went wrong",
        //   error == "Conflict" ? "Login" : "Close",
        //   error == "Conflict" ? TColor.warning : Colors.red,
        // );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
      // _showMessageDialog(
      //   e.toString(),
      //   () {
      //     _submitForm();
      //     // Navigator.of(context).pop();
      //   },
      //   "Error",
      //   "Something went wrong",
      //   "Retry",
      //   Colors.red,
      // );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTextField(
            textController: email,
            placeholder: 'Enter email',
            onChanged: (value) => setState(() {
              userLogin.email = value;
            }),
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
                onChanged: (value) => setState(() {
                  userLogin.password = value;
                }),
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
          const SizedBox(height: 15),
          Container(
            alignment: Alignment.centerLeft,
            child: CustomAnchor(
              text: "Forgot password?",
              clicked: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RequestForgetPasswordLink(),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: CustomButton(
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
                      "Login",
                      style: TextStyle(
                        color: isFormValid ? Colors.white : TColor.bottomBar,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              title: "Login",
              onpress: isFormValid ? _submitForm : null,
              enabled: isFormValid && !isLoading,
            ),
          ),
        ],
      ),
    );
  }
}
