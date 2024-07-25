import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/common/line_text_field.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/components/user.dart';
import 'package:youdoc/view/forgot_password/request_password.dart';
import 'package:youdoc/view/home/home_navigator.dart';
import 'package:youdoc/view/login/login_view.dart';

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

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPreferences();
  }

  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool isLoading = false;

  // void isSuccessfullyLoggedIn(){

  // }

  UserLogin userLogin = UserLogin(
    email: "",
    password: "",
  );

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.login(userLogin);
      String message = response.message;
      String btn = response.error;
      String token = response.token;

      if (btn == "") {
        _showMessageDialog(
          message,
          () {
            Navigator.of(context).pop();
          },
          // () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => OnBoardingView())
          //   );
          // },
          "Link Sent",
          "Your Youdoc sign-in link has been sent ",
          "Got it!",
          TColor.primary,
        );
        email.text = "";
        password.text = "";
      } else {
        _showMessageDialog(
          message == "Invalid credentials"
              ? "Check your email and password as the information entered is not correct"
              : message,
          () => Navigator.of(context).pop(),
          "Error",
          message == "Invalid credentials"
              ? "Invalid credentials"
              : "Something went wrong",
          btn == "Conflict" ? "Login" : "Close",
          btn == "Conflict" ? TColor.warning : Colors.red,
        );
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
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              title: "Login",
              onpress: isFormValid ? _submitForm : null,
              enabled: isFormValid,
            ),
          ),
        ],
      ),
    );
  }
}
