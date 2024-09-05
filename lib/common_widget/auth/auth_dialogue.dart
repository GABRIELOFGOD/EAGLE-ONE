import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/components/reusable_functions.dart';
import 'package:youdoc/view/auth_screen/auth_screen.dart';
import 'package:youdoc/view/home/home_navigator.dart';

class AuthDialogue extends StatefulWidget {
  const AuthDialogue({super.key});

  @override
  State<AuthDialogue> createState() => _AuthDialogueState();
}

class _AuthDialogueState extends State<AuthDialogue> {
  AuthMethod? authMethod = AuthMethod.email;

  void _setAuthMethod() async {
    if (authMethod == AuthMethod.auth) {
      UserSettings userSettings = UserSettings(authMethod: AuthMethod.auth);
      await saveUserSettings(userSettings);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const AuthScreen(),
        ),
      );
    } else {
      UserSettings userSettings = UserSettings(authMethod: AuthMethod.email);
     await saveUserSettings(userSettings);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => const HomeNavigator(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 50,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            decoration: BoxDecoration(
              color: TColor.dialog,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login options",
                          style: TextStyle(
                            color: TColor.btnText,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Choose how you want to log in",
                          style: TextStyle(
                            color: TColor.textGray,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: true,
                          overflow: TextOverflow
                              .visible, // or TextOverflow.clip if you prefer clipping
                        ),
                      ],
                    ),
                    // GestureDetector(
                    //   onTap: () => Navigator.pop(context),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(100),
                    //       color: TColor.inputBg,
                    //     ),
                    //     padding: const EdgeInsets.all(6),
                    //     child: Icon(
                    //       Icons.close,
                    //       size: 12,
                    //       color: TColor.btnText,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Radio<AuthMethod>(
                            activeColor: TColor.primary,
                            value: AuthMethod.auth,
                            groupValue: authMethod,
                            onChanged: (AuthMethod? value) {
                              setState(() {
                                authMethod = value;
                              });
                            },
                          ),
                          Platform.isIOS
                              ? Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: TColor.inactiveBtn,
                                      ),
                                      child: Image.asset(
                                        "assets/icons/face_id.png",
                                        width: 20,
                                        height: 20,
                                        color: authMethod == AuthMethod.auth
                                            ? TColor.btnText
                                            : TColor.bottomBar,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Face ID",
                                      style: TextStyle(
                                        color: authMethod == AuthMethod.auth
                                            ? Colors.white
                                            : TColor.bottomBar,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: TColor.inactiveBtn,
                                      ),
                                      child: Image.asset(
                                        "assets/icons/biometric.png",
                                        width: 20,
                                        height: 20,
                                        color: authMethod == AuthMethod.auth
                                            ? TColor.btnText
                                            : TColor.bottomBar,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      "Biometric",
                                      style: TextStyle(
                                        color: authMethod == AuthMethod.auth
                                            ? Colors.white
                                            : TColor.bottomBar,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Radio<AuthMethod>(
                            activeColor: TColor.primary,
                            value: AuthMethod.email,
                            groupValue: authMethod,
                            onChanged: (AuthMethod? value) {
                              setState(() {
                                authMethod = value;
                              });
                            },
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: TColor.inactiveBtn,
                                ),
                                child: Image.asset(
                                  "assets/icons/email.png",
                                  width: 20,
                                  height: 20,
                                  color: authMethod == AuthMethod.email
                                      ? TColor.btnText
                                      : TColor.bottomBar,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Email",
                                style: TextStyle(
                                  color: authMethod == AuthMethod.email
                                      ? Colors.white
                                      : TColor.bottomBar,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                MaterialButton(
                  onPressed: _setAuthMethod,
                  color: TColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  minWidth: double.infinity,
                  height: 45.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 6,
                    ),
                    child: const Center(
                      child: Text(
                        "Authenticate",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
