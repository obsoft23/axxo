// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, unused_field, must_be_immutable, prefer_typing_uninitialized_variables, unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:vixo/auth/user_account_setup/create_username.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/screens/login/login_screen.dart';
import 'package:vixo/theme/theme.dart';

class CreateEmailPage extends StatefulWidget {
  CreateEmailPage(
      {super.key, this.otpverficationId, this.smsCode, this.phoneNo});

  var phoneNo;
  var otpverficationId;
  var smsCode;

  @override
  State<CreateEmailPage> createState() => _CreateEmailPageState();
}

class _CreateEmailPageState extends State<CreateEmailPage> {
  bool _isObscured = false;

  bool _isTextFieldFilled = false;
  TextEditingController _emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController.addListener(_checkTextField);
    //authController.checkIfHasEmail();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _checkTextField() {
    final String enteredText = _emailController.text.trim();
    final bool isValid =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(enteredText);

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
          "Your email?",
          style: TextStyle(color: kPrimaryColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // Show alert dialog when back button is pressed
            String pageInfo = "sign up";
            _showExitConfirmationDialog(context, pageInfo);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (_formkey.currentState!.validate()) {
              profileController.updateUserEmail(_emailController.text, context);
            }
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
            SizedBox(
              width: 10,
            ),
            Text(
              "Do not lose access to your account, please provide your personal email address,",
              style: subTitle,
            ),
            Form(key: _formkey, child: buildForm("email address", false)),
          ],
        ),
      ),
    );
  }

  Widget buildForm(String label, bool pass) {
    return TextFormField(
      controller: _emailController,
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

Future<void> _showExitConfirmationDialog(BuildContext context, pageInfo) async {
  return PanaraConfirmDialog.showAnimatedGrow(
    context,
    title: "Are you sure?",
    message: "You will exit $pageInfo process and your info will be deleted.",
    confirmButtonText: "Confirm",
    cancelButtonText: "Cancel",
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      //Navigator.pop(context);
      authController.logout();
      Get.offAll(() => LoginScreen());
    },
    panaraDialogType: PanaraDialogType.error,
  );
}
