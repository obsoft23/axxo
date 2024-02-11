// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:vixo/auth/sign_up.dart';
import 'package:vixo/auth/sign_in.dart';
import 'package:vixo/components/custom_button.dart';
import 'package:vixo/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vixo/theme/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            SizedBox(
              width: double.infinity,
              height: getScreenPropotionHeight(
                  orientation == Orientation.portrait ? 390 : 450, size),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/couple.svg',
                  height: getScreenPropotionHeight(350, size),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CustomerAppButton(
                    title: 'Create Account',
                    url: CreateAccountPage(),
                    color: Colors.white,
                    colorTitle: kPrimaryColor,
                  ),
                  SizedBox(height: 20),
                  CustomerAppButton(
                    title: 'Login',
                    url: LoginPage(),
                    color: Colors.yellow,
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: kAltTextColor),
                        children: [
                          TextSpan(
                              text:
                                  "By continue to login, you accept our company’s "),
                          TextSpan(
                            text: 'Term & conditions',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kAltDarkTextColor,
                                decoration: TextDecoration.underline),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy policies.',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kAltDarkTextColor,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
