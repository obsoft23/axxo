// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vixo/constants.dart';

class AppHomeBasePage extends StatefulWidget {
  const AppHomeBasePage({super.key});

  @override
  State<AppHomeBasePage> createState() => _AppHomeBasePageState();
}

class _AppHomeBasePageState extends State<AppHomeBasePage> {
  @override
  void initState() {
    profileController.checkIfHasPartner();
    super.initState();
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
