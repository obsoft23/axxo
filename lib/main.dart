// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:vixo/auth/setup/create_email.dart';
import 'package:vixo/auth/setup/create_username.dart';
import 'package:vixo/auth/sign_up/phone/confirm_otp.dart';
import 'package:vixo/intro_screen/app_location_permission_page.dart';
import 'package:vixo/intro_screen/on_boarding.dart';
import 'package:get/get.dart';
import 'package:ios_willpop_transition_theme/ios_willpop_transition_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/setup/add_partner.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application. arch -x86_64 sudo gem install ffi
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
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
      home: OnBoarding(),
      //home: PermissionRequestPage
    );
  }
}
