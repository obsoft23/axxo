// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vixo/components/responsive.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/screens/base_page.dart';
import 'package:vixo/theme/theme.dart';

class NotificationRequestPage extends StatefulWidget {
  const  NotificationRequestPage({super.key});

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
          onTap: () async {
            notificationController.requestNotificationPermission();
            /*  try {
              await firebaseMessaging.requestPermission();
            } catch (e) {
              if (kDebugMode) {
                print(e);
              }
            }*/
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
            SizedBox(
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.offAllNamed("home");
                  },
                  child: Text(
                    "Skip",
                    style: subTitle,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "TURN ON NOTIFICATIONS",
              style: titleText,
            ),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Never miss a message, never miss how your partner is feeling. Be up to date with tasks, notes and plans.",
                style: titleText2,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(
                'assets/images/heart.png',
                //height: getScreenPropotionHeight(350, size),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
