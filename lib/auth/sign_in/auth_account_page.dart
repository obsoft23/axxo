// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vixo/components/auth_sign_in_button.dart';
import 'package:vixo/components/responsive.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Positioned(
                left: getScreenPropotionWidth(28, size),
                top: getScreenPropotionHeight(40, size),
                child: Text(
                  'SIGN  \nIN  \nEASY.',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFA5672),
                    fontFamily: "walto",
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: SvgPicture.asset(
                  'assets/icons/intro1.svg',
                  height: getScreenPropotionHeight(300, size),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 350,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  SignInButtonWidget(
                    buttonText: 'SIGN IN WITH PHONE NO',
                    buttonImage: Image.asset("assets/images/phone.png"),
                    url: AuthLoginPage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SignInButtonWidget(
                    buttonText: 'SIGN IN WITH APPLE',
                    buttonImage: Image.asset("assets/images/apple.png"),
                    url: AuthLoginPage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SignInButtonWidget(
                    buttonText: 'SIGN IN WITH GOOGLE',
                    buttonImage: Image.asset("assets/images/google.png"),
                    url: AuthLoginPage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SignInButtonWidget(
                    buttonText: 'SIGN IN WITH FACEBOOK',
                    buttonImage: Image.asset("assets/images/facebook.png"),
                    url: AuthLoginPage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight, // Start direction
              end: Alignment.bottomRight, // End direction
              colors: [
                Colors.red, // Start Color
                Colors.pink, // End Color
              ], // Customize your colors here
            ), */