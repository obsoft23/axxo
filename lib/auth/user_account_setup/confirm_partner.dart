// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api, unused_field, unused_element, unused_import, prefer_const_constructors_in_immutables, prefer_final_fields, unused_local_variable, duplicate_ignore

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:vixo/components/loading_gif.dart';
import 'package:vixo/components/socials_button.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/screens/home.dart';
import 'package:vixo/theme/theme.dart';

// ignore: must_be_immutable
class ConfirmPartnerPage extends StatefulWidget {
  ConfirmPartnerPage({super.key, this.partnerRequestId});

  // ignore: prefer_typing_uninitialized_variables
  var partnerRequestId;

  @override
  State<ConfirmPartnerPage> createState() => _ConfirmPartnerPageState();
}

class _ConfirmPartnerPageState extends State<ConfirmPartnerPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    profileController.fetchPartnerRequest();
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
                "Confirm Partner Request ",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Approve partner request  ", style: subTitle4),
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
              return CenterLoadingIndicator();
            } else if (!snapshot.exists) {
              return Center(child: Text('No data found'));
            } else {
              var userData = snapshot.data();
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 38,
                      ),
                      SizedBox(
                        child: Image.asset("assets/images/hand_waiting.gif"),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '${userData!['displayName']}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'walto'),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(color: kDefaultIconDarkColor),
                            children: const [
                              TextSpan(
                                  text:
                                      " ❤️ The above username as sent a request to be your partner so you can enjoy the features of "),
                              TextSpan(
                                text: 'our  mobile app.',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kAltDarkTextColor,
                                    decoration: TextDecoration.underline),
                              ),
                              TextSpan(text: ' Be '),
                              TextSpan(
                                text: 'together by accepting.. 🥰',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kAltDarkTextColor,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SocialButton(
                            text: "Reject",
                            color: Colors.red,
                            textColor: kWhiteColor,
                            onTap: () async {
                              //
                              var status = await profileController
                                  .rejectPartner(userData['uid'], context);
                            },
                            icon: Icon(Icons.cancel_outlined,
                                color: Colors.white),
                          ),
                          SocialButton(
                            text: "Accept",
                            color: Colors.green,
                            textColor: kWhiteColor,
                            onTap: () async {
                              //// ignore: unused_local_variable
                              var status = await profileController
                                  .acceptPartner(userData['uid'], context);
                            },
                            icon: Icon(Icons.check_circle, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}

_showExitConfirmationDialog(BuildContext context, String pageInfo) async {
  return PanaraConfirmDialog.showAnimatedGrow(
    context,
    noImage: true,
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
    panaraDialogType: PanaraDialogType.warning,
  );
}
