// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vixo/auth/setup/create_username.dart';
import 'package:vixo/theme/theme.dart';

class CreateEmailPage extends StatefulWidget {
  const CreateEmailPage({super.key});

  @override
  State<CreateEmailPage> createState() => _CreateEmailPageState();
}

class _CreateEmailPageState extends State<CreateEmailPage> {
  bool _isObscured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: kDefaultIconDarkColor, //change your color here
        ),
        title: Text(
          "",
          style: TextStyle(color: kPrimaryColor),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Get.to(() => ProvideAccountUsername());
          },
          child: Ink(
            width: double.infinity,
            height: 56.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(12.0),
              color: kDarkGreyColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Next",
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
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text("Your email?", style: titleText),
              ],
            ),
            Text(
              "Do not lose access to your account, please provide your personal email address,",
              style: subTitle,
            ),
            buildForm("email address", false),
          ],
        ),
      ),
    );
  }

  Widget buildForm(String label, bool pass) {
    return TextFormField(
      obscureText: pass ? _isObscured : false,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: kPrimaryColor,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kSecondaryColor2),
        ),
        suffixIcon: pass
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.check : Icons.cancel,
                  color: kPrimaryColor2,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
      ),
    );
  }
}
