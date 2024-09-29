import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/common_widget/otp/otp_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/model/transaction.dart';

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({super.key, required this.email});

  final String email;

  @override
  State<NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
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
          color: isValid ? TColor.success : Colors.grey,
          size: 14,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
              color: isValid ? TColor.success : TColor.inputGray,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  bool _isPasswordValid() {
    String p = password.text;
    bool hasUppercase = p.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = p.contains(RegExp(r'[a-z]'));
    bool hasDigits = p.contains(RegExp(r'\d'));
    bool hasSpecialCharacters = p.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = p.length >= 8 && p.length <= 24;
    return hasUppercase &&
        hasLowercase &&
        hasDigits &&
        hasSpecialCharacters &&
        hasMinLength;
  }

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      ChangePasswordRequest changePasswordRequest = ChangePasswordRequest(
        email: widget.email,
        password: password.text,
      );

      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.changePassword(changePasswordRequest);
      if (response.error.isEmpty) {
        showDialog(
          context: context,
          builder: (ctx) => OtpDialog(
            email: changePasswordRequest.email,
          ),
        );
      } else {
        SnackBar snackBar = SnackBar(
          content: Text(
            response.message,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } catch (e) {
      SnackBar snackBar = SnackBar(
        content: Text(
          e.toString(),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                : Text(
                    "Reset password",
                    style: TextStyle(
                      color: isFormValid && !isLoading
                          ? Colors.white
                          : TColor.inputGray,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            title: "Reset password",
            onpress: isFormValid && !isLoading ? _submitForm : () {},
            enabled: isFormValid && !isLoading,
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
                fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 15),
        buildPasswordValidationCheck(
            "At least one uppercase letter", hasUppercase),
        const SizedBox(height: 10),
        buildPasswordValidationCheck(
            "At least one lowercase letter", hasLowercase),
        const SizedBox(height: 10),
        buildPasswordValidationCheck("At least one digit (0-9)", hasDigits),
        const SizedBox(height: 10),
        buildPasswordValidationCheck(
            "At least one special character (*&%#)", hasSpecialCharacters),
        const SizedBox(height: 10),
        buildPasswordValidationCheck("8-24 characters in total", hasMinLength),
      ],
    );
  }
}
