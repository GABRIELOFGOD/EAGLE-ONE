import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/loader_overlay.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/view/dashboard/dashboard_view.dart';
import 'package:youdoc/view/on_boarding/on_boarding_view.dart';
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
  String username = "";

  @override
  void initState() {
    super.initState();
    _homePageLoad();
  }

  Future<void> _homePageLoad() async {
    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? _token = prefs.getString('token');

      if (_token == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OnBoardingView()),
        );
        return;
      }

      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.profile(_token);

      String message = response.message;
      String error = response.error;
      dynamic data = response.data;

      if (error.isEmpty) {
        setState(() {
          username = data["firstName"];
        });
        if (data is Map<String, dynamic> &&
            data["address"] != null &&
            data["ZIP"] != null &&
            data["state"] != null &&
            data["city"] != null) {
          setState(() {
            isAddress = true;
          });
        } else {
          setState(() {
            isAddress = false;
          });
        }
      } else {
        SnackBar(content: Text(message));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginView(token: "token",)),
        );
      }
    } catch (e) {
      _showMessageDialog(
        e.toString(),
        () {
          Navigator.of(context).pop();
          _homePageLoad();
        },
        "Error",
        "Something went wrong",
        "Retry",
        Colors.red,
      );
    } finally {
      setState(() {
        _isLoading = false;
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
  ) {
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
        return DashboardView(noAddress: isAddress, name: username);
      case 1:
        return DashboardView(noAddress: isAddress, name: username);
      case 2:
        return DashboardView(noAddress: isAddress, name: username);
      case 3:
        return DashboardView(noAddress: isAddress, name: username);
      case 4:
        return const LogoutScreen();
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

