// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:vixo/components/socials_button.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/theme/theme.dart';

class RejectPartnerRequestPage extends StatefulWidget {
  RejectPartnerRequestPage({super.key, required this.rejector});

  var rejector = false;
  @override
  State<RejectPartnerRequestPage> createState() =>
      _RejectPartnerRequestPageState();
}

class _RejectPartnerRequestPageState extends State<RejectPartnerRequestPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    profileController.fetchPartnerRequest();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.repeat(reverse: true);
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
                " Partner Request Rejected ",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("To continue, reset status  ", style: subTitle4),
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
        body: Obx(
          () {
            var snapshot = profileController.partnerRequest.value;
            if (snapshot == null) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.exists) {
              return Center(child: Text('No data found'));
            } else {
              var userData = snapshot.data();
              return Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    ScaleTransition(
                      scale: _animation,
                      child: Icon(
                        Icons.cancel,
                        size: 100.0,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Sadly,',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    !widget.rejector
                        ? Text(
                            'Your partner request has been rejected by you.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          )
                        : Text(
                            'Your partner request has been rejected by them.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                    SizedBox(height: 25),
                    SocialButton(
                      text: "Reset ",
                      textColor: kDefaultIconDarkColor,
                      color: Colors.yellow,
                      onTap: () async {
                        //
                        await profileController
                            .resetPartnerStatus(userData?['uid']);
                      },
                      icon: Icon(Icons.restore, color: Colors.black),
                    ),
                  ],
                ),
              );
            }
          },
        ));
  }
}

_showExitConfirmationDialog(BuildContext context, String pageInfo) {
  return PanaraConfirmDialog.showAnimatedGrow(
    context,
    title: "Are you sure?",
    message: "You will exit $pageInfo process and you will be logged out.",
    confirmButtonText: "Confirm",
    cancelButtonText: "Cancel",
    onTapCancel: () {
      Navigator.pop(context);
    },
    onTapConfirm: () {
      //Navigator.pop(context);
      authController.logout();
    },
    panaraDialogType: PanaraDialogType.error,
  );
}
