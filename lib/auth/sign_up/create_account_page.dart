// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vixo/auth/sign_up/phone/auth_phone_no_page.dart';
import 'package:vixo/components/auth_sign_in_button.dart';
import 'package:vixo/components/responsive.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  @override
  Widget build(BuildContext context) {
    final Image iconImage;
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
                  'SIGN  \nUP  \nEASY.',
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
                  'assets/icons/intro2.svg',
                  height: getScreenPropotionHeight(150, size),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 350,
                  ),
                  SignInButtonWidget(
                    buttonText: 'SIGN UP WITH PHONE NO',
                    buttonImage: Image.asset("assets/images/phone.png"),
                    url: SignUpPhoneNoPage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SignInButtonWidget(
                    buttonText: 'SIGN UP WITH APPLE',
                    buttonImage: Image.asset("assets/images/apple.png"),
                    url: CreateUserPage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SignInButtonWidget(
                    buttonText: 'SIGN UP WITH GOOGLE',
                    buttonImage: Image.asset("assets/images/google.png"),
                    url: CreateUserPage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SignInButtonWidget(
                    buttonText: 'SIGN UP WITH FACEBOOK',
                    buttonImage: Image.asset("assets/images/facebook.png"),
                    url: CreateUserPage(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 40,
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
