// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, avoid_print, prefer_final_fields, unused_field, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ios_willpop_transition_theme/ios_willpop_transition_theme.dart';
import 'package:pinput/pinput.dart';
import 'package:simple_snackbar/simple_snackbar.dart';
import 'package:toastification/toastification.dart';
import 'package:vixo/auth/sign_in/sign_in.dart';
import 'package:vixo/auth/sign_up/phone/confirm_otp.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/controllers/auth_service.dart';
import 'package:vixo/theme/theme.dart';

class SignUpPhoneNoPage extends StatefulWidget {
  SignUpPhoneNoPage({super.key, required this.title});
  String title = "";

  @override
  State<SignUpPhoneNoPage> createState() => _SignUpPhoneNoPageState();
}

class _SignUpPhoneNoPageState extends State<SignUpPhoneNoPage> {
  TextEditingController _phoneContoller = TextEditingController();
  TextEditingController _otpContoller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  String phoneNo = "";
  bool _isTextFieldFilled = false;

  @override
  void initState() {
    _phoneContoller.addListener(_checkTextField);
    super.initState();
  }

  @override
  void dispose() {
    phoneNo = "";
    _phoneContoller.dispose();
    _otpContoller.dispose();
    super.dispose();
  }

  void _checkTextField() {
    final String enteredText = _phoneContoller.text;
    final bool isValid = RegExp(r'^[0-9]{10}$').hasMatch(enteredText);

    setState(() {
      _isTextFieldFilled = isValid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kDefaultIconDarkColor, //change your color here
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              if (_formkey.currentState!.validate()) {
                _isTextFieldFilled
                    ? authController.phoneVerify(phoneNo)
                    : toastification.show(
                        type: ToastificationType.warning,
                        style: ToastificationStyle.flat,
                        alignment: Alignment.centerLeft,
                        backgroundColor: Colors.yellow,
                        applyBlurEffect: true,
                        context: context,
                        title: Text('Please Enter Valid Phone No'),
                        autoCloseDuration: const Duration(seconds: 3),
                      );
              } else {
                toastification.show(
                  type: ToastificationType.warning,
                  style: ToastificationStyle.flat,
                  alignment: Alignment.centerLeft,
                  backgroundColor: Colors.yellow,
                  applyBlurEffect: true,
                  context: context,
                  title: Text('Please Enter Valid Phone No'),
                  autoCloseDuration: const Duration(seconds: 3),
                );
              }
            },
            child: Ink(
              width: double.infinity,
              height: 56.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                color: _isTextFieldFilled ? kPrimaryColor2 : kDarkGreyColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Send OTP",
                    style: TextStyle(
                      color: kDefaultIconDarkColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          child: Column(
            children: [
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: kAltTextColor),
                    children: [
                      TextSpan(text: "Please provide a "),
                      TextSpan(
                        text: 'valid Mobile No',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kAltDarkTextColor,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formkey,
                child: IntlPhoneField(
                  controller: _phoneContoller,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    ),
                    labelText: '...',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  initialCountryCode: 'GB',
                  onChanged: (phone) {
                    // print(phone.completeNumber);

                    phoneNo = phone.completeNumber;
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
