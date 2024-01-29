// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:vixo/screens/login/login_screen.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Introduction> list = [
      Introduction(
        title: 'Limit the Distance',
        subTitle: 'Browse the menu and order directly from the application',
        imageUrl: 'assets/images/onboarding3.png',
      ),
      Introduction(
        title: 'Share your Experience',
        subTitle: 'Your order will be immediately collected and',
        imageUrl: 'assets/images/onboarding2.png',
      ),
      Introduction(
        title: 'Immediate Touch',
        subTitle: 'Pick up delivery at your door and enjoy groceries',
        imageUrl: 'assets/images/onboarding1.png',
      ),
    ];
    return IntroScreenOnboarding(
      introductionList: list,

      // backgroudColor: kDefaultIconDarkColor,
      foregroundColor: Color.fromARGB(255, 51, 51, 32),
      onTapSkipButton: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      ),
      skipTextStyle: const TextStyle(color: Colors.blueGrey, fontSize: 18),
    );
  }
}
