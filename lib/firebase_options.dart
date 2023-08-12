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
    apiKey: 'AIzaSyDb2IWPF0VG36Lsc6RCAibn1iizat8QL_k',
    appId: '1:675789980846:web:79ab135abef83e0275993f',
    messagingSenderId: '675789980846',
    projectId: 'todo-app-4917c',
    authDomain: 'todo-app-4917c.firebaseapp.com',
    storageBucket: 'todo-app-4917c.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnzqm5b6EtV0oAxQ9KQt9hHWjuI728Chg',
    appId: '1:675789980846:android:26ea1994f4e8690875993f',
    messagingSenderId: '675789980846',
    projectId: 'todo-app-4917c',
    storageBucket: 'todo-app-4917c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWK4TR9STMRPAoxq7NZNBrLbqk21zDL_s',
    appId: '1:675789980846:ios:7469d4b44f3951b175993f',
    messagingSenderId: '675789980846',
    projectId: 'todo-app-4917c',
    storageBucket: 'todo-app-4917c.appspot.com',
    iosClientId: '675789980846-kupr9g7bhouiba61kgb9cbln6n0hu81p.apps.googleusercontent.com',
    iosBundleId: 'com.example.todo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWK4TR9STMRPAoxq7NZNBrLbqk21zDL_s',
    appId: '1:675789980846:ios:56ec93fd7bdf981b75993f',
    messagingSenderId: '675789980846',
    projectId: 'todo-app-4917c',
    storageBucket: 'todo-app-4917c.appspot.com',
    iosClientId: '675789980846-chkbc8kn28cq98m7tdvsassrbuq3efcj.apps.googleusercontent.com',
    iosBundleId: 'com.example.todo.RunnerTests',
  );
}