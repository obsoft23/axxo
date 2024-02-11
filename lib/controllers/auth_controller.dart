// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, duplicate_ignore, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_element, empty_catches, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:vixo/auth/sign_up.dart';
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
import 'dart:async';
import 'package:facebook_auth/facebook_auth.dart';

class AuthController extends GetxController {
  static FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoggedIn = false.obs;
  late Rx<User?> user;

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, checkLogin);
  }

  @override
  void onClose() {
    //Get called when controller is removed from memory
    super.onClose();
  }

  checkLogin(user) async {
    print("on this set intial page  $user");

    if (user == null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? first_time = prefs.getBool('first_time');
      // User is not signed in, redirect to login page
      if (first_time != null) {
        Get.offNamed('/login_options');
        return;
      } else {
        Get.offNamed('/onboarding');
        return;
      }
    } else {
      if (user.displayName == null) {
        Get.offNamed('/add_username');
      } else {
        Get.offAllNamed("/home");
      }
    }
  }

  loginUser(String email, String password, context) async {
    // Implement your sign in logic with email and password here
    print('Signing in with email and password...');
    print('Email: $email, Password: $password');
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {}
  }

  registerUser(String email, String password, context) async {
    // Implement your sign up logic with email and password here
    print('Signing up with email and password...');
    // print('Email: $email, Password: $password');
    // For demo purpose, setting isLoggedIn true
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // the user object
      final _user = userCredential.user!;

      // Add the user to the users collection
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'uid': _user.uid,
      });

      // Get.offAllNamed("add_username");
    } catch (firebaseAuthException) {
      print("error creating new user : \n $firebaseAuthException");
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        alignment: Alignment.centerLeft,
        backgroundColor: Color.fromARGB(255, 225, 115, 107),
        applyBlurEffect: true,
        context: context,
        title: Text('Error: $firebaseAuthException'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  signInWithFacebook() async {
    // Implement your sign in with Facebook logic here
    print('Signing in with Facebook...');
    // For demo purpose, setting isLoggedIn true
    isLoggedIn.value = true;
    try {} catch (firebaseAuthException) {
      print("error signing in with google : \n $firebaseAuthException");
    }
  }

  signInWithGoogle() async {
    // Implement your sign in with Google logic here
    print('Signing in with Google...');
    // For demo purpose, setting isLoggedIn true
    isLoggedIn.value = true;
    try {
      GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
      auth.signInWithProvider(_googleAuthProvider);
    } catch (firebaseAuthException) {
      print("error signing in with google : \n $firebaseAuthException");
    }
  }

  void logout() async {
    try {
      auth.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('first_time', false);
      Get.offAll(() => LoginScreen());
    } catch (firebaseAuthException) {
      print("error logging out : \n $firebaseAuthException");
    }
  }
}
