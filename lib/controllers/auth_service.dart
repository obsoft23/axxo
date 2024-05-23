// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, duplicate_ignore, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_element, empty_catches, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vixo/auth/user_account_setup/create_email.dart';
import 'package:vixo/auth/phone_auth_old/sign_up/confirm_otp.dart';
import 'package:vixo/intro_screen/on_boarding.dart';
import 'package:vixo/view/home.dart';

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String verifyId = "";

  static Future sentOtp({
    required String phone,
    required Function errorStep,
  }) async {
    await _firebaseAuth
        .verifyPhoneNumber(
      // timeout: Duration(seconds: 30),
      phoneNumber: phone,
      verificationCompleted: (phoneAuthCredential) async {
        print("completed");
        return;
      },
      verificationFailed: (error) async {
        print("completed$error");
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        //+44 7479 779589
        String smsCode = '455512';
        print("code sent$verifyId");
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
      errorStep();
    });
  }

  static Future loginWithOtp({required String otp}) async {
    final cred =
        PhoneAuthProvider.credential(verificationId: verifyId, smsCode: otp);
    try {
      final user = await _firebaseAuth.signInWithCredential(cred);
      // ignore: avoid_print
      print("user returned from db $user");
      // ignore: avoid_print
      print("user returned from db ${user.user}");
      if (user.user != null) {
        return "Success";
      } else {
        return "Error in Otp login";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  static Future logout() async {
    await _firebaseAuth.signOut();
  }

  // check whether the user is logged in or not
  static Future<bool> isLoggedIn() async {
    var user = _firebaseAuth.currentUser;
    return user != null;
  }
}
