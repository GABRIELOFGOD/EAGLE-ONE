// import 'package:flutter/material.dart';
// import 'package:youdoc/common/Color_extention.dart';
// import 'package:youdoc/common/anchor_click.dart';
// import 'package:youdoc/view/login/components/login_form.dart';
// import 'package:youdoc/view/register/register_view.dart';

// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const textTitle = 'Sign into Youdoc';

//     return Scaffold(
//       backgroundColor: TColor.primaryBg,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.symmetric(vertical: 10.0),
//                 child: Text(
//                   textTitle,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "New user?",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       CustomAnchor(
//                         text: "Register",
//                         textColor: TColor.primary,
//                         clicked: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const RegisterView(),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Image.asset('assets/images/pro_full.png'),
//                       const SizedBox(width: 10),
//                       const Text(
//                         "Progress",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               const LoginForm(),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Need quick aid?",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 14,
//                     ),
//                   ),
//                   CustomAnchor(
//                     text: "Ring an emergency hotline",
//                     clicked: () {},
//                   )
//                 ],
//               ),
//               Expanded(
//                   child:
//                       Container()),
//               Container(
//                 alignment: Alignment.center,
//                 child: Wrap(
//                   alignment: WrapAlignment.center,
//                   children: [
//                     const Text(
//                       "By signing up you agree to our ",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     CustomAnchor(
//                       text: "Terms of use ",
//                       clicked: () {},
//                       textColor: TColor.primary,
//                       myFontSize: 14,
//                     ),
//                     const Text(
//                       "and our ",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                     CustomAnchor(
//                       text: "Privacy Policy",
//                       clicked: () {},
//                       textColor: TColor.primary,
//                       myFontSize: 14,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/common/loader_overlay.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/view/home/home_navigator.dart';
import 'package:youdoc/view/login/components/login_form.dart';
import 'package:youdoc/view/register/register_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key, required this.token});

  final String token;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;

  Future<void> checkConfirm() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // var localToken = sharedPreferences.getString("token");
    // if (localToken != null) {
    //   print("localToken, $localToken");
    //   Navigator.pushAndRemoveUntil(
    //       context,
    //       MaterialPageRoute(builder: (context) => const HomeNavigator()),
    //       (route) => false);
    // }
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
          sharedPreferences.setString("token", token);
          // print("token, $token");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeNavigator()),
            (route) => false,
          );
        } else {
          _showMessageDialog(
            message,
            () {
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
    checkConfirm();
  }

  @override
  Widget build(BuildContext context) {
    const textTitle = 'Sign into Youdoc';

    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: isLoading
          ? LoadingOverlay(isLoading: isLoading)
          : SafeArea(
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
