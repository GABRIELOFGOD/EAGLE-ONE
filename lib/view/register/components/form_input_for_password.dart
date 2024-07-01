import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/components/user.dart';

class PasswordRegisterForm extends StatefulWidget {
  final String token;

  const PasswordRegisterForm({super.key, required this.token});

  @override
  State<PasswordRegisterForm> createState() => _PasswordRegisterFormState();
}

class _PasswordRegisterFormState extends State<PasswordRegisterForm> {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;

  bool get isFormValid {
    return password.text.isNotEmpty &&
        confirmPassword.text.isNotEmpty &&
        password.text == confirmPassword.text &&
        _isPasswordValid();
  }

  bool isLoading = false;

  UserRegistrationComplete userRegistrationComplete =
      UserRegistrationComplete(password: "", confirmPassword: "", token: '');

  bool _isPasswordValid() {
    String p = password.text;
    bool hasUppercase = p.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = p.contains(RegExp(r'[a-z]'));
    bool hasDigits = p.contains(RegExp(r'\d'));
    bool hasSpecialCharacters = p.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = p.length >= 8 && p.length <= 24;
    return hasUppercase && hasLowercase && hasDigits && hasSpecialCharacters && hasMinLength;
  }

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      userRegistrationComplete.password = password.text;
      userRegistrationComplete.confirmPassword = confirmPassword.text;
      userRegistrationComplete.token = widget.token;

      var response = await baseRequest.complete(userRegistrationComplete);
      String message = response.message;
      String btn = response.error;
      print(response);
      showDialog(
        context: context,
        barrierColor:
            Colors.black.withOpacity(0.5), // Dark overlay with 50% opacity
        builder: (context) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 50), // Adjust the padding as needed
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: TColor.primaryBg.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        btn == "" ? "SUCCESS" : "ERROR",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                TColor.primary),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                const TextStyle(fontSize: 14)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                          child: Text(
                            btn != "" ? "Close" : "Open mail box",
                            style: const TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      // Handle error...
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              backgroundColor: TColor.primaryBg.withOpacity(0.9),
              content: Text(
                '$e',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
              actions: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(TColor.primary),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          const TextStyle(fontSize: 14)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Close",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildPasswordField(TextEditingController controller,
      String placeholder, bool isVisible, void Function() toggleVisibility) {
    return Container(
      height: 43.0,
      decoration: BoxDecoration(
        color: TColor.inputBg,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: !isVisible,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            hintText: placeholder,
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: TColor.inputGray,
              fontSize: 12,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: TColor.inputGray, // Match the text color
              ),
              onPressed: toggleVisibility,
            ),
          ),
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          onChanged: (value) => setState(() {}),
        ),
      ),
    );
  }

  Widget buildPasswordValidationCheck(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          Icons.check,
          color: isValid ? Colors.greenAccent : Colors.grey,
          size: 14,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            color: TColor.inputGray,
            fontSize: 14,
            fontWeight: FontWeight.w400
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String p = password.text;
    bool hasUppercase = p.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = p.contains(RegExp(r'[a-z]'));
    bool hasDigits = p.contains(RegExp(r'\d'));
    bool hasSpecialCharacters = p.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = p.length >= 8 && p.length <= 24;

    return Column(
      children: [
        buildPasswordField(password, 'Enter password', passwordVisible, () {
          setState(() {
            passwordVisible = !passwordVisible;
          });
        }),
        const SizedBox(height: 15),
        buildPasswordField(
            confirmPassword, 'Confirm password', confirmPasswordVisible, () {
          setState(() {
            confirmPasswordVisible = !confirmPasswordVisible;
          });
        }),
        const SizedBox(height: 15),
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
                : const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            title: "Continue",
            onpress: isFormValid ? _submitForm : null,
            enabled: isFormValid,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
          "Password must have",
            style: TextStyle(
              color: TColor.inputGray,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        const SizedBox(height: 15),
        buildPasswordValidationCheck("At least one uppercase letter", hasUppercase),
        const SizedBox(height: 10),
        buildPasswordValidationCheck("At least one lowercase letter", hasLowercase),
        const SizedBox(height: 10),
        buildPasswordValidationCheck("At least one digit (0-9)", hasDigits),
        const SizedBox(height: 10),
        buildPasswordValidationCheck("At least one special character (*&%#)", hasSpecialCharacters),
        const SizedBox(height: 10),
        buildPasswordValidationCheck("8-24 characters in total", hasMinLength),
      ],
    );
  }
}


// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:youdoc/common/Color_extention.dart';
// import 'package:youdoc/common/customButton.dart';
// import 'package:youdoc/components/api_request.dart';
// import 'package:youdoc/components/user.dart';

// class PasswordRegisterForm extends StatefulWidget {
//   final String token;

//   const PasswordRegisterForm({super.key, required this.token});

//   @override
//   State<PasswordRegisterForm> createState() => _PasswordRegisterFormState();
// }

// class _PasswordRegisterFormState extends State<PasswordRegisterForm> {
//   TextEditingController password = TextEditingController();
//   TextEditingController confirmPassword = TextEditingController();
//   bool passwordVisible = false;
//   bool confirmPasswordVisible = false;

//   bool get isFormValid {
//     return password.text.isNotEmpty &&
//         confirmPassword.text.isNotEmpty &&
//         password.text == confirmPassword.text;
//   }

//   bool isLoading = false;

//   UserRegistrationComplete userRegistrationComplete =
//       UserRegistrationComplete(password: "", confirmPassword: "", token: '');

//   Future<void> _submitForm() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       BaseRequest baseRequest = BaseRequest();
//       userRegistrationComplete.password = password.text;
//       userRegistrationComplete.confirmPassword = confirmPassword.text;
//       userRegistrationComplete.token = widget.token;

//       var response = await baseRequest.complete(userRegistrationComplete);
//       String message = response.message;
//       String btn = response.error;
//       print(response);
//       showDialog(
//         context: context,
//         barrierColor:
//             Colors.black.withOpacity(0.5), // Dark overlay with 50% opacity
//         builder: (context) {
//           return Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(
//                   bottom: 50), // Adjust the padding as needed
//               child: Material(
//                 color: Colors.transparent,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: TColor.primaryBg.withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.all(20),
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         btn == "" ? "SUCCESS" : "ERROR",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         message,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: double.infinity,
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 TColor.primary),
//                             foregroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white),
//                             textStyle: MaterialStateProperty.all<TextStyle>(
//                                 const TextStyle(fontSize: 14)),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                           ),
//                           child: Text(
//                             btn != "" ? "Close" : "Open mail box",
//                             style: TextStyle(color: Colors.white, fontSize: 14),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//     } catch (e) {
//       // Handle error...
//       showDialog(
//         context: context,
//         barrierColor: Colors.transparent,
//         builder: (context) {
//           return BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//             child: AlertDialog(
//               backgroundColor: TColor.primaryBg.withOpacity(0.9),
//               content: Text(
//                 '$e',
//                 style: const TextStyle(color: Colors.white, fontSize: 14),
//               ),
//               actions: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(TColor.primary),
//                       foregroundColor:
//                           MaterialStateProperty.all<Color>(Colors.white),
//                       textStyle: MaterialStateProperty.all<TextStyle>(
//                           const TextStyle(fontSize: 14)),
//                       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//                     ),
//                     child: const Text(
//                       "Close",
//                       style: TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Widget buildPasswordField(TextEditingController controller,
//       String placeholder, bool isVisible, void Function() toggleVisibility) {
//     return Container(
//       height: 43.0,
//       decoration: BoxDecoration(
//         color: TColor.inputBg,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Center(
//         child: TextField(
//           controller: controller,
//           obscureText: !isVisible,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 10.0),
//             hintText: placeholder,
//             border: InputBorder.none,
//             hintStyle: TextStyle(
//               color: TColor.inputGray,
//               fontSize: 12,
//             ),
//             suffixIcon: IconButton(
//               icon: Icon(
//                 isVisible ? Icons.visibility : Icons.visibility_off,
//                 color: Colors.white70, // Match the text color
//               ),
//               onPressed: toggleVisibility,
//             ),
//           ),
//           style: const TextStyle(
//             color: Colors.white70,
//             fontWeight: FontWeight.w500,
//             fontSize: 12,
//           ),
//           onChanged: (value) => setState(() {}),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         buildPasswordField(password, 'Enter password', passwordVisible, () {
//           setState(() {
//             passwordVisible = !passwordVisible;
//           });
//         }),
//         SizedBox(height: 15),
//         buildPasswordField(
//             confirmPassword, 'Confirm password', confirmPasswordVisible, () {
//           setState(() {
//             confirmPasswordVisible = !confirmPasswordVisible;
//           });
//         }),
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 25.0),
//           child: CustomButton(
//             loader: isLoading
//                 ? CircularProgressIndicator(
//                     color: Colors.white,
//                   )
//                 : Text(
//                     "Continue",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//             title: "Continue",
//             onpress: isFormValid ? _submitForm : null,
//             enabled: isFormValid,
//           ),
//         ),
//       ],
//     );
//   }
// }
