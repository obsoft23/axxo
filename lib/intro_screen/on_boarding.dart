// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vixo/view/login/login_screen.dart';

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
        title: 'Get Started',
        subTitle: 'Enjoy the features of this app.',
        imageUrl: 'assets/images/onboarding1.png',
      ),
    ];
    return IntroScreenOnboarding(
      introductionList: list,
      foregroundColor: Color.fromARGB(255, 51, 51, 32),
      onTapSkipButton: () async {
        // Obtain shared preferences.
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final shownOnboarding = await prefs.setBool('first_time', true);
        Get.offAll(() => LoginScreen());
      },
      skipTextStyle: const TextStyle(color: Colors.blueGrey, fontSize: 18),
    );
  }
}
