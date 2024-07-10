// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:youdoc/common/color_extention.dart';
// import 'package:youdoc/common/loader_overlay.dart';
// import 'package:youdoc/components/api_request.dart';
// import 'package:youdoc/view/dashboard/dashboard_view.dart';
// import 'package:youdoc/view/login/login_view.dart';

// class HomeNavigator extends StatefulWidget {
//   const HomeNavigator({super.key});

//   @override
//   State<HomeNavigator> createState() => _HomeNavigatorState();
// }

// class _HomeNavigatorState extends State<HomeNavigator> {
//   int _selectedIndex = 0;

//   bool _isLoading = false;
//   late bool isAddress;

//   List<Widget> currentWidget = [
//     DashboardView(
//       noAddress: isAddress,
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     isAddress = false;
//     _homePageLoad();
//   }

//   Future<void> _checkLoginStatus() async {
//     setState(() {});
//   }

//   Future<void> _homePageLoad() async {
//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();

//       var _token = prefs.getString('token');

//       if (_token == null) {
//         throw Exception('Token not found');
//       }

//       String token = _token;

//       BaseRequest baseRequest = BaseRequest();
//       var response = await baseRequest.profile(token);
//       String message = response.message;
//       String error = response.error;
//       dynamic data = response.data.toString();

//       if (error == "") {
//         setState(() {
//           _isLoading = false;
//         });

//         if (data["address"] != null &&
//             data["ZIP"] != null &&
//             data["state"] != null &&
//             data["city"] != null) {
//           setState(() {
//             isAddress = true;
//           });
//         }
//       } else {
// showDialog(
//   context: context,
//   barrierColor: Colors.black.withOpacity(0.5),
//   builder: (context) {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 50),
//         child: Material(
//           color: Colors.transparent,
//           child: Container(
//             decoration: BoxDecoration(
//               color: TColor.primaryBg.withOpacity(0.9),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             padding: const EdgeInsets.all(20),
//             width: MediaQuery.of(context).size.width * 0.9,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   "ERROR",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   message,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 SizedBox(
//                   width: double.infinity,
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const LoginView(),
//                         ),
//                       );
//                     },
//                     style: ButtonStyle(
//                       backgroundColor:
//                           MaterialStateProperty.all<Color>(Colors.red),
//                       foregroundColor: MaterialStateProperty.all<Color>(
//                           Colors.white),
//                       textStyle: MaterialStateProperty.all<TextStyle>(
//                           const TextStyle(fontSize: 14)),
//                       shape: MaterialStateProperty.all<
//                           RoundedRectangleBorder>(
//                         RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                       ),
//                     ),
//                     child: const Text(
//                       "Close",
//                       style:
//                           TextStyle(color: Colors.white, fontSize: 14),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   },
// );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         barrierColor: Colors.black.withOpacity(0.5),
//         builder: (context) {
//           return Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 50),
//               child: Material(
//                 color: Colors.transparent,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: TColor.primaryBg.withOpacity(0.9),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   padding: const EdgeInsets.all(20),
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         "ERROR",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         '$e',
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       SizedBox(
//                         width: double.infinity,
//                         child: TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           style: ButtonStyle(
//                             backgroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.red),
//                             foregroundColor:
//                                 MaterialStateProperty.all<Color>(Colors.white),
//                             textStyle: MaterialStateProperty.all<TextStyle>(
//                                 const TextStyle(fontSize: 14)),
//                             shape: MaterialStateProperty.all<
//                                 RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8.0),
//                               ),
//                             ),
//                           ),
//                           child: const Text(
//                             "Close",
//                             style: TextStyle(color: Colors.white, fontSize: 14),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       );
//       // } finally {
//       //   setState(() {
//       //     _isLoading = false;
//       //   });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Colors.black,
//         unselectedItemColor: TColor.bottomBar,
//         selectedItemColor: Colors.white,
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         type: BottomNavigationBarType.fixed,
//         // backgroundColor: Colors.black,
//         items: [
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               "assets/icons/home_icon.png",
//               width: 19.2,
//               height: 19.2,
//               color: _selectedIndex == 0 ? Colors.white : TColor.bottomBar,
//             ),
//             label: '',
//             backgroundColor: Colors.black,
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               "assets/icons/calendar_icon.png",
//               width: 19.2,
//               height: 19.2,
//               color: _selectedIndex == 1 ? Colors.white : TColor.bottomBar,
//             ),
//             label: '',
//             backgroundColor: Colors.black,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.menu,
//               size: 19.2,
//               color: _selectedIndex == 2 ? Colors.white : TColor.bottomBar,
//             ),
//             label: '',
//             backgroundColor: Colors.black,
//           ),
//           BottomNavigationBarItem(
//             icon: Image.asset(
//               "assets/icons/message_icon.png",
//               width: 19.2,
//               height: 19.2,
//               color: _selectedIndex == 3 ? Colors.white : TColor.bottomBar,
//             ),
//             label: '',
//             backgroundColor: Colors.black,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.credit_card,
//               size: 19.2,
//               color: _selectedIndex == 4 ? Colors.white : TColor.bottomBar,
//             ),
//             label: '',
//             backgroundColor: Colors.black,
//           ),
//         ],
//       ),
//       backgroundColor: TColor.primaryBg,
//       body: Stack(children: [
//         SafeArea(
//           child: currentWidget[_selectedIndex],
//         ),
//         LoadingOverlay(
//           isLoading: _isLoading,
//         ),
//       ]),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/loader_overlay.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/view/dashboard/dashboard_view.dart';
import 'package:youdoc/view/login/login_view.dart';
import 'package:youdoc/view/login/logout_screen.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({Key? key}) : super(key: key);

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _selectedIndex = 0;
  bool _isLoading = false;
  bool isAddress = false; // Initialize isAddress

  List<Widget> currentWidget = [];

  @override
  void initState() {
    super.initState();
    _homePageLoad(); // Start loading data on init
  }

  Future<void> _homePageLoad() async {
    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var _token = prefs.getString('token');

      if (_token == null) {
        throw Exception('Token not found');
      }

      String token = _token;

      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.profile(token);

      String message = response.message;
      String error = response.error;
      dynamic data = response.data;

      if (error == "") {
        setState(() {
          _isLoading = false;
        });

        if (data is Map<String, dynamic> &&
            data.containsKey("address") &&
            data.containsKey("ZIP") &&
            data.containsKey("state") &&
            data.containsKey("city")) {
          setState(() {
            isAddress = true;
          });
        } else {
          throw Exception('Data format not as expected');
        }
      } else {
        showDialog(
          context: context,
          barrierColor: Colors.black.withOpacity(0.5),
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('$e'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        unselectedItemColor: TColor.bottomBar,
        selectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Payment',
          ),
        ],
      ),
      backgroundColor: TColor.primaryBg,
      body: Stack(
        children: [
          SafeArea(
            child: _buildCurrentWidget(),
          ),
          LoadingOverlay(isLoading: _isLoading),
        ],
      ),
    );
  }

  Widget _buildCurrentWidget() {
    switch (_selectedIndex) {
      case 0:
        return DashboardView(noAddress: isAddress);
      case 1:
        return DashboardView(noAddress: isAddress);
      case 2:
        return DashboardView(noAddress: isAddress);
      case 3:
        return DashboardView(noAddress: isAddress);
      case 4:
        return LogoutScreen();
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
