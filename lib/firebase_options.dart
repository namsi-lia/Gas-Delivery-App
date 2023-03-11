// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members, depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// Default [FirebaseOptions] for use with your Firebase apps.
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
    apiKey: 'AIzaSyB-imdi_vRs_7824Byce04coXF3793Ib30',
    appId: '1:181699119043:web:bcebb430a27dbe7549df76',
    messagingSenderId: '181699119043',
    projectId: 'gas-delivery-app-85a14',
    authDomain: 'gas-delivery-app-85a14.firebaseapp.com',
    storageBucket: 'gas-delivery-app-85a14.appspot.com',
    measurementId: 'G-7HWGKMXRB2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYHsQoA-x5iqtcK63RsBovxoX2oX2RCik',
    appId: '1:181699119043:android:75fac634022117e549df76',
    messagingSenderId: '181699119043',
    projectId: 'gas-delivery-app-85a14',
    storageBucket: 'gas-delivery-app-85a14.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUnC4OAuFsQdw3dxTXHXFS4cOFz84kfZM',
    appId: '1:181699119043:ios:463e039795db1c1849df76',
    messagingSenderId: '181699119043',
    projectId: 'gas-delivery-app-85a14',
    storageBucket: 'gas-delivery-app-85a14.appspot.com',
    iosClientId:
        '181699119043-n4iort5nhjg895e9db9mdbk1g555s23j.apps.googleusercontent.com',
    iosBundleId: 'com.example.gasDeliveryApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUnC4OAuFsQdw3dxTXHXFS4cOFz84kfZM',
    appId: '1:181699119043:ios:463e039795db1c1849df76',
    messagingSenderId: '181699119043',
    projectId: 'gas-delivery-app-85a14',
    storageBucket: 'gas-delivery-app-85a14.appspot.com',
    iosClientId:
        '181699119043-n4iort5nhjg895e9db9mdbk1g555s23j.apps.googleusercontent.com',
    iosBundleId: 'com.example.gasDeliveryApp',
  );
}
