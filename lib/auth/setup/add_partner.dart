// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/screens/home.dart';

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
  final _formkey = GlobalKey<FormState>();

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
        title: Column(
          children: [
            Text(
              "Add Partner",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            Text("Step 3/3", style: subTitle4)
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // Show alert dialog when back button is pressed
            String pageInfo = "set up";
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
              profileController.searchPartner(
                  _addPartnerControllerText.text, context);
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
                  "Continue",
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  "Search and add your partner with their custom username",
                  style: subTitle,
                ),
              ),
            ),
            Form(
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
                        labelText: 'Searching for parner ...',
                        hintText: 'Enter your partner username',
                        border: OutlineInputBorder(
                          //border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    _isUsernameFound
                        ? Text(
                            'Username found',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          )
                        : Text(
                            'Username not found',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildForm(String label, bool pass) {
    return TextFormField(
      controller: _addPartnerControllerText,
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

_showExitConfirmationDialog(BuildContext context, String pageInfo) async {
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
      Get.offAll(() => HomePage());
    },
    panaraDialogType: PanaraDialogType.error,
  );
}
