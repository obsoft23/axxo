// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:vixo/controllers/auth_controller.dart';
import 'package:vixo/controllers/auth_service.dart';
import 'package:vixo/controllers/calender_controller.dart';
import 'package:vixo/controllers/chat_controller.dart';
import 'package:vixo/controllers/location_controller.dart';
import 'package:vixo/controllers/map_controller.dart';
import 'package:vixo/controllers/notification_controller.dart';
import 'package:vixo/controllers/profile_controller.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
//AuthController authController = AuthController.instance;
AuthController authController = Get.find();
ProfileController profileController = Get.find();
LocationController locationController = Get.find();
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
NotificationController notificationController = Get.find();
MapController mapController = Get.find();
CalendarController calendarController = Get.find();
ChatController chatController = Get.find();
