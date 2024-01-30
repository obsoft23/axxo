// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:vixo/components/custom_button.dart';
import 'package:vixo/components/responsive.dart';
import 'package:vixo/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:vixo/theme/theme.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding * 2),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/welcome.png',
                      width: getScreenPropotionHeight(365, size),
                    )),
                Text(
                  "Let's get closer",
                  style: TextStyle(color: kLightTextColor, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  "The best place to\nkeep in Touch with your partner.",
                  style: TextStyle(
                      color: kTextColor,
                      fontSize: 39.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CustomerAppButton(
                  title: 'Get Started',
                  url: LoginScreen(),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
