// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vixo/components/responsive.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/intro_screen/app_turn_on_notifications_page.dart';
import 'package:vixo/screens/home.dart';
import 'package:vixo/theme/theme.dart';

class LocationPermissionRequestPage extends StatefulWidget {
  const LocationPermissionRequestPage({super.key});

  @override
  State<LocationPermissionRequestPage> createState() =>
      _LocationPermissionRequestPageState();
}

class _LocationPermissionRequestPageState
    extends State<LocationPermissionRequestPage> {
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
            authController.logout();
            // Get.to(() => NotificationRequestPage());
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
              "TURN ON LOCATION",
              style: titleText,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Never worry about your partner whereabouts, keep in touch easy. ",
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
                  child: Image.asset(
                    'assets/images/location1.gif',
                    // height: getScreenPropotionHeight(350, size),
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
