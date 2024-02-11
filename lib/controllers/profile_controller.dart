// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, duplicate_ignore, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_element, empty_catches, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vixo/auth/setup/add_partner.dart';
import 'package:vixo/auth/setup/awaiting_partner.dart';
import 'package:vixo/auth/setup/create_email.dart';
import 'package:vixo/auth/setup/create_username.dart';
import 'package:vixo/auth/phone_auth_old/sign_up/confirm_otp.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/intro_screen/app_location_permission_page.dart';
import 'package:vixo/intro_screen/on_boarding.dart';
import 'package:vixo/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vixo/screens/login/login_screen.dart';

class ProfileController extends GetxController {
  //static final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
  }

  @override
  void onClose() {
    //Get called when controller is removed from memory
    super.onClose();
  }

  checkIfHasUsername(value) async {
    try {
      QuerySnapshot displayNameSnapshot = await firestore
          .collection('users')
          .where('displayName', isEqualTo: value)
          .get();
      if (displayNameSnapshot.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("error logging out : \n $error");
    }
  }

  updateUserEmail(email, context) async {
    QuerySnapshot displayNameSnapshot = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (displayNameSnapshot.docs.isEmpty) {
      User? user = auth.currentUser;
      await firestore.collection('users').doc(user!.uid).update({
        'email': email,
      }).then((value) {
        Get.offAll(() => ProvideAccountUsername());
      });
    } else {
      print('Email already exists. Please choose a different one.');
      toastification.show(
        type: ToastificationType.warning,
        style: ToastificationStyle.flat,
        alignment: Alignment.centerLeft,
        backgroundColor: Colors.white,
        applyBlurEffect: true,
        context: context,
        title:
            Text('Sorry, Email already exists. Please choose a different one.'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  checkIfHasPartner() async {
    try {
      // Get the user document from Firestore
      DocumentSnapshot userSnapshot =
          await firestore.collection('users').doc(auth.currentUser!.uid).get();

      // Check if the user document contains the 'partnerId' field
      Map<String, dynamic>? userData =
          userSnapshot.data() as Map<String, dynamic>?;
      bool hasPartnerId = userData != null && userData.containsKey('partnerId');
      if (!hasPartnerId) {
        Get.offNamed('/add_partner');
      }
    } catch (e) {
      print('Error searching and updating partner: $e');
    }
  }

  searchPartner(partnerDisplayName, context) async {
    try {
      User? currentUser = auth.currentUser;
      // Query the Firestore collection for the user with the provided displayName

      //
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
          .collection('users')
          .where('displayName', isEqualTo: partnerDisplayName)
          .get();

      // Check if a user with the provided displayName exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the user ID of the found user
        String partnerUserId = querySnapshot.docs.first.id;
      } else {
        print('Username $partnerDisplayName not found.');
        toastification.show(
          type: ToastificationType.warning,
          style: ToastificationStyle.flat,
          alignment: Alignment.centerLeft,
          backgroundColor: Colors.white,
          applyBlurEffect: true,
          context: context,
          title: Text('Username $partnerDisplayName not found.'),
          autoCloseDuration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print('Error searching and updating partner: $e');
    }
  }

  createUserName(BuildContext context, String username) async {
    QuerySnapshot displayNameSnapshot = await firestore
        .collection('users')
        .where('displayName', isEqualTo: username)
        .get();
    if (displayNameSnapshot.docs.isEmpty) {
      // Update the display name if it doesn't exist
      await auth.currentUser?.updateDisplayName(username);

      // Update display name in Firestore as well
      await firestore.collection('users').doc(auth.currentUser?.uid).update({
        'displayName': username,
      });

      print('Display name updated successfully');

      // Get.to(() => AddPartnerPage());
    } else {
      print('Display name already exists. Please choose a different one.');
      // ignore: use_build_context_synchronously
      toastification.show(
        type: ToastificationType.warning,
        style: ToastificationStyle.flat,
        alignment: Alignment.centerLeft,
        backgroundColor: Colors.pinkAccent,
        applyBlurEffect: true,
        context: context,
        title: Text('Display name not available.'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }
}
