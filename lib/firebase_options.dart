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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvvtXsfhogs5GXYr5M4nX5XzjXOXcnb_U',
    appId: '1:282596968404:web:eaa4d4a5eeb88053e9f841',
    messagingSenderId: '282596968404',
    projectId: 'itugeo',
    authDomain: 'itugeo.firebaseapp.com',
    storageBucket: 'itugeo.appspot.com',
    measurementId: 'G-1KPCV3MXHY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAq790wpQ7PlnSBsxOus1zN0ytxdDsCt6M',
    appId: '1:282596968404:android:f586357e171c8549e9f841',
    messagingSenderId: '282596968404',
    projectId: 'itugeo',
    storageBucket: 'itugeo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMOSS_q1S-i6i6GEXImO2kt9KAJGnorOo',
    appId: '1:282596968404:ios:eb4856385f50d8c3e9f841',
    messagingSenderId: '282596968404',
    projectId: 'itugeo',
    storageBucket: 'itugeo.appspot.com',
    iosClientId:
        '282596968404-s0h285u1t2eiarslok49scc9lskacavr.apps.googleusercontent.com',
    iosBundleId: 'com.example.ituGeo',
  );
}
