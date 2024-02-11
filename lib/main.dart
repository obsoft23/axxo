// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:vixo/auth/sign_up.dart';
import 'package:vixo/auth/sign_in.dart';
import 'package:vixo/auth/setup/awaiting_partner.dart';
import 'package:vixo/auth/setup/create_email.dart';
import 'package:vixo/auth/setup/create_username.dart';
import 'package:vixo/auth/phone_auth_old/sign_in/phone_sign_in.dart';
import 'package:vixo/auth/phone_auth_old/sign_up/confirm_otp.dart';
import 'package:vixo/auth/phone_auth_old/sign_up/phone_sign_up.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/controllers/auth_controller.dart';
import 'package:vixo/controllers/profile_controller.dart';
import 'package:vixo/intro_screen/app_location_permission_page.dart';
import 'package:vixo/intro_screen/on_boarding.dart';
import 'package:get/get.dart';
import 'package:ios_willpop_transition_theme/ios_willpop_transition_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vixo/screens/home.dart';
import 'package:vixo/screens/login/login_screen.dart';
import 'auth/setup/add_partner.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) {
    Get.put(AuthController());
    Get.put(ProfileController());
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
        GetPage(name: '/onboarding', page: () => OnBoarding()),
        GetPage(name: '/login_options', page: () => LoginScreen()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/create_account', page: () => CreateAccountPage()),
        GetPage(name: '/partner', page: () => PartnerConfirmationPage()),
        GetPage(name: '/add_partner', page: () => AddPartnerPage()),
        GetPage(name: '/add_username', page: () => ProvideAccountUsername()),
      ],
      title: 'Dating',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /* dark theme settings */
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
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: Image.asset("assets/images/loading.gif"),
              ),
            ),
            TextButton(
                onPressed: () {
                  authController.logout();
                },
                child: Text("Logout"))
          ],
        ),
      ),
    );
  }
}
