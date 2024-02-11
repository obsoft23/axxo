// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartnerConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Partner Confirmation'),
      ),
      body: PartnerConfirmationContent(),
    );
  }
}

class PartnerConfirmationContent extends StatefulWidget {
  @override
  _PartnerConfirmationContentState createState() =>
      _PartnerConfirmationContentState();
}

class _PartnerConfirmationContentState
    extends State<PartnerConfirmationContent> {
  final RxBool _isConfirmed = false.obs;

  // Simulate a delay and then set the confirmation flag to true
  void _simulateConfirmation() async {
    await Future.delayed(Duration(seconds: 3));
    _isConfirmed.value = true;
  }

  @override
  void initState() {
    super.initState();
    // Start simulating the confirmation
    _simulateConfirmation();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Stack(
          children: [
            // Main content
            Center(
              child: _isConfirmed.value
                  ? Text('Partner confirmed the add request.')
                  : CircularProgressIndicator(),
            ),
            // Optionally, you can add a transparent overlay to prevent interaction
            if (!_isConfirmed.value)
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
          ],
        );
      },
    );
  }
}
