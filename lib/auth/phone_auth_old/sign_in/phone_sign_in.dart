// ignore_for_file: must_be_immutable, unused_field, prefer_final_fields, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pinput/pinput.dart';
import 'package:toastification/toastification.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/controllers/auth_controller.dart';
import 'package:vixo/controllers/auth_service.dart';
import 'package:vixo/theme/theme.dart';

class SignInPage extends StatefulWidget {
  SignInPage({super.key, this.title});
  // ignore: prefer_typing_uninitialized_variables
  var title;
  bool isValidPhone = false;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _phoneContoller = TextEditingController();
  TextEditingController _otpContoller = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();
  String phoneNo = "";

  bool _isTextFieldFilled = false;

  @override
  void initState() {
    super.initState();
    _phoneContoller.addListener(_checkTextField);
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
      floatingActionButton: SignInButton(
          formkey: _formkey,
          isTextFieldFilled: _isTextFieldFilled,
          authController: authController,
          phoneNo: phoneNo),
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
                      TextSpan(text: "Please provide your "),
                      TextSpan(
                        text: 'registered Mobile No',
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

class SignInButton extends StatelessWidget {
  const SignInButton({
    super.key,
    required GlobalKey<FormState> formkey,
    required bool isTextFieldFilled,
    required this.authController,
    required this.phoneNo,
  })  : _formkey = formkey,
        _isTextFieldFilled = isTextFieldFilled;

  final GlobalKey<FormState> _formkey;
  final bool _isTextFieldFilled;
  final AuthController authController;
  final String phoneNo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (_formkey.currentState!.validate()) {
            _isTextFieldFilled
                ? // authController.phoneVerify(phoneNo)
                null
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
      ),
    );
  }
}

class SendOTPButton extends StatelessWidget {
  SendOTPButton({
    super.key,
    required GlobalKey<FormState> formkey,
    required this.phoneNo,
  }) : _formkey = formkey;

  final GlobalKey<FormState> _formkey;
  final String phoneNo;
  bool isValid = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_formkey.currentState!.validate()) {
          AuthService.sentOtp(
            phone: phoneNo,
            errorStep: () => print("Error Sending OTP"),
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
          color: kDarkGreyColor,
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
    );
  }
}
