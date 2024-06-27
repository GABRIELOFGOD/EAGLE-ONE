// // import 'package:flutter/material.dart';
// // import 'package:youdoc/common/customButton.dart';
// // import 'package:youdoc/common/custom_dropdown.dart';
// // import 'package:youdoc/common/date_input.dart';
// // import 'package:youdoc/common/lineTextField.dart';
// // import 'package:youdoc/components/api_request.dart';
// // import 'package:youdoc/components/user.dart';
// // import 'dart:convert';

// // class RegisterFormInputs extends StatefulWidget {
// //   const RegisterFormInputs({super.key});

// //   @override
// //   State<RegisterFormInputs> createState() => _RegistenputsState();
// // }

// // class _RegistenputsState extends State<RegisterFormInputs> {
// //   TextEditingController firstNameText = TextEditingController();
// //   TextEditingController lastName = TextEditingController();
// //   TextEditingController email = TextEditingController();

// //   String? selectedSex;
// //   final List<String> sexOptions = ['MALE', 'FEMALE'];

// //   TextEditingController dateController = TextEditingController();

// //   bool get isFormValid {
// //     return firstNameText.text.isNotEmpty &&
// //         lastName.text.isNotEmpty &&
// //         email.text.isNotEmpty &&
// //         selectedSex != null &&
// //         dateController.text.isNotEmpty;
// //   }

// //   Future<void> _selectDate(BuildContext context) async {
// //     final DateTime? pickedDate = await showDatePicker(
// //       context: context,
// //       initialDate: DateTime.now(),
// //       firstDate: DateTime(1900),
// //       lastDate: DateTime.now(),
// //       helpText: 'Select Date of Birth',
// //       cancelText: 'Cancel',
// //       confirmText: 'Select',
// //     );
// //     // userRegister!.dob = pickedDate;
// //     if (pickedDate != null) {
// //       setState(() {
// //         dateController.text = "${pickedDate.toLocal()}"
// //             .split(' ')[0]; // Formats the date to YYYY-MM-DD
// //       });
// //     }
// //   }

// //   UserRegister userRegister =
// //       UserRegister(firstName: "", lastName: "", email: "", sex: "", dob: "");

// //   @override
// //   void initState() {
// //     super.initState();
// //   }

// //   bool isLoading = false;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         CustomTextField(
// //           textController: firstNameText,
// //           placeholder: 'Enter first name',
// //           onChanged: (value) => setState(() {
// //             userRegister!.firstName = value;
// //           }),
// //         ),
// //         SizedBox(height: 15),
// //         CustomTextField(
// //           textController: lastName,
// //           placeholder: 'Enter last name',
// //           onChanged: (value) => setState(() {
// //             userRegister!.lastName = value;
// //           }),
// //         ),
// //         SizedBox(height: 15),
// //         CustomTextField(
// //           textController: email,
// //           placeholder: 'Enter email',
// //           onChanged: (value) => setState(() {
// //             userRegister!.email = value;
// //           }),
// //         ),
// //         SizedBox(height: 15),
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             Expanded(
// //               child: DropDownInput(
// //                 options: sexOptions,
// //                 selectedOption: selectedSex,
// //                 onChanged: (String? newValue) {
// //                   setState(() {
// //                     selectedSex = newValue;
// //                   });
// //                   userRegister!.sex = selectedSex;
// //                 },
// //               ),
// //             ),
// //             const SizedBox(width: 10),
// //             Expanded(
// //               child: DateOfBirthInput(
// //                 dateController: dateController,
// //                 onTap: () {
// //                   _selectDate(context);
// //                   // print(newValue);
// //                 },
// //               ),
// //             ),
// //           ],
// //         ),
// //         Container(
// //           padding: const EdgeInsets.symmetric(vertical: 25.0),
// //           child: CustomButton(
// //             loader: isLoading
// //                 ? CircularProgressIndicator(
// //                     color: Colors.white,
// //                   )
// //                 : Text(
// //                     "Continue",
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 20,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //             title: "Continue",
// //             onpress: isFormValid
// //                 ? () async {
// //                     isLoading = true;
// //                     BaseRequest baseRequest = new BaseRequest();
// //                     baseRequest.register(userRegister!);
// //                   }
// //                 : null,
// //             enabled: isFormValid,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:youdoc/common/Color_extention.dart';
// import 'package:youdoc/common/customButton.dart';
// import 'package:youdoc/common/custom_dropdown.dart';
// import 'package:youdoc/common/date_input.dart';
// import 'package:youdoc/common/lineTextField.dart';
// import 'package:youdoc/components/api_request.dart';
// import 'package:youdoc/components/user.dart';
// import 'dart:convert';

// import 'package:youdoc/view/register/register_password_view.dart';

// class RegisterFormInputs extends StatefulWidget {
//   const RegisterFormInputs({super.key});

//   @override
//   State<RegisterFormInputs> createState() => _RegisterFormInputsState();
// }

// class _RegisterFormInputsState extends State<RegisterFormInputs> {
//   TextEditingController firstNameText = TextEditingController();
//   TextEditingController lastName = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController dateController = TextEditingController();

//   String? selectedSex;
//   final List<String> sexOptions = ['MALE', 'FEMALE'];

//   bool isLoading = false;

//   UserRegister userRegister = UserRegister(
//     firstName: "",
//     lastName: "",
//     email: "",
//     sex: "",
//     dob: "",
//   );

//   bool get isFormValid {
//     return firstNameText.text.isNotEmpty &&
//         lastName.text.isNotEmpty &&
//         email.text.isNotEmpty &&
//         selectedSex != null &&
//         dateController.text.isNotEmpty;
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       helpText: 'Select Date of Birth',
//       cancelText: 'Cancel',
//       confirmText: 'Select',
//     );
//     if (pickedDate != null) {
//       setState(() {
//         dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
//         userRegister.dob = dateController.text; // Update dob in userRegister
//       });
//     }
//   }

//   Future<void> _submitForm() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       BaseRequest baseRequest = new BaseRequest();
//       var response = await baseRequest.register(userRegister);
//       String message = response.message;
//       String btn = response.error;

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
//                             backgroundColor: MaterialStateProperty.all<Color>( btn != "" ? Colors.red : TColor.primary),
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

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CustomTextField(
//           textController: firstNameText,
//           placeholder: 'Enter first name',
//           onChanged: (value) => setState(() {
//             userRegister.firstName = value;
//           }),
//         ),
//         SizedBox(height: 15),
//         CustomTextField(
//           textController: lastName,
//           placeholder: 'Enter last name',
//           onChanged: (value) => setState(() {
//             userRegister.lastName = value;
//           }),
//         ),
//         SizedBox(height: 15),
//         CustomTextField(
//           textController: email,
//           placeholder: 'Enter email',
//           onChanged: (value) => setState(() {
//             userRegister.email = value;
//           }),
//         ),
//         SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: DropDownInput(
//                 options: sexOptions,
//                 selectedOption: selectedSex,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     selectedSex = newValue;
//                     userRegister.sex = selectedSex!;
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: DateOfBirthInput(
//                 dateController: dateController,
//                 onTap: () {
//                   _selectDate(context);
//                 },
//               ),
//             ),
//           ],
//         ),
//         Container(
//           padding: const EdgeInsets.symmetric(vertical: 25.0),
//           child: CustomButton(
//             loader: isLoading
//                 ? SizedBox(
//                     width: 25.0,
//                     height: 25.0,
//                     child: CircularProgressIndicator(
//                       color: Colors.white,
//                       strokeWidth: 4.0,
//                     ),
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
//             // onpress: isFormValid ? _submitForm : null,
//             onpress: (){
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const RegisterPasswordView(token: "token",),
//                 ),
//               );
//             },
//             enabled: isFormValid,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/customButton.dart';
import 'package:youdoc/common/custom_dropdown.dart';
import 'package:youdoc/common/date_input.dart';
import 'package:youdoc/common/lineTextField.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/components/user.dart';
import 'dart:convert';

import 'package:youdoc/view/register/register_password_view.dart';

class RegisterFormInputs extends StatefulWidget {
  const RegisterFormInputs({super.key});

  @override
  State<RegisterFormInputs> createState() => _RegisterFormInputsState();
}

class _RegisterFormInputsState extends State<RegisterFormInputs> {
  TextEditingController firstNameText = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String? selectedSex;
  final List<String> sexOptions = ['MALE', 'FEMALE'];

  bool isLoading = false;

  UserRegister userRegister = UserRegister(
    firstName: "",
    lastName: "",
    email: "",
    sex: "",
    dob: "",
  );

  bool get isFormValid {
    return firstNameText.text.isNotEmpty &&
        lastName.text.isNotEmpty &&
        email.text.isNotEmpty &&
        selectedSex != null &&
        dateController.text.isNotEmpty;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Select Date of Birth',
      cancelText: 'Cancel',
      confirmText: 'Select',
    );
    if (pickedDate != null) {
      setState(() {
        dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
        userRegister.dob = dateController.text; // Update dob in userRegister
      });
    }
  }

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = new BaseRequest();
      var response = await baseRequest.register(userRegister);
      String message = response.message;
      String btn = response.error;

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
                        style: TextStyle(
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
                                btn != "" ? Colors.red : TColor.primary),
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
                            style: TextStyle(color: Colors.white, fontSize: 14),
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
                        "ERROR",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '$e',
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
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
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
                          child: const Text(
                            "Close",
                            style: TextStyle(color: Colors.white, fontSize: 14),
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
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          textController: firstNameText,
          placeholder: 'Enter first name',
          onChanged: (value) => setState(() {
            userRegister.firstName = value;
          }),
        ),
        SizedBox(height: 15),
        CustomTextField(
          textController: lastName,
          placeholder: 'Enter last name',
          onChanged: (value) => setState(() {
            userRegister.lastName = value;
          }),
        ),
        SizedBox(height: 15),
        CustomTextField(
          textController: email,
          placeholder: 'Enter email',
          onChanged: (value) => setState(() {
            userRegister.email = value;
          }),
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: DropDownInput(
                options: sexOptions,
                selectedOption: selectedSex,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedSex = newValue;
                    userRegister.sex = selectedSex!;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DateOfBirthInput(
                dateController: dateController,
                onTap: () {
                  _selectDate(context);
                },
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 25.0),
          child: CustomButton(
            loader: isLoading
                ? SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4.0,
                    ),
                  )
                : Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            title: "Continue",
            onpress: isFormValid ? _submitForm : null,
            // onpress: (){
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const RegisterPasswordView(token: "token",),
            //     ),
            //   );
            // },
            enabled: isFormValid,
          ),
        ),
      ],
    );
  }
}
