// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAR1cA8S03Q-g8benQHjgHNdHmKLQZcKWc',
    appId: '1:466382031798:web:ab8cc33577f80e24a34f17',
    messagingSenderId: '466382031798',
    projectId: 'vixo-a91cd',
    authDomain: 'vixo-a91cd.firebaseapp.com',
    storageBucket: 'vixo-a91cd.appspot.com',
    measurementId: 'G-BTWW4SZ5G1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-xpkCnsmnceJ75cd-XQpJtUiEuh-3-ss',
    appId: '1:466382031798:android:6f23c06b6e960cdaa34f17',
    messagingSenderId: '466382031798',
    projectId: 'vixo-a91cd',
    storageBucket: 'vixo-a91cd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyADlimkMuyMGg5PIQxuDcfHhjohvvUSn4I',
    appId: '1:466382031798:ios:f1f12e2ad1f2aecca34f17',
    messagingSenderId: '466382031798',
    projectId: 'vixo-a91cd',
    storageBucket: 'vixo-a91cd.appspot.com',
    iosBundleId: 'com.example.vixo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyADlimkMuyMGg5PIQxuDcfHhjohvvUSn4I',
    appId: '1:466382031798:ios:f1f12e2ad1f2aecca34f17',
    messagingSenderId: '466382031798',
    projectId: 'vixo-a91cd',
    storageBucket: 'vixo-a91cd.appspot.com',
    iosBundleId: 'com.example.vixo',
  );
}
