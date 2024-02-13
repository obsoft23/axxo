// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    profileController.checkIfHasPartner();
    profileController.checkIFPartnerApproved();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                authController.logout();
              },
              child: Text("LOGOUT"),
            ),
            SizedBox(
              width: 24,
              height: 23,
              child: Image.asset("assets/images/loading.gif"),
            ),
          ],
        ),
      ),
    );
  }
}
