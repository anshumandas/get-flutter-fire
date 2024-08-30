// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'

    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:a
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
        return windows;
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
    apiKey: 'AIzaSyC36dmVwt-cECpeaH0sbgotmoqNYkdk1vw',
    appId: '1:3991487808:android:b94b49e0ac05c492ea66a5',
    messagingSenderId: '3991487808',
    projectId: 'sharekhanclg',
    storageBucket: 'sharekhanclg.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAuOAa9gSMcz3D5qNBANKYf91QPBuRKmy8',
    appId: '1:3991487808:ios:c6b5399412adf28aea66a5',
    messagingSenderId: '3991487808',
    projectId: 'sharekhanclg',
    storageBucket: 'sharekhanclg.appspot.com',
    iosBundleId: 'com.example.sharekhanclg',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBE_bhn-MWtQNbT3-BZIh9fltEmTq6UDLk',
    appId: '1:3991487808:web:3390d957047b1e55ea66a5',
    messagingSenderId: '3991487808',
    projectId: 'sharekhanclg',
    authDomain: 'sharekhanclg.firebaseapp.com',
    storageBucket: 'sharekhanclg.appspot.com',
  );
}
