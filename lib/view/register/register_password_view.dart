import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/view/login/login_view.dart';
import 'package:youdoc/view/register/components/form_input_for_password.dart';

class RegisterPasswordView extends StatefulWidget {
  final String token; // Token parameter

  const RegisterPasswordView({super.key, required this.token});

  @override
  State<RegisterPasswordView> createState() => _RegisterPasswordViewState();
}

class _RegisterPasswordViewState extends State<RegisterPasswordView> {
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
                                        builder: (context) => const LoginView(),
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
                        PasswordRegisterForm(token: widget.token),
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


// import 'package:flutter/material.dart';
// import 'package:youdoc/common/Color_extention.dart';
// import 'package:youdoc/common/anchor_click.dart';
// import 'package:youdoc/view/login/login_view.dart';
// import 'package:youdoc/view/register/components/form_input_for_password.dart';

// class RegisterPasswordView extends StatefulWidget {
//   final String token; // Add token parameter

//   const RegisterPasswordView({super.key, required this.token});

//   @override
//   State<RegisterPasswordView> createState() => _RegisterPasswordViewState();
// }

// class _RegisterPasswordViewState extends State<RegisterPasswordView> {
//   @override
//   Widget build(BuildContext context) {
//     const textTitle = 'Create an account';

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
//                         "Have an account?",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       CustomAnchor(
//                         text: "Login",
//                         textColor: TColor.primary,
//                         clicked: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const LoginView(),
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
//               const PasswordRegisterForm(),
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
//               Expanded(child: Container()), // This expands to fill the available space
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
//               // Text(
//               //   'Received token: ${widget.token}', // Display the token
//               //   style: const TextStyle(color: Colors.white),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

