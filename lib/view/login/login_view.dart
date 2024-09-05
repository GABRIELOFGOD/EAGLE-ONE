import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/view/login/components/login_form.dart';
import 'package:youdoc/view/register/register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    const textTitle = 'Sign into Youdoc';

    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: SafeArea(
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
                              "New user?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 10),
                            CustomAnchor(
                              text: "Register",
                              textColor: TColor.primary,
                              clicked: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterView(),
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
                    const LoginForm(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Need quick aid?",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        CustomAnchor(
                          text: "Ring an emergency hotline",
                          clicked: () {},
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
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
