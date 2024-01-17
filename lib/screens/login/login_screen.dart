// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:vixo/auth/sign_in/auth_account_page.dart';
import 'package:vixo/auth/sign_up/create_account_page.dart';
import 'package:vixo/components/custom_button.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/components/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ios_willpop_transition_theme/ios_willpop_transition_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            height: getScreenPropotionHeight(
                orientation == Orientation.portrait ? 390 : 450, size),
            child: Stack(
              children: [
                Positioned(
                    left: getScreenPropotionWidth(64, size),
                    top: getScreenPropotionHeight(90, size),
                    child: Image.asset(
                      'assets/images/heart.png',
                      width: getScreenPropotionHeight(67, size),
                    )),
                Positioned(
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/images/couple.svg',
                    height: getScreenPropotionHeight(390, size),
                  ),
                ),
                Positioned(
                    left: getScreenPropotionWidth(28, size),
                    top: getScreenPropotionHeight(190, size),
                    child: Text(
                      'Keep In  \nTouch  \nAlways.',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        fontFamily: "walto",
                        color: Color.fromARGB(255, 214, 123, 123),
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(height: 150),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CreateAccountButton(),
                SizedBox(height: 20),
                CustomerAppButton(
                  title: 'SIGN IN',
                  url: AuthLoginPage(),
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
        ]),
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
    return TouchableOpacity(
      activeOpacity: 0.8,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            WillPopPageRoute(
              builder: (_) => const CreateUserPage(),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 56.0,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(12.0),
          ),
          alignment: Alignment.center,
          child: Text(
            "CREATE ACCOUNT",
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
