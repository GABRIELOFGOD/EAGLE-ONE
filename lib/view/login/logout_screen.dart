import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/view/on_boarding/on_boarding_view.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            bool isRemoved = await preferences.remove("token");
            await preferences.remove("userSettings");
            if (isRemoved) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => OnBoardingView(),
                ),
                (Route<dynamic> route) => false,
              );
            }
          },
          color: Colors.blue,
          child: const Text(
            "Logout",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
