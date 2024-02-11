// ignore_for_file: unused_import, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, unused_local_variable, must_be_immutable

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';
import 'package:vixo/auth/setup/create_email.dart';
import 'package:vixo/components/custom_button.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/controllers/auth_controller.dart';
import 'package:vixo/screens/home.dart';
import 'package:vixo/theme/theme.dart';

class ConfirmOTPPage extends StatefulWidget {
  ConfirmOTPPage({
    super.key,
    required this.otpverficationId,
    required this.smsCode,
    required this.phoneNo,
  });

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

  //final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pinController.delete();
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kDefaultIconDarkColor, //change your color here
        ),
        title: Text(
          "Confirm Token",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      body: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 1,
            child: Column(
              children: [
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(color: kAltTextColor),
                      children: [
                        TextSpan(text: "Please enter SMS Token :  "),
                        TextSpan(
                          text: widget.phoneNo.replaceRange(3, 10, "*****"),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kAltDarkTextColor,
                              fontSize: 14,
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
                          pinputAutovalidateMode:
                              PinputAutovalidateMode.onSubmit,
                          autofocus: true,
                          showCursor: true,
                          keyboardType: TextInputType.phone,
                          focusNode: focusNode,
                          androidSmsAutofillMethod:
                              AndroidSmsAutofillMethod.smsUserConsentApi,
                          listenForMultipleSmsOnAndroid: true,
                          separatorBuilder: (index) => SizedBox(width: 4),
                          validator: (value) {
                            return value == widget.smsCode
                                ? 'correct'
                                : 'incorrect';
                          },
                          hapticFeedbackType: HapticFeedbackType.lightImpact,
                          onCompleted: (pin) async {
                            if (pin == widget.smsCode) {
                              nextPage();
                              /* authController.phoneSignIn(
                                  widget.otpverficationId,
                                  widget.smsCode,
                                  widget.phoneNo);*/
                            } else {
                              bool resendTokenEnabled = true;
                              setState(() {});
                              return;
                            }
                          },
                          onChanged: (value) {},
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
                      resendTokenEnabled
                          ? Container()
                          : Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Didn't recieve any code ?",
                                  style: subTitle,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          focusNode.unfocus();
                                          if (formKey.currentState!
                                              .validate()) {
                                            //    authController.phoneVerify(widget.phoneNo);
                                            return;
                                          } else {
                                            resendToken();
                                            return;
                                          }
                                        },
                                        child: Ink(
                                          child: Text(
                                            'Resend Token',
                                            style: TextStyle(
                                              color: kDefaultIconDarkColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  nextPage() async {
    /* Get.to(
      () => CreateEmailPage(
        otpverficationId: widget.otpverficationId,
        smsCode: widget.smsCode,
        phoneNo: widget.phoneNo,
      ),
    );*/

    /*authController.createNewUser(
        widget.otpverficationId, widget.smsCode, widget.phoneNo);*/

    return;
  }

  resendToken() async {
    // return authController.phoneVerify(widget.phoneNo);
  }
}
