import 'package:flutter/material.dart';
import 'package:youdoc/common/Color_extention.dart';
import 'package:youdoc/common/anchor_click.dart';
import 'package:youdoc/common/custom_button.dart';
import 'package:youdoc/view/login/login_view.dart';
import 'package:youdoc/view/register/register_view.dart';

class OnBoardingView extends StatelessWidget {
  OnBoardingView({super.key});

  final gradient = LinearGradient(colors: [
    TColor.textGrad,
    TColor.primary
  ]);

  final textStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    decoration: TextDecoration.underline,
    decorationColor: Colors.white,
    decorationThickness: 2,
    letterSpacing: 0.3,
    decorationStyle: TextDecorationStyle.solid,
  );

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    const data = 'Lorem ipsum for the header';

    return Scaffold(
      backgroundColor: TColor.primaryBg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo-y.png',
                      width: media.width * 0.1,
                      fit: BoxFit.fill,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 90.0),
                      child: Text(
                        data,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 32.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 70.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: CustomButton(
                        title: 'Create an account',
                        onpress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterView()));
                        },
                        // fontSize: 20,
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) {
                        return gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                      },
                      child: CustomAnchor(
                        text: 'I already have an account',
                        textStyle: textStyle,
                        clicked: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginView(token: "confirm",)));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
