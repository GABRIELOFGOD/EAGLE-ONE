import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common_widget/auth/auth_dialogue.dart';
import 'package:youdoc/components/reusable_functions.dart';
import 'package:youdoc/view/auth_screen/auth_screen.dart';
import 'package:youdoc/view/login/login_view.dart';
// import 'package:app';
import 'dart:async';
import 'package:youdoc/view/on_boarding/on_boarding_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;
  bool _isInitialized = false;
  Widget? _initialPage;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      var userSettings = await getUserSettings();
      if (userSettings == null) {
        setState(() {
          _initialPage = const AuthDialogue();
        });
      } else {
        if (userSettings.authMethod == AuthMethod.auth) {
          setState(() {
            _initialPage = const AuthScreen();
          });
        } else {
          prefs.remove("token");
          setState(() {
            _initialPage = const LoginView();
          });
        }
      }
      // setState(() {
      //   _initialPage = const HomeNavigator();
      // });
    } else {
      setState(() {
        _initialPage = OnBoardingView();
      });
    }
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Youdoc App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: OnBoardingView(),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youdoc App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _initialPage,
    );
  }
}
