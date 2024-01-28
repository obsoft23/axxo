// ignore_for_file: unused_import, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unused_local_variable, must_be_immutable

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';
import 'package:vixo/components/custom_button.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/screens/home.dart';

class ConfirmOTPPage extends StatefulWidget {
  ConfirmOTPPage(
      {super.key, required this.otpverficationId, required this.smsCode});

  String phoneNo = "";
  String otpverficationId = "";
  String smsCode = "";

  @override
  State<ConfirmOTPPage> createState() => _ConfirmOTPPageState();
}

class _ConfirmOTPPageState extends State<ConfirmOTPPage> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  bool resendTokenEnabled = false;
  bool showNextButton = false;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(milliseconds: 30000), () {
      setState(() {
        bool resendTokenEnabled = false;
      });
    });

    return Scaffold(
      appBar: AppBar(),
      body: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: kAltTextColor),
                  children: [
                    TextSpan(text: "Enter OTP For Your No:  "),
                    TextSpan(
                      //  text: "".replaceRange(3, 8, "*****"),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kAltDarkTextColor,
                          fontSize: 18,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 6,
                      autofocus: true,
                      keyboardType: TextInputType.phone,
                      focusNode: focusNode,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      listenForMultipleSmsOnAndroid: true,
                      separatorBuilder: (index) => SizedBox(width: 4),
                      validator: (value) {
                        return value == widget.smsCode ? '' : 'OTP incorrect';
                      },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 10,
                            height: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(),
                  ),
                  resendTokenEnabled
                      ? Row(
                          children: [
                            TextButton(
                              onPressed: () async {
                                focusNode.unfocus();
                                if (formKey.currentState!.validate()) {
                                  return;
                                } else {
                                  resendToken();
                                  return;
                                }
                              },
                              child: Text(
                                'Resend Token',
                                style: TextStyle(color: kDefaultIconDarkColor),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  nextPage() async {
    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: widget.otpverficationId,
      smsCode: widget.smsCode,
    );

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.to(HomePage());
    return "";
  }

  void resendToken() {
    print("to resend Token");
  }
}
