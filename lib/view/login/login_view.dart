import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/common_widget/auth/auth_dialogue.dart';
import 'package:youdoc/common_widget/pops/otp_exceeds.dart';
import 'package:youdoc/common_widget/pops/ring_emergency.dart';
import 'package:youdoc/components/reusable_functions.dart';
import 'package:youdoc/view/home/home_navigator.dart';
import 'package:youdoc/view/login/components/login_form.dart';
import 'package:youdoc/view/register/register_view.dart';
import 'package:local_auth/local_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LocalAuthentication _auth = LocalAuthentication();
  SharedPreferences? _prefs;

  bool _isAuthenticated = false;

  void _authenticator() async {
    var userSettings = await getUserSettings();
    if (userSettings == null) {
      showDialog(
        context: context,
        builder: (ctx) => const AuthDialogue(),
      );
    } else {
      if (userSettings.authMethod == AuthMethod.auth) {
        if (_isAuthenticated) {
          _redirectUser();
        } else {
          try {
            final bool didAuthenticate = await _auth.authenticate(
              localizedReason: "Please authenticate to login",
              options: const AuthenticationOptions(
                biometricOnly: false,
              ),
            );

            setState(() {
              _isAuthenticated = didAuthenticate;
            });

            if (didAuthenticate) {
              _redirectUser();
            } else {
              print('Authentication failed');
            }
          } catch (e) {
            print(e);
          }
        }
      } else {
        if (userSettings.authMethod == AuthMethod.email) {
          return;
        } else {
          _prefs!.remove("token");
        }
        // setState(() {
        //   _initialPage = const LoginView();
        // });
      }
    }
    // if (_isAuthenticated) {
    //   _redirectUser();
    // } else {
    //   try {
    //     final bool didAuthenticate = await _auth.authenticate(
    //       localizedReason: "Please authenticate to login",
    //       options: const AuthenticationOptions(
    //         biometricOnly: false,
    //       ),
    //     );

    //     setState(() {
    //       _isAuthenticated = didAuthenticate;
    //     });

    //     if (didAuthenticate) {
    //       _redirectUser();
    //     } else {
    //       print('Authentication failed');
    //     }
    //   } catch (e) {
    //     print(e);
    //   }
    // }
  }

  void _redirectUser() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (ctx) => const HomeNavigator(),
      ),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _prefs = prefs;
    });
    var countDown = prefs.getInt("otp_exceeds_time");
    if (countDown != null) {
      if (countDown > 0) {
        showDialog(context: context, builder: (ctx) => const OtpExceeds());
      }
    }
    String? token = prefs.getString('token');
    if (token != null) {
      _authenticator();
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    const textTitle = 'Sign into Youdoc';

    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
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
                    clicked: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => const RingEmergency(),
                      );
                    },
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
