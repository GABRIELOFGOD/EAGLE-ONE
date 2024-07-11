// // import 'package:flutter/material.dart';
// // import 'package:youdoc/view/on_boarding/on_boarding_view.dart';

// // void main() {
// //   runApp(const MyApp());
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});

// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         // This is the theme of your application.
// //         //
// //         // TRY THIS: Try running your application with "flutter run". You'll see
// //         // the application has a purple toolbar. Then, without quitting the app,
// //         // try changing the seedColor in the colorScheme below to Colors.green
// //         // and then invoke "hot reload" (save your changes or press the "hot
// //         // reload" button in a Flutter-supported IDE, or press "r" if you used
// //         // the command line to start the app).
// //         //
// //         // Notice that the counter didn't reset back to zero; the application
// //         // state is not lost during the reload. To reset the state, use hot
// //         // restart instead.
// //         //
// //         // This works for code too, not just values: Most code changes can be
// //         // tested with just a hot reload.
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: OnBoardingView(),
// //     );
// //   }

// // }

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uni_links/uni_links.dart';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:youdoc/view/forgot_password/reset_password.dart';
// import 'package:youdoc/view/home/home_navigator.dart';
// import 'package:youdoc/view/on_boarding/on_boarding_view.dart';
// import 'package:youdoc/view/register/register_password_view.dart';
// import 'package:youdoc/view/splash/splash_screen.dart';

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
//   bool _isLoggedIn = false;
//   bool _isInitialized = false;
//   String? _initialRoute;
//   Map<String, dynamic>? _initialRouteArgs;

//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//     initUniLinks();
//   }

//   Future<void> _checkLoginStatus() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       var token = prefs.getString('token');
//       _isLoggedIn = token != null;
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

//   void _handleIncomingUri(Uri? uri) {
//     if (uri != null) {
//       if (uri.path == '/confirm-registration') {
//         var token = uri.queryParameters['token'];
//         if (token != null) {
//           setState(() {
//             _initialRoute = '/confirm-registration';
//             _initialRouteArgs = {'token': token};
//           });
//         }
//       } else if (uri.path == '/forgot-password') {
//         var token = uri.queryParameters['token'];
//         if (token != null) {
//           setState(() {
//             _initialRoute = '/forgot-password';
//             _initialRouteArgs = {'token': token};
//           });
//         }
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
//         home: const SplashScreen(),
//       );
//     }

//     Widget home = const SplashScreen();

//     if (_initialRoute != null) {
//       if (_initialRoute == '/confirm-registration') {
//         home = const HomeNavigator();
//       } else if (_initialRoute == '/forgot-password') {
//         home = ResetPassword(token: _initialRouteArgs!['token']);
//       }
//     } else {
//       if (_isLoggedIn) {
//         home = const HomeNavigator();
//       } else {
//         home = OnBoardingView();
//       }
//     }

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Youdoc App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: home,
//       routes: {
//         '/confirm-registration': (context) => const HomeNavigator(),
//         '/forgot-password': (context) => ResetPassword(
//               token: ModalRoute.of(context)!.settings.arguments as String,
//             ),
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:youdoc/view/forgot_password/reset_password.dart';
import 'package:youdoc/view/home/home_navigator.dart';
import 'package:youdoc/view/login/login_view.dart';
import 'package:youdoc/view/splash/splash_screen.dart';

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
  String? _initialRoute;

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
      setState(() {
        _initialRoute = '/home';
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
        if (uri.path == '/confirm-registration' || uri.path == '/login') {
          // Store token in SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', token);
          setState(() {
            _initialRoute = '/home';
          });
        } else if (uri.path == '/forgot-password') {
          // Navigate to ResetPassword
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResetPassword(token: token),
            ),
          );
        }
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
        home: const SplashScreen(),
      );
    }

    Widget home = const SplashScreen();

    if (_initialRoute != null) {
      if (_initialRoute == '/home') {
        home = HomeNavigator();
      }
    } else {
      home = const LoginView();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Youdoc App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: home,
      routes: {
        '/home': (context) => const HomeNavigator(),
        '/forgot-password': (context) => ResetPassword(
              token: ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}

// Dummy Widgets for demonstration
// class SplashView extends StatelessWidget {
//   const SplashView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('Splash Screen')),
//     );
//   }
// }

// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('Login Screen')),
//     );
//   }
// }

// class HomeNavigator extends StatefulWidget {
//   const HomeNavigator({super.key});

//   @override
//   _HomeNavigatorState createState() => _HomeNavigatorState();
// }

// class _HomeNavigatorState extends State<HomeNavigator> {
//   String? _token;
//   bool _isValid = false;

//   @override
//   void initState() {
//     super.initState();
//     _verifyToken();
//   }

//   Future<void> _verifyToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('token');
//     if (token != null) {
//       bool isValid = await _checkTokenValidity(token);
//       setState(() {
//         _token = token;
//         _isValid = isValid;
//       });
//     }
//   }

//   Future<bool> _checkTokenValidity(String token) async {
//     // Replace with your backend token verification API
//     final response = await http.post(
//       Uri.parse('https://your-backend.com/verify-token'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{'token': token}),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body)['isValid'];
//     } else {
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isValid) {
//       return Scaffold(
//         body: Center(child: Text('Invalid or no token')),
//       );
//     }

//     return Scaffold(
//       body: Center(child: Text('Home Navigator with token: $_token')),
//     );
//   }
// }

// class ResetPassword extends StatelessWidget {
//   final String token;
//   const ResetPassword({required this.token, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('Reset Password with token: $token')),
//     );
//   }
// }
