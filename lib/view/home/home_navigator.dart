import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youdoc/common/color_extention.dart';
import 'package:youdoc/common/loader_overlay.dart';
import 'package:youdoc/common_widget/auth/auth_dialogue.dart';
import 'package:youdoc/common_widget/messages/error_dialog.dart';
import 'package:youdoc/components/api_request.dart';
import 'package:youdoc/components/reusable_functions.dart';
import 'package:youdoc/view/dashboard/dashboard_view.dart';
import 'package:youdoc/view/login/login_view.dart';
import 'package:youdoc/view/message/message_view.dart';
import 'package:youdoc/view/login/logout_screen.dart';
import 'package:youdoc/view/on_boarding/on_boarding_view.dart';
import 'package:youdoc/view/payment/payment_view.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key, this.displayScreen});

  final int? displayScreen;

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
  int _selectedIndex = 0;
  bool _isLoading = false;
  bool isAddress = false;
  String username = "";
  String useremail = "";

  @override
  void initState() {
    super.initState();
    _homePageLoad();
  }

  Future<void> _homePageLoad() async {
    setState(() {
      _isLoading = true;
      _selectedIndex = widget.displayScreen ?? 0;
    });

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userSettings = await getUserSettings();
      if (userSettings == null) {
        showDialog(
          context: context,
          builder: (ctx) => const AuthDialogue(),
        );
      }

      String? token = prefs.getString("token");

      if (token == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OnBoardingView(),
          ),
        );
        return;
      }

      BaseRequest baseRequest = BaseRequest();
      var response = await baseRequest.profile();

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
            useremail = data['email'];
            // balance = double.parse(data['balance'].toString());
          });
        } else {
          setState(() {
            isAddress = false;
          });
        }
      } else {
        prefs.remove("token");
        _showMessageDialog(
          message,
          () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ),
              (route) => false,
            );
          },
          "Error",
          "Something went wrong",
          "Login",
          Colors.red,
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
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const LoginView(),
      //   ),
      //   (route) => false,
      // );
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
        return const LogoutScreen();
      case 3:
        return const MessageView();
      case 4:
        return const PaymentView();
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
