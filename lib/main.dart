import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:youdoc/view/forgot_password/reset_password.dart';
import 'package:youdoc/view/home/home_navigator.dart';
import 'package:youdoc/view/login/login_view.dart';
import 'package:youdoc/view/on_boarding/on_boarding_view.dart';
import 'package:youdoc/view/register/register_password_view.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   StreamSubscription? _sub;
//   // bool _isInitialized = false;
//   String? _initialRoute;

//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//     initUniLinks();
//   }

//   Future<void> _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     if (token != null) {
//       setState(() {
//         _initialRoute = '/home';
//       });
//     } else {
//       setState(() {
//         _initialRoute = '/onboarding';
//       });
//     }
//     // setState(() {
//     //   _isInitialized = true;
//     // });
//   }

//   Future<void> initUniLinks() async {
//     try {
//       Uri? initialUri = await getInitialUri();
//       _handleIncomingUri(initialUri);

//       _sub = uriLinkStream.listen((Uri? uri) {
//         if (uri != null) {
//           _handleIncomingUri(uri);
//         }
//       }, onError: (err) {
//         // Handle errors
//       });
//     } on PlatformException {
//       // Handle error
//     } on FormatException {
//       // Handle error
//     }
//   }

//   void _handleIncomingUri(Uri? uri) async {
//     if (uri != null) {
//       var token = uri.queryParameters['token'];
//       if (token != null) {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setString('token', token);

//         setState(() {
//           _initialRoute = "/home";
//         });

//         // if (uri.path == '/confirm-registration' || uri.path == '/login' || uri.path == '/forgot-password') {
//         //   setState(() {
//         //     _initialRoute = '/home';
//         //   });
//         // }
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _sub?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // if (!_isInitialized) {
//     //   return MaterialApp(
//     //     debugShowCheckedModeBanner: false,
//     //     title: 'Youdoc App',
//     //     theme: ThemeData(
//     //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//     //       useMaterial3: true,
//     //     ),
//     //     home: const SplashScreen(),
//     //   );
//     // }

//     Widget home = const SplashScreen();

//     if (_initialRoute != null) {
//       if (_initialRoute == '/home') {
//         home = const HomeNavigator();
//       } else if (_initialRoute == '/onboarding') {
//         home = OnBoardingView();
//       }
//     } else {
//       home = OnBoardingView();
//     }

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Youdoc App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: home,
//       // routes: {
//       //   '/home': (context) => const HomeNavigator(),
//       //   "/login": (context) => const LoginView()
//       // },
//     );
//   }
// }

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   StreamSubscription? _sub;
//   bool _isInitialized = false;
//   Widget _initialPage = OnBoardingView();

//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//     initUniLinks();
//   }

//   Future<void> _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     if (token != null) {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => const HomeNavigator(),
//         ),
//         (route) => false,
//       );
//     // } else {
//       // Navigator.push(
//       //   context,
//       //   MaterialPageRoute(
//       //     builder: (context) => OnBoardingView(),
//       //   ),
//       // );
//     }
//     setState(() {
//       _isInitialized = true;
//     });
//   }

//   Future<void> initUniLinks() async {
//     try {
//       Uri? initialUri = await getInitialUri();
//       _handleIncomingUri(initialUri);

//       _sub = uriLinkStream.listen((Uri? uri) {
//         if (uri != null) {
//           _handleIncomingUri(uri);
//         }
//       }, onError: (err) {
//         // Handle errors
//       });
//     } on PlatformException {
//       // Handle error
//     } on FormatException {
//       // Handle error
//     }
//   }

//   void _handleIncomingUri(Uri? uri) async {
//     if (uri != null) {
//       var token = uri.queryParameters['token'];
//       if (token != null) {

//         if (uri.path == "/confirm-registration") {
//           setState(() {
//             _initialPage = RegisterPasswordView(email: "confirm", token: token);
//           });
//         }

//         if (uri.path == "/login") {
//           setState(() {
//             _initialPage = LoginView(token: token);
//           });
//         }

//         if (uri.path == "forgot-password") {
//           setState(() {
//             _initialPage = ResetPassword(email: "confirm", token: token);
//           });
//         }
//       } else {
//         setState(() {
//           _initialPage = OnBoardingView();
//         });
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _sub?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized) {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Youdoc App',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         home: OnBoardingView(),
//       );
//     }

//     Widget home = _initialPage;

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Youdoc App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: home,
//     );
//   }
// }

void main() {   
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _sub;
  bool _isInitialized = false;
  Widget _initialPage = OnBoardingView();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
    initUniLinks();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    if (token != null) {
      // Set the initial page based on login status
      setState(() {
        _initialPage = const HomeNavigator();
      });
    }
    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> initUniLinks() async {
    try {
      Uri? initialUri = await getInitialUri();
      _handleIncomingUri(initialUri);

      _sub = uriLinkStream.listen((Uri? uri) {
        if (uri != null) {
          _handleIncomingUri(uri);
        }
      }, onError: (err) {
        // Handle errors
      });
    } on PlatformException {
      // Handle error
    } on FormatException {
      // Handle error
    }
  }

  void _handleIncomingUri(Uri? uri) async {
    if (uri != null) {
      var token = uri.queryParameters['token'];
      if (token != null) {
        if (uri.path == "/confirm-registration") {
          setState(() {
            _initialPage = RegisterPasswordView(email: "confirm", token: token);
          });
        } else if (uri.path == "/login") {
          setState(() {
            _initialPage = LoginView(token: token);
          });
        } else if (uri.path == "/forgot-password") {
          setState(() {
            _initialPage = ResetPassword(email: "confirm", token: token);
          });
        }
      } else {
        setState(() {
          _initialPage = OnBoardingView();
        });
      }
    }
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