import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/view/login/login_view.dart';
import 'package:youdoc/view/register/components/form_input_for_password.dart';

class RegisterPasswordView extends StatefulWidget {
  final String email;
  final String token;

  const RegisterPasswordView({super.key, required this.email, required this.token,});

  @override
  State<RegisterPasswordView> createState() => _RegisterPasswordViewState();
}

class _RegisterPasswordViewState extends State<RegisterPasswordView> {
  void checkConfirm() {
    if (widget.email == "confirm") {
      // TODO: confirm token function
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConfirm();
  }

  @override
  Widget build(BuildContext context) {
    const textTitle = 'Create an account';

    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: SafeArea(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        builder: (context) => LoginView(
                                          token: "confirm",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                        PasswordRegisterForm(email: widget.email),
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
