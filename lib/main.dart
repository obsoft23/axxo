// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:vixo/auth/sign_up/phone/confirm_otp.dart';
import 'package:vixo/intro_screen/on_boarding.dart';
import 'package:get/get.dart';
import 'package:ios_willpop_transition_theme/ios_willpop_transition_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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

        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFA5672)),
        fontFamily: 'Satoshi',
        // primaryColor: Colors.pink,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: IOSWillPopTransitionsBuilder(),
            TargetPlatform.android: IOSWillPopTransitionsBuilder(),
            TargetPlatform.macOS: IOSWillPopTransitionsBuilder(),
          },
        ),
      ),
      home: OnBoarding(),
      //home: ConfirmOTPPage(phoneNo: ""),
    );
  }
}
