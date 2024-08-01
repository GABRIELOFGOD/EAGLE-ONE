import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/common/custom_dropdown.dart';
import 'package:youdoc/common/date_input.dart';
import 'package:youdoc/common/line_text_field.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/components/user.dart';
import 'package:youdoc/view/login/login_view.dart';
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
  final List<String> sexOptions = ['Male', 'Female'];

  bool isLoading = false;

  late SharedPreferences prefs;

  UserRegister userRegister = UserRegister(
    firstName: "",
    lastName: "",
    email: "",
    sex: "",
    dob: "",
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPreferences();
  }

  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

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
        userRegister.dob = dateController.text;
      });
    }
  }

  Future<void> _submitForm() async {
    setState(() {
      isLoading = true;
    });
    try {
      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.register(userRegister);
      String message = response.message;
      String btn = response.error;
      String email = response.email;

      if (btn == "") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPasswordView(
              email: email,
              token: "confirm",
            ),
          ),
        );
      } else {
        _showMessageDialog(
          message,
          () {
            if (btn == "Conflict") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginView(
                    token: "confirm",
                  ),
                ),
              );
            } else {
              Navigator.of(context).pop();
            }
          },
          btn == "Conflict" ? "Uh-oh!" : "Error",
          btn == "Conflict"
              ? "Unable to proceed with account registration"
              : "Something went wrong",
          btn == "Conflict" ? "Login" : "Close",
          btn == "Conflict" ? TColor.warning : Colors.red,
          btn == "Conflict" ? Colors.black : Colors.white,
        );
      }
    } catch (e) {
      _showMessageDialog(
        e.toString(),
        () {
          _submitForm();
          Navigator.of(context).pop();
        },
        "Error",
        "Something went wrong",
        "Retry",
        Colors.red,
        Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showMessageDialog(
      String message,
      VoidCallback closeFunction,
      String title,
      String sub,
      String closeText,
      Color btnColor,
      Color? textColor) {
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
          btnTextColor: textColor,
        );
      },
    );
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
        const SizedBox(height: 15),
        CustomTextField(
          textController: lastName,
          placeholder: 'Enter last name',
          onChanged: (value) => setState(() {
            userRegister.lastName = value;
          }),
        ),
        const SizedBox(height: 15),
        CustomTextField(
          textController: email,
          placeholder: 'Enter email',
          onChanged: (value) => setState(() {
            userRegister.email = value;
          }),
        ),
        const SizedBox(height: 15),
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
                ? const SizedBox(
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
                      color: isFormValid ? Colors.white : TColor.bottomBar,
                      fontSize: 16,
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
