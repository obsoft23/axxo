// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.yellow,
          height: MediaQuery.of(context).size.height * 100,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: getScreenPropotionHeight(
                    orientation == Orientation.portrait ? 200 : 250, size),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/intro2.svg',
                    height: getScreenPropotionHeight(400, size),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
