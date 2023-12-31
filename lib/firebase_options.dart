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
    apiKey: 'AIzaSyBMxH0wVKjun4749Wo9VQO9J5AWgGod3uQ',
    appId: '1:638956958414:web:6f249199f1523c45bad69f',
    messagingSenderId: '638956958414',
    projectId: 'foodapp-504ca',
    authDomain: 'foodapp-504ca.firebaseapp.com',
    storageBucket: 'foodapp-504ca.appspot.com',
    measurementId: 'G-6CLR0MZ69D',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBrUEivfL-ikTPNDoM3FptsTXJqj-fvog',
    appId: '1:638956958414:android:e99fa3308c46bb46bad69f',
    messagingSenderId: '638956958414',
    projectId: 'foodapp-504ca',
    storageBucket: 'foodapp-504ca.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdRbIp6cWiV9T0GByQQA2sSRxFt_V1YEA',
    appId: '1:638956958414:ios:6cfb02e3f993d448bad69f',
    messagingSenderId: '638956958414',
    projectId: 'foodapp-504ca',
    storageBucket: 'foodapp-504ca.appspot.com',
    iosBundleId: 'com.example.untitled1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdRbIp6cWiV9T0GByQQA2sSRxFt_V1YEA',
    appId: '1:638956958414:ios:13b3057e7a87bd98bad69f',
    messagingSenderId: '638956958414',
    projectId: 'foodapp-504ca',
    storageBucket: 'foodapp-504ca.appspot.com',
    iosBundleId: 'com.example.untitled1.RunnerTests',
  );
}
