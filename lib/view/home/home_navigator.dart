import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/loader_overlay.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/view/dashboard/dashboard_view.dart';
import 'package:youdoc/view/login/login_view.dart';
import 'package:youdoc/view/login/logout_screen.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _selectedIndex = 0;
  bool _isLoading = false;
  bool isAddress = false;

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
        _showErrorDialog(context, message);
      }
    } catch (e) {
      _showErrorDialog(context, '$e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
        items: const [
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
}


// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:youdoc/common/color_extention.dart';
// import 'package:youdoc/common/loader_overlay.dart';
// import 'package:youdoc/components/api_request.dart';
// import 'package:youdoc/view/dashboard/dashboard_view.dart';
// import 'package:youdoc/view/login/login_view.dart';
// import 'package:youdoc/view/login/logout_screen.dart';

// class HomeNavigator extends StatefulWidget {
//   const HomeNavigator({super.key});

//   @override
//   State<HomeNavigator> createState() => _HomeNavigatorState();
// }

// class _HomeNavigatorState extends State<HomeNavigator> {
//   int _selectedIndex = 0;
//   bool _isLoading = false;
//   bool isAddress = false; // Initialize isAddress

//   List<Widget> currentWidget = [];

//   @override
//   void initState() {
//     super.initState();
//     _homePageLoad(); // Start loading data on init
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
//       dynamic data = response.data;

//       if (error == "") {
//         setState(() {
//           _isLoading = false;
//         });

//         if (data is Map<String, dynamic> &&
//             data.containsKey("address") &&
//             data.containsKey("ZIP") &&
//             data.containsKey("state") &&
//             data.containsKey("city")) {
//           setState(() {
//             isAddress = true;
//           });
//         } else {
//           throw Exception('Data format not as expected');
//         }
//       } else {
//         showDialog(
//           context: context,
//           barrierColor: Colors.black.withOpacity(0.5),
//           builder: (context) {
//             return AlertDialog(
//               title: Text('Error'),
//               content: Text(message),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text('Close'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } catch (e) {
//       showDialog(
//         context: context,
//         barrierColor: Colors.black.withOpacity(0.5),
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('$e'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('Close'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
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
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.calendar_today),
//             label: 'Calendar',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.menu),
//             label: 'Menu',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Message',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.credit_card),
//             label: 'Payment',
//           ),
//         ],
//       ),
//       backgroundColor: TColor.primaryBg,
//       body: Stack(
//         children: [
//           SafeArea(
//             child: _buildCurrentWidget(),
//           ),
//           LoadingOverlay(isLoading: _isLoading),
//         ],
//       ),
//     );
//   }

//   Widget _buildCurrentWidget() {
//     switch (_selectedIndex) {
//       case 0:
//         return DashboardView(noAddress: isAddress);
//       case 1:
//         return DashboardView(noAddress: isAddress);
//       case 2:
//         return DashboardView(noAddress: isAddress);
//       case 3:
//         return DashboardView(noAddress: isAddress);
//       case 4:
//         return LogoutScreen();
//       default:
//         return Container();
//     }
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
// }
