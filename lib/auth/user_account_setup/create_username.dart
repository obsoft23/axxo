// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, unused_field, unused_element, avoid_print

import 'package:flutter/material.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:vixo/theme/constants.dart';
import 'package:vixo/theme/theme.dart';

class ProvideAccountUsername extends StatefulWidget {
  const ProvideAccountUsername({super.key});

  @override
  State<ProvideAccountUsername> createState() => _ProvideAccountUsernameState();
}

class _ProvideAccountUsernameState extends State<ProvideAccountUsername> {
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
    /*if (_usernameController.text.length > 2) {
      setState(() {
        _isTextFieldFilled = true;
      });
    } else {
      setState(() {
        _isTextFieldFilled = false;
      });
    }*/
  }

  String _searchText = ''.trim();
  bool _isUsernameFound = false;
  bool _isLoading = false;
  String _text = "";

  void _searchUsername(String value) async {
    // Simulate searching username
    setState(() {
      _isLoading = true;
    });

    var status = await profileController.checkIfHasUsername(value);
    if (status == true) {
      print("username available");
      setState(() {
        _isUsernameFound = true;
        _isTextFieldFilled = true;
        _isLoading = false;
      });
    } else {
      print("username  not available");
      _text = "username not available";
      setState(() {
        _isUsernameFound = false;
        _isLoading = false;
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
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Choose Username",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            Text("Step 2/3", style: subTitle4)
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            // Show alert dialog when back button is pressed
            String pageInfo = "username";
            _showExitConfirmationDialog(context, pageInfo);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            // Get.to(() => AddPartnerPage());
            if (_formkey.currentState!.validate()) {
              await profileController.createUserName(
                  context, _usernameController.text);
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Create your username, your intending partner will add you up with this username ..",
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
                    TextFormField(
                      controller: _usernameController,
                      onChanged: (value) {
                        setState(() {
                          _searchText = value;
                        });
                        _searchUsername(_usernameController.text.trim());
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Pick your username',
                        hintText: 'Choose username',
                        border: OutlineInputBorder(
                          //border: Border.all(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isUsernameFound
                            ? Text(
                                'Username  available',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              )
                            : Text(
                                _text,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                ),
                              ),
                        SizedBox(width: 10),
                        _isLoading
                            ? SizedBox(
                                width: 22,
                                height: 22,
                                child: Image.asset("assets/images/loading.gif"),
                              )
                            : Container(),
                      ],
                    )
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
  return PanaraConfirmDialog.showAnimatedFromTop(
    context,
    noImage: true,
    message: "Exitiing your account creating process will log you out.",
    confirmButtonText: "Confirm",
    cancelButtonText: "Cancel",
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      Navigator.pop(context);
      authController.logout();
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}
