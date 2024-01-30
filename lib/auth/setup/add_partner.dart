// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vixo/intro_screen/app_location_permission_page.dart';

import '../../theme/theme.dart';

class AddPartnerPage extends StatefulWidget {
  const AddPartnerPage({super.key});

  @override
  State<AddPartnerPage> createState() => _AddPartnerPageState();
}

class _AddPartnerPageState extends State<AddPartnerPage> {
  bool _isObscured = false;

  bool _isTextFieldFilled = false;
  TextEditingController _addPartnerControllerText = TextEditingController();

  @override
  void initState() {
    _addPartnerControllerText.addListener(_checkTextField);
    super.initState();
  }

  @override
  void dispose() {
    _addPartnerControllerText.dispose();
    super.dispose();
  }

  void _checkTextField() {
    if (_addPartnerControllerText.text.isNotEmpty) {
      setState(() {
        _isTextFieldFilled = true;
      });
    } else {
      setState(() {
        _isTextFieldFilled = false;
      });
    }
  }

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
            Get.to(() => LocationPermissionRequestPage());
          },
          child: Ink(
            width: double.infinity,
            height: 56.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(12.0),
              color: _isTextFieldFilled ? kPrimaryColor2 : kDarkGreyColor,
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
                Text("Add your partner", style: titleText),
              ],
            ),
            Text(
              "search and add your partner with their custom username",
              style: subTitle,
            ),
            buildForm("search username", false),
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
