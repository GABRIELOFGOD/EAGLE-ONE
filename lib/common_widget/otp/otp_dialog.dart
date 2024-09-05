import 'package:flutter/material.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common_widget/otp/otp_form.dart';

class OtpDialog extends StatefulWidget {
  const OtpDialog({super.key, required this.email});

  final String email;

  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  String? _otpError;

  void _handleOtpError(String? error) {
    setState(() {
      _otpError = error;
    });
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
                          "Enter OTP",
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
                          _otpError ??
                              "An OTP has been sent to your email address",
                          style: TextStyle(
                            color: _otpError == null
                                ? TColor.textGray
                                : TColor.error,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          softWrap: true,
                          overflow: TextOverflow
                              .visible, // or TextOverflow.clip if you prefer clipping
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: TColor.inputBg,
                        ),
                        padding: const EdgeInsets.all(6),
                        child: Icon(
                          Icons.close,
                          size: 12,
                          color: TColor.btnText,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 36,
                ),
                OtpForm(
                  onOtpError: _handleOtpError,
                  email: widget.email,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
