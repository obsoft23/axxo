// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_import, avoid_print, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ios_willpop_transition_theme/ios_willpop_transition_theme.dart';
import 'package:vixo/auth/sign_up/phone/confirm_otp.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/controllers/auth_service.dart';

class SignUpPhoneNoPage extends StatefulWidget {
  const SignUpPhoneNoPage({super.key});

  @override
  State<SignUpPhoneNoPage> createState() => _SignUpPhoneNoPageState();
}

class _SignUpPhoneNoPageState extends State<SignUpPhoneNoPage> {
  TextEditingController _phoneContoller = TextEditingController();
  TextEditingController _otpContoller = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  String phoneNo = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    phoneNo = "";
    _phoneContoller.dispose();
    _otpContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Phone No."),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          child: Column(
            children: [
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: kAltTextColor),
                    children: [
                      TextSpan(text: "By continue to login, Please Provide "),
                      TextSpan(
                        text: 'Your Mobile No',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kAltDarkTextColor,
                          decoration: TextDecoration.underline,
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
                    labelText: '',
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
              InkWell(
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    print("button clicked");
                    AuthService.sentOtp(
                      phone: phoneNo,
                      errorStep: () => print("Error Sending OTP"),
                    );
                  }
                  /*  Navigator.of(context).push(
                    WillPopPageRoute(
                      builder: (_) =>  (),
                    ),
                  );*/
                },
                child: Ink(
                  width: double.infinity,
                  height: 56.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LOGIN",
                        style: TextStyle(
                          //color: kPrimaryColor,
                          fontSize: 19.0,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
