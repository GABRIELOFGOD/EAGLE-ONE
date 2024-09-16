
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common_widget/auth/auth_dialogue.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/components/reusable_functions.dart';
import 'package:youdoc/model/user.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    super.key,
    required this.onOtpError,
    required this.email,
  });

  final Function(String?) onOtpError;
  final String email;

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String otpCode = "";
  bool _isLoading = false;

  // Controllers for each TextFormField
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();

  void _updateOtpCode() {
    setState(() {
      otpCode = _controller1.text +
          _controller2.text +
          _controller3.text +
          _controller4.text +
          _controller5.text;
    });
  }

  void _submitOtp() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _isLoading = true;
    });
    OtpRequest otpRequest = OtpRequest(
      email: widget.email,
      code: int.parse(otpCode),
    );

    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.confirmToken(otpRequest);
      String message = response.message;
      String error = response.error;
      String token = response.token;

      if (error.isEmpty) {
        var userSettings = await getUserSettings();
        if (userSettings == null) {
          showDialog(
            context: context,
            builder: (ctx) => const AuthDialogue(),
          );
        }
        sharedPreferences.setString("token", token);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(
        //     builder: (ctx) => const HomeNavigator(),
        //   ),
        //   (route) => false,
        // );
      } else {
        widget.onOtpError(message);
      }
    } catch (e) {
      widget.onOtpError(
        e.toString(),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 48,
                height: 43,
                child: TextFormField(
                  controller: _controller1,
                  onChanged: (value) {
                    _updateOtpCode();
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: TColor.btnBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 48,
                height: 43,
                child: TextFormField(
                  controller: _controller2,
                  onChanged: (value) {
                    if (_controller1.text.isEmpty) {
                      FocusScope.of(context).previousFocus();
                      return;
                    }
                    _updateOtpCode();
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: TColor.btnBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 48,
                height: 43,
                child: TextFormField(
                  controller: _controller3,
                  onChanged: (value) {
                    if (_controller2.text.isEmpty) {
                      FocusScope.of(context).previousFocus();
                      return;
                    }
                    _updateOtpCode();
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: TColor.btnBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 48,
                height: 43,
                child: TextFormField(
                  controller: _controller4,
                  onChanged: (value) {
                    if (_controller3.text.isEmpty) {
                      FocusScope.of(context).previousFocus();
                      return;
                    }
                    _updateOtpCode();
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: TColor.btnBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 48,
                height: 43,
                child: TextFormField(
                  controller: _controller5,
                  onChanged: (value) {
                    if (_controller4.text.isEmpty) {
                      FocusScope.of(context).previousFocus();
                      return;
                    }
                    _updateOtpCode();
                    if (value.length == 1) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: TColor.btnBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 36,
        ),
        MaterialButton(
          onPressed: otpCode.length == 5 ? _submitOtp : () {},
          color: otpCode.length == 5 ? TColor.primary : TColor.inactiveBtn,
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
            child: Center(
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 4,
                    )
                  : Text(
                      "Verify OTP",
                      style: TextStyle(
                        color: otpCode.length == 5
                            ? Colors.white
                            : TColor.bottomBar,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    _controller5.dispose();
    super.dispose();
  }
}
