// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA_3I1EYcTLHYDrRUJPwPL3eVmQ_QvJ-po',
    appId: '1:783589739636:android:5a4ca8a8b4de4d5653d521',
    messagingSenderId: '783589739636',
    projectId: 'woyewala',
    storageBucket: 'woyewala.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjKxOtdVRIQe3DbuL9UUApa5wbIVRTCto',
    appId: '1:783589739636:ios:09d6755bfc23ad2053d521',
    messagingSenderId: '783589739636',
    projectId: 'woyewala',
    storageBucket: 'woyewala.appspot.com',
    androidClientId: '783589739636-uh4lulmkmaajflncaeetls6lurdib0av.apps.googleusercontent.com',
    iosClientId: '783589739636-t4jbmbbdh1jbhqp0bo9tf2ptidnd77tt.apps.googleusercontent.com',
    iosBundleId: 'com.woyeuser.woyeuser',
  );

}