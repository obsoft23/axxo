// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/screens/login/login_screen.dart';
import 'package:vixo/theme/theme.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isObscured = false;
  bool _isTextFieldFilled = false;
  TextEditingController _usernameController = TextEditingController();
  //AuthController _authController = Get.find();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _usernameController.addListener(_checkTextField);
    //authController.checkIfHasUsername();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _checkTextField() {
    if (_usernameController.text.length > 2) {
      setState(() {
        _isTextFieldFilled = true;
      });
    } else {
      setState(() {
        _isTextFieldFilled = false;
      });
    }
  }

  String _searchText = '';
  bool _isUsernameFound = false;

  void _searchUsername(String value) {
    // Simulate searching username
    if (value == 'username') {
      setState(() {
        _isUsernameFound = true;
      });
    } else {
      setState(() {
        _isUsernameFound = false;
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
        centerTitle: true,
        title: Text(
          "Forgot Password",
          style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            // Get.to(() => AddPartnerPage());
            //authController.createUserName(context, _usernameController.text);
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
                  "Send Reset Link",
                  style: TextStyle(
                    color: kDefaultIconDarkColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Provide your registered email to reset your password..",
              style: subTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                        _searchUsername(value);
                      },
                      decoration: InputDecoration(
                        labelText: 'Please provide email',
                        hintText: 'Enter Email ',
                        border: OutlineInputBorder(
                          //border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm(String label, bool pass) {
    return TextFormField(
      controller: _usernameController,
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

Future<void> _showExitConfirmationDialog(
    BuildContext context, String pageInfo) async {
  return PanaraConfirmDialog.showAnimatedGrow(
    context,
    title: "Are you sure?",
    message: "Exitiing your account creating process will log you out.",
    confirmButtonText: "Confirm",
    cancelButtonText: "Cancel",
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      Navigator.pop(context);
      authController.logout();
      Get.offAll(() => LoginScreen());
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}
