import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/view/home/home_navigator.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication _auth = LocalAuthentication();

  bool _isAuthenticated = false;

  void _authenticator() async {
  if (_isAuthenticated) {
    _redirectUser();
  } else {
    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: "Please authenticate to login",
        options: const AuthenticationOptions(
          biometricOnly: false,
        ),
      );
      
      setState(() {
        _isAuthenticated = didAuthenticate;
      });

      if (didAuthenticate) {
        _redirectUser();
      } else {
        print('Authentication failed');
      }
    } catch (e) {
      print(e);
    }
  }
}

void _redirectUser() {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (ctx) => const HomeNavigator(),
    ),
    (route) => false,
  );
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authenticator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: Center(
        child: Container(
          // color: TColor.primaryBg,
          // child: const Text(
          //   "Auth",
          //   style: TextStyle(color: Colors.white),
          // ),
        ),
      ),
    );
  }
}
