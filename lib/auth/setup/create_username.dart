// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vixo/auth/setup/add_partner.dart';
import 'package:vixo/theme/theme.dart';

class ProvideAccountUsername extends StatefulWidget {
  const ProvideAccountUsername({super.key});

  @override
  State<ProvideAccountUsername> createState() => _ProvideAccountUsernameState();
}

class _ProvideAccountUsernameState extends State<ProvideAccountUsername> {
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
      floatingActionButton: UsernameNextButton(),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text("Create your username", style: titleText),
            ],
          ),
          Text(
            "Your partner can add you up with this username ..",
            style: subTitle,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildForm("username", false),
          ),
        ],
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

class UsernameNextButton extends StatelessWidget {
  const UsernameNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.to(() => AddPartnerPage());
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
    );
  }
}
