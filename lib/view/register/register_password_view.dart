import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/common/loader_overlay.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/view/home/home_navigator.dart';
import 'package:youdoc/view/login/login_view.dart';
import 'package:youdoc/view/register/components/form_input_for_password.dart';

class RegisterPasswordView extends StatefulWidget {
  final String email;
  final String token;

  const RegisterPasswordView({
    super.key,
    required this.email,
    required this.token,
  });

  @override
  State<RegisterPasswordView> createState() => _RegisterPasswordViewState();
}

class _RegisterPasswordViewState extends State<RegisterPasswordView> {
  bool isLoading = false;
  String userEmail = "";

  Future<void> checkConfirm() async {
    if (widget.token != "confirm") {
      // TODO: confirm token function
      setState(() {
        isLoading = true;
      });
      try {
        BaseRequest baseRequest = BaseRequest();
        var response = await baseRequest.confirmToken(widget.token);
        String message = response.message;
        String error = response.error;
        String token = response.token;

        if (error == "") {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString("token", token);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeNavigator()),
            (route) => false,
          );
        } else {
          _showMessageDialog(
            message,
            () {
              setState(() {
                userEmail = error;
              });
              Navigator.of(context).pop();
              // message == "Sign-in links are only valid for 5 mins. After a link expires, you'll need to request a new one to be sent to your email." ? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegisterView()), (route) => false,) : Navigator,
            },
            message ==
                    "Sign-in links are only valid for 5 mins. After a link expires, you'll need to request a new one to be sent to your email."
                ? "Link Expired"
                : "Error",
            message ==
                    "Sign-in links are only valid for 5 mins. After a link expires, you'll need to request a new one to be sent to your email."
                ? "Use a unique link to gain access"
                : "Something went wrong",
            message ==
                    "Sign-in links are only valid for 5 mins. After a link expires, you'll need to request a new one to be sent to your email."
                ? "Resend"
                : "Close",
            TColor.primary,
          );
        }
      } catch (e) {
        _showMessageDialog(
          e.toString(),
          () {
            Navigator.of(context).pop();
          },
          "Error",
          "Something went wrong",
          "close",
          Colors.red,
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showMessageDialog(
    String message,
    VoidCallback closeFunction,
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
          onClose: closeFunction,
          title: title,
          sub: sub,
          closeText: closeText,
          btnColor: btnColor,
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      userEmail = widget.email;
    });
    checkConfirm();
  }

  @override
  Widget build(BuildContext context) {
    const textTitle = 'Create an account';

    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: isLoading
          ? LoadingOverlay(isLoading: isLoading)
          : SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: Text(
                                  textTitle,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Have an account?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      CustomAnchor(
                                        text: "Login",
                                        textColor: TColor.primary,
                                        clicked: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const LoginView(
                                                token: "confirm",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/images/pro_full.png'),
                                      const SizedBox(width: 10),
                                      const Text(
                                        "Progress",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              PasswordRegisterForm(email: userEmail),
                              Expanded(child: Container()),
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
                              // LoadingOverlay(isLoading: isLoading),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
