// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, duplicate_ignore, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_element, empty_catches, unused_import, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';
import 'package:vixo/auth/user_account_setup/add_partner.dart';
import 'package:vixo/auth/user_account_setup/awaiting_partner.dart';
import 'package:vixo/auth/user_account_setup/create_email.dart';
import 'package:vixo/auth/user_account_setup/create_username.dart';
import 'package:vixo/auth/phone_auth_old/sign_up/confirm_otp.dart';
import 'package:vixo/auth/user_account_setup/rejected_page.dart';
import 'package:vixo/theme/constants.dart';
import 'package:vixo/auth/user_account_setup/app_location_permission_page.dart';
import 'package:vixo/intro_screen/on_boarding.dart';
import 'package:vixo/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vixo/view/login/login_screen.dart';

class ProfileController extends GetxController {
  final RxBool _isConfirmed = false.obs;
  final RxBool _isRejected = false.obs;
  Rx<DocumentSnapshot<Map<String, dynamic>>?> partnerRequest =
      Rxn<DocumentSnapshot<Map<String, dynamic>>>();
  Rx<DocumentSnapshot<Map<String, dynamic>>?> addPartnerPageDocuement =
      Rxn<DocumentSnapshot<Map<String, dynamic>>>();

  @override
  void onInit() {
    // Get called when controller is created
    super.onInit();
  }

  @override
  void onReady() {
    checkIfHasPartner();
    super.onReady();
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
    } on FirebaseAuthException catch (error) {
      print("error logging out : \n $error");
    }
  }

  checkIfHasPartner() async {
    try {
      if (auth.currentUser == null) {
        return;
      }

      firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .snapshots()
          .listen((userSnapshot) {
        Map<String, dynamic>? userData = userSnapshot.data();
        bool hasPartnerId =
            userData != null && userData.containsKey('partnerId');

        bool hasDisplayName =
            userData != null && userData.containsKey('displayName');
        if (!hasDisplayName) {
          print("status of $hasDisplayName");
          Get.offNamed('/add_username'); // Redirect to create username page
          return;
        }

        if (!hasPartnerId) {
          print("no partner found");
          Get.offNamed('/add_partner');
          return;
        } else {
          checkIFPartnerApproved(userSnapshot);
          return;
        }
        //  addPartnerPageDocuement.value =
        //    userSnapshot; // Update userDocument with the latest snapshot
      });
      return;
    } on FirebaseAuthException catch (e) {
      print('Error searching and updating partner: $e');
    }
  }

  checkIFPartnerApproved(userSnapshot) async {
    try {
// Get the user document from Firestore
      if (auth.currentUser == null) {
        return;
      }

      // Check if the user document has a partnerId and if it's approved
      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        if (userData["approved"] == false) {
          //
          /**** if user request has been rejected */
          if (userData.containsKey('rejected')) {
            //
            if (userData.containsKey('partnerId') &&
                userData['rejected'] == true &&
                userData['sender'] == true) {
              Get.offAll(
                RejectPartnerRequestPage(
                  rejector: true,
                ),
              );

              //
            } else if (userData.containsKey('partnerId') &&
                userData['rejected'] == true &&
                userData['sender'] == false) {
              Get.offAll(
                RejectPartnerRequestPage(
                  rejector: false,
                ),
              );
            }
          } else {
            if (userData.containsKey('partnerId') &&
                userData['sender'] == true) {
              Get.offNamed('/awaiting_partner');

              //
            } else if (userData.containsKey('partnerId') &&
                userData['sender'] == false) {
              Get.offNamed('/confirm_partner');

              //
            }
          }
        } else if (!userData.containsKey('partnerId')) {
          Get.offNamed('/add_partner');
        } else {
          print("Checking to see if notification and location is granted");

          //await locationController.requestLocationPermission();
          bool isGrantedLocation = await locationController.isLocationGranted();
          bool notificationPermission =
              await notificationController.isNotificationPermissionGranted();

          //
          print('Location status: $isGrantedLocation');
          print('Notification status: $notificationPermission');

          if (isGrantedLocation && notificationPermission) {
            Get.offNamed('/home');
            return;
          } else if (!isGrantedLocation) {
            Get.offNamed('/location_permission');
            return;
          } else if (!notificationPermission) {
            Get.offNamed('/notification_intro');
            return;
          } else {}
        }
      } else {
        print('User document not found');
        authController.logout();

        return false;
      }
    } on FirebaseAuthException catch (e) {
      print('Error searching and  partner status: $e');
    }
  }

  searchPartner(partnerDisplayName) async {
    try {
      String userId = auth.currentUser!.uid;
      // Search for the displayName in the database
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('displayName', isEqualTo: partnerDisplayName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        String foundUserId = userSnapshot.id;

        // Check if found user is the searching user
        if (foundUserId == userId) {
          return false; // Searched user is the same as the searching user
        }

        // Check if any user has the same partnerID
        QuerySnapshot partnerSnapshot = await firestore
            .collection('users')
            .where('partnerId', isEqualTo: foundUserId)
            .get();

        if (partnerSnapshot.docs.isEmpty) {
          // No user has the same partnerID
          return true;
        } else {
          // Another user already has the same partnerID
          return false;
        }
      } else {
        // User with displayName not found
        return false;
      }
    } on FirebaseAuthException catch (e) {
      print('Error searching and updating partner: $e');
    }
  }

  addPartner(String partnerDisplayName, BuildContext context) async {
    try {
      String userId = auth.currentUser!.uid;
      // Search for the displayName in the database
      QuerySnapshot querySnapshot = await firestore
          .collection('users')
          .where('displayName', isEqualTo: partnerDisplayName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        String foundUserId = userSnapshot.id;

        // Check if any user has the same partnerID
        QuerySnapshot partnerSnapshot = await firestore
            .collection('users')
            .where('partnerId', isEqualTo: userId)
            .get();

        if (foundUserId != userId) {
          if (partnerSnapshot.docs.isEmpty) {
            // Update the found user's document with the partnerId and approved status
            await firestore.collection('users').doc(foundUserId).update({
              'partnerId': userId,
              'approved': false,
              'sender': false,
            });

            // Update the user searching's document with the found user's partnerId and approved status
            await firestore.collection('users').doc(userId).update({
              'partnerId': foundUserId,
              'approved': false,
              'sender': true,
            });

            print('Partner found and approved successfully');
            Get.offNamed('/awaiting_partner');
          } else {
            print('Another user already has the same partnerID');

            // ignore: use_build_context_synchronously
            return toastification.show(
              type: ToastificationType.error,
              style: ToastificationStyle.flat,
              alignment: Alignment.centerLeft,
              backgroundColor: Color.fromARGB(255, 225, 115, 107),
              applyBlurEffect: true,
              context: context,
              title: Text('Sorry, user already has a partner'),
              autoCloseDuration: const Duration(seconds: 3),
            );
          }
        }
      } else {
        print('User with displayName not found');
      }
    } on FirebaseAuthException catch (error) {
      print("error rejecting partner user : \n $error");
      // ignore: use_build_context_synchronously
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        alignment: Alignment.centerLeft,
        backgroundColor: Color.fromARGB(255, 225, 115, 107),
        applyBlurEffect: true,
        context: context,
        title: Text('${error.message}'),
        autoCloseDuration: const Duration(seconds: 3),
      );
      return false;
    }
  }

  fetchPartnerRequest() async {
    try {
      String _userId = auth.currentUser!.uid;
      // Search for the displayName in the database
      DocumentSnapshot<Map<String, dynamic>> userDocument =
          await firestore.collection('users').doc(_userId).get();
      print(
          'Searching for the displayName in the database${userDocument['partnerId']}');

      DocumentSnapshot<Map<String, dynamic>> userDocument2 = await firestore
          .collection('users')
          .doc(userDocument['partnerId'])
          .get();

      partnerRequest.value = userDocument2;
    } on FirebaseAuthException catch (error) {
      print('Error fetching partner request: $error');
    }
  }

  acceptPartner(partnerId, context) async {
    try {
      String _userId = auth.currentUser!.uid;
      // print("user id is $_userId");
      // print("partner id is $partnerId");

      // Update display name in Firestore as well
      await firestore.collection('users').doc(_userId).update({
        'approved': true,
      }).then((value) {
        firestore.collection('users').doc(partnerId).update({
          'approved': true,
        });

        Get.offNamed('/location_permission');
      });
    } on FirebaseAuthException catch (error) {
      print("error rejecting partner user : \n $error");
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        alignment: Alignment.centerLeft,
        backgroundColor: Color.fromARGB(255, 225, 115, 107),
        applyBlurEffect: true,
        context: context,
        title: Text('${error.message}'),
        autoCloseDuration: const Duration(seconds: 3),
      );
      return false;
    }
  }

  rejectPartner(partnerId, context) async {
    try {
      String _userId = auth.currentUser!.uid;

      // Update display name in Firestore as well
      await firestore.collection('users').doc(auth.currentUser?.uid).update({
        'approved': false,
        'rejected': true,
      });

      await firestore.collection('users').doc(partnerId).update({
        'approved': false,
        'rejected': true,
      });
    } on FirebaseAuthException catch (error) {
      print("error rejecting partner user : \n $error");
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.flat,
        alignment: Alignment.centerLeft,
        backgroundColor: Color.fromARGB(255, 225, 115, 107),
        applyBlurEffect: true,
        context: context,
        title: Text('${error.message}'),
        autoCloseDuration: const Duration(seconds: 3),
      );
    }
  }

  resetPartnerStatus(partnerId) async {
    try {
      //
      String _userId = auth.currentUser!.uid;

      // Update display name in Firestore as well
      await firestore.collection('users').doc(auth.currentUser?.uid).update({
        'partnerId': FieldValue.delete(),
        'rejected': FieldValue.delete(),
        'sender': FieldValue.delete(),
        'approved': FieldValue.delete(),
      });
    } on FirebaseAuthException catch (error) {
      print('Error fetching partner request: $error');
      rethrow;
    }
  }

  ///
  ///
  ///

  ///
  ///
  ///
  Future<bool> _checkLocationPermission() async {
    PermissionStatus locationPermissionStatus =
        await Permission.location.status;
    print(
        " in locationPermissionStatus the status is $locationPermissionStatus");
    if (locationPermissionStatus.isGranted ||
        locationPermissionStatus.isLimited) {
      return true;
    } else if (locationPermissionStatus.isDenied ||
        locationPermissionStatus.isPermanentlyDenied) {
      /*   PermissionStatus permissionStatus = await Permission.location.request();
      await Geolocator.getCurrentPosition();
      return permissionStatus.isGranted || permissionStatus.isLimited;*/
      return true;
    } else if (locationPermissionStatus.isProvisional ||
        locationPermissionStatus.isLimited) {
      return true;
    } else {
      return false; // Handle other states if needed
    }
  }

  Future<bool> _checkNotificationPermission() async {
    /*PermissionStatus notificationPermissionStatus =
        await Permission.notification.status;
    print(
        " in _checkNotificationPermission the status is $notificationPermissionStatus");
    if (notificationPermissionStatus.isGranted) {
      return true;
    } else if (notificationPermissionStatus.isDenied) {
      PermissionStatus permissionStatus =
          await Permission.notification.request();
      return permissionStatus.isGranted;
    } else {
      return false; // Permission is permanently denied, handle accordingly
    }*/
    PermissionStatus status = await Permission.notification.status;
    if (status.isGranted) {
      // Permission already granted
      print('Notification permission granted');
      return true;
    } else if (status.isDenied ||
        status.isRestricted ||
        status.isPermanentlyDenied) {
      // Permission not granted
      return false;
    } else {
      // Permission is not determined (yet), request it
      return false;
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
      await firestore.collection('users').doc(auth.currentUser?.uid).set({
        'displayName': username,
        'email': auth.currentUser?.email,
        'uid': auth.currentUser?.uid
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
}
