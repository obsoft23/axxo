// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, duplicate_ignore, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_element, empty_catches, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vixo/auth/setup/create_email.dart';
import 'package:vixo/auth/sign_up/phone/confirm_otp.dart';
import 'package:vixo/intro_screen/on_boarding.dart';
import 'package:vixo/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static AuthController instance = Get.find();

  late Rx<User?> user;
  var page = 0.obs;

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    // Get called after widget is rendered on the screen

    user = Rx<User?>(auth.currentUser);

    user.bindStream(auth.userChanges());
    ever(user, _setInitialScreen);
  }

  @override
  void onClose() {
    //Get called when controller is removed from memory
    super.onClose();
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => const OnBoarding());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => const HomePage());
    }
  }

  // ignore: no_leading_underscores_for_local_identifiers
  phoneVerify(phone) async {
    await auth
        .verifyPhoneNumber(
      // timeout: Duration(seconds: 30),
      phoneNumber: phone,
      verificationCompleted: (phoneAuthCredential) async {
        print("completed auth");
        return;
      },
      verificationFailed: (error) async {
        print("verification error$error");
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        //+44 7479 779589
        String smsCode = '455512';
        print("code sent");
        Get.to(
          () => ConfirmOTPPage(
            otpverficationId: verificationId,
            smsCode: smsCode,
            phoneNo: phone,
          ),
        );
      },

      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        .onError((error, stackTrace) {
      print("error");
    });
  }

  _phoneSignIn(otpverficationId, token) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: otpverficationId,
      smsCode: token,
    );

    try {
      // Sign the user in (or link) with the credential
      await auth.signInWithCredential(credential);

      Get.to(() => CreateEmailPage());
      return;
    } catch (firebaseAuthException) {}
  }

  void logout() async {
    try {
      auth.signOut();
    } catch (firebaseAuthException) {
      print("error logging out");
    }
  }
}

  //

