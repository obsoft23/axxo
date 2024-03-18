// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, unused_field, unused_element, unused_import, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/screens/home.dart';
import 'package:vixo/theme/theme.dart';

class PartnerConfirmationPage extends StatefulWidget {
  @override
  State<PartnerConfirmationPage> createState() =>
      _PartnerConfirmationPageState();
}

class _PartnerConfirmationPageState extends State<PartnerConfirmationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    profileController.fetchPartnerRequest();
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.repeat(reverse: true);

    Future.delayed(Duration(seconds: 18), () {
      setState(() {
        _isLoading = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                "Partner Confirmation",
                style: TextStyle(
                    color: kPrimaryColor, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Waiting for partner approval ... ", style: subTitle4),
                  SizedBox(
                    width: 12,
                    height: 12,
                    child: Image.asset("assets/images/loading.gif"),
                  ),
                ],
              )
            ],
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () async {
              // Show alert dialog when back button is pressed
              String pageInfo = "set up";
              await _showExitConfirmationDialog(context, pageInfo);
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 38,
              ),
              Opacity(
                opacity: _animation.value,
                child: SizedBox(
                  child: Image.asset("assets/images/please_wait.gif"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isLoading
                      ? Text("Waiting for partners approval 😮‍💨 ",
                          style: subTitle5)
                      : Text("Waiting for partners approval 🥹",
                          style: subTitle2),
                  SizedBox(width: 8),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset("assets/images/loading_dots.gif"),
              ),
              SizedBox(height: 8),
              !_isLoading
                  ? Container()
                  : Text(
                      'Taking so long ?', // Show the text after loading
                      style: TextStyle(fontSize: 14),
                    ),
            ],
          ),
        ));
  }
}

_showExitConfirmationDialog(BuildContext context, String pageInfo) async {
  return PanaraConfirmDialog.showAnimatedGrow(
    noImage: true,
    context,
    message: "You will exit $pageInfo process and you will be logged out.",
    confirmButtonText: "Confirm",
    cancelButtonText: "Cancel",
    textColor: kDefaultIconDarkColor,
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      //Navigator.pop(context);
      authController.logout();
    },
    panaraDialogType: PanaraDialogType.warning,
  );
}

class PartnerConfirmationContent extends StatefulWidget {
  @override
  _PartnerConfirmationContentState createState() =>
      _PartnerConfirmationContentState();
}

class _PartnerConfirmationContentState
    extends State<PartnerConfirmationContent> {
  int _currentIndex = 0;
  final List<String> _gifUrls = [
    "assets/images/please_wait.gif",
    // "assets/images/hand_waiting.gif"
    "assets/images/please_wait.gif",
  ];

  Future<void> _loadGifs() async {
    for (int i = 0; i < _gifUrls.length && i < 2; i++) {
      await Future.delayed(Duration(seconds: 3));
      setState(() {
        _currentIndex = i;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _loadGifs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        Center(
          child: _currentIndex < _gifUrls.length
              ? Image.asset(_gifUrls[_currentIndex])
              : Text(''),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Waiting for partners approval", style: subTitle2),
            SizedBox(width: 8),
            SizedBox(
              width: 20,
              height: 20,
              child: Image.asset("assets/images/loading_dots.gif"),
            ),
          ],
        ),
        SizedBox(height: 20),
        SizedBox(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }
}
