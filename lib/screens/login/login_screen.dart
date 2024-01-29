// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:vixo/auth/sign_in/sign_in.dart';
import 'package:vixo/auth/sign_up/phone/sign_up.dart';
import 'package:vixo/components/custom_button.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ios_willpop_transition_theme/ios_willpop_transition_theme.dart';
import 'package:vixo/theme/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
            /* Text(
              'JuSTUZ',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(255, 156, 145, 43),
                fontFamily: "walto",
              ),
            ),*/
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CreateAccountButton(),
                  SizedBox(height: 20),
                  CustomerAppButton(
                    title: 'Sign In',
                    url: SignInPage(title: "Login to your account"),
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

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        /* Navigator.of(context).push(
          WillPopPageRoute(
            builder: (_) => const CreateUserPage(),
          ),
        );*/
        Navigator.of(context).push(
          WillPopPageRoute(
            builder: (_) => SignUpPhoneNoPage(
              title: "Create Account",
            ),
          ),
        );
      },
      child: Ink(
        width: double.infinity,
        height: 56.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Account",
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
