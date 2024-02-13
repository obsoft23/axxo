// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vixo/components/responsive.dart';
import 'package:vixo/screens/home.dart';
import 'package:vixo/theme/theme.dart';

class NotificationRequestPage extends StatefulWidget {
  const NotificationRequestPage({super.key});

  @override
  State<NotificationRequestPage> createState() =>
      _NotificationRequestPageState();
}

class _NotificationRequestPageState extends State<NotificationRequestPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Get.to(() => HomePage());
          },
          child: Ink(
            width: double.infinity,
            height: 56.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(12.0),
              color: kPrimaryColor2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Allow",
                  style: TextStyle(
                    color: kDefaultIconDarkColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Spacer(),
            Text(
              "TURN ON NOTIFICATIONS",
              style: titleText,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Never miss a message, never miss how your partner is feeling. ",
                style: subTitle,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                height: getScreenPropotionHeight(
                    orientation == Orientation.portrait ? 250 : 450, size),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/couple2.svg',
                    height: getScreenPropotionHeight(350, size),
                  ),
                ),
              ),
            ),
            SizedBox(height: 250)
          ],
        ),
      ),
    );
  }
}
