// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:uni_links/uni_links.dart';
// import 'package:youdoc/view/on_boarding/on_boarding_view.dart';
// import 'package:youdoc/view/register/register_password_view.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   StreamSubscription? _sub;

//   @override
//   void initState() {
//     super.initState();
//     print("init");
//     initUniLinks();
//     print("done init");
//   }

//   @override
//   void dispose() {
//     _sub?.cancel();
//     super.dispose();
//   }

//   void initUniLinks() async {
//     try {
//       final initialLink = await getInitialLink();
//       if (initialLink != null) {
//         _handleIncomingLink(initialLink);
//       } else {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OnBoardingView(),
//           ),
//         );
//       }

//       _sub = linkStream.listen((String? link) {
//         if (link != null) {
//           _handleIncomingLink(link);
//         }
//       });
//     } on Exception catch (e) {
//       print(e.toString());
//     }
//   }

//   void _handleIncomingLink(String link) {
//     print('token received');
//     final uri = Uri.parse(link);
//     final queryParams = uri.queryParameters;
//     print(queryParams);
//     if (queryParams.containsKey('token')) {
//       String token = queryParams['token']!;
//       // Navigate to the target page with the token
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RegisterPasswordView(token: token),
//         ),
//       );
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => OnBoardingView(),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Text(
//         "This is a dummy splash screen",
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_links/uni_links.dart';
import 'package:youdoc/view/on_boarding/on_boarding_view.dart';
import 'package:youdoc/view/register/register_password_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void initUniLinks() async {
    // Handle the initial deep link when the app is launched
    try {
      final initialLink = await getInitialLink();
      if (initialLink != null) {
        _handleIncomingLink(initialLink);
      } else {
        _navigateToOnBoarding();
      }

      // Handle incoming deep links when the app is already running
      _sub = linkStream.listen((String? link) {
        if (link != null) {
          _handleIncomingLink(link);
        }
      }, onError: (err) {
        print('Error handling link stream: $err');
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void _handleIncomingLink(String link) {
    final uri = Uri.parse(link);
    final queryParams = uri.queryParameters;
    if (queryParams.containsKey('token')) {
      String token = queryParams['token']!;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPasswordView(token: token),
        ),
        (route) => false,
      );
    } else {
      _navigateToOnBoarding();
    }
  }

  void _navigateToOnBoarding() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OnBoardingView(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "This is a dummy splash screen",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}



