// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:vixo/auth/user_account_setup/confirm_partner.dart';
import 'package:vixo/auth/user_account_setup/rejected_page.dart';
import 'package:vixo/auth/sign_up.dart';
import 'package:vixo/auth/sign_in.dart';
import 'package:vixo/auth/user_account_setup/awaiting_partner.dart';
import 'package:vixo/auth/user_account_setup/create_email.dart';
import 'package:vixo/auth/user_account_setup/create_username.dart';
import 'package:vixo/auth/phone_auth_old/sign_in/phone_sign_in.dart';
import 'package:vixo/auth/phone_auth_old/sign_up/confirm_otp.dart';
import 'package:vixo/auth/phone_auth_old/sign_up/phone_sign_up.dart';
import 'package:vixo/controllers/calender_controller.dart';
import 'package:vixo/controllers/chat_controller.dart';
import 'package:vixo/controllers/map_controller.dart';
import 'package:vixo/theme/constants.dart';
import 'package:vixo/controllers/auth_controller.dart';
import 'package:vixo/controllers/location_controller.dart';
import 'package:vixo/controllers/notification_controller.dart';
import 'package:vixo/controllers/profile_controller.dart';
import 'package:vixo/auth/user_account_setup/app_location_permission_page.dart';
import 'package:vixo/auth/user_account_setup/app_turn_on_notifications_page.dart';
import 'package:vixo/intro_screen/on_boarding.dart';
import 'package:get/get.dart';
import 'package:ios_willpop_transition_theme/ios_willpop_transition_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vixo/view/logic_page.dart';
import 'package:vixo/view/home.dart';
import 'package:vixo/view/login/login_screen.dart';
import 'package:vixo/view/pages/map_page.dart';
import 'auth/user_account_setup/add_partner.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
    Get.put(ProfileController());
    Get.put(LocationController());
    Get.put(NotificationController());
    Get.put(MapController());
    Get.put(CalendarController());
    Get.put(ChatController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application. arch -x86_64 sudo gem install ffi
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/app_base', page: () => AppHomeBasePage()),
        GetPage(name: '/onboarding', page: () => OnBoarding()),
        GetPage(name: '/login_options', page: () => LoginScreen()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/create_account', page: () => CreateAccountPage()),
        GetPage(name: '/partner', page: () => PartnerConfirmationPage()),
        GetPage(name: '/add_partner', page: () => AddPartnerPage()),
        GetPage(name: '/add_username', page: () => ProvideAccountUsername()),
        GetPage(
            name: '/location_permission',
            page: () => LocationPermissionRequestPage()),
        GetPage(
            name: '/notification_intro', page: () => NotificationRequestPage()),
        GetPage(
            name: '/awaiting_partner', page: () => PartnerConfirmationPage()),
        GetPage(name: '/confirm_partner', page: () => ConfirmPartnerPage()),
        GetPage(name: '/home_page', page: () => PartnerLocationMap()),
      ],
      title: 'Dating',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /* dark theme settings */
        appBarTheme: AppBarTheme(elevation: 0),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        fontFamily: 'Satoshi',
        primaryColor: Colors.blue,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: IOSWillPopTransitionsBuilder(),
            TargetPlatform.android: IOSWillPopTransitionsBuilder(),
            TargetPlatform.macOS: IOSWillPopTransitionsBuilder(),
          },
        ),
      ),
      home: Container(),
    );
  }
}
