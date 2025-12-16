// lib/firebase_options.dart
// FlutterFire CLI로 자동 생성됨

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web is not supported in this app');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  // Android 설정 (FlutterFire CLI로 생성 필요)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTHfBMD-tin6B1f1FJKPcW6qUMGRnA_aY',
    appId: '1:137155354338:android:ab188c87418aac9f1988bb',
    messagingSenderId: '137155354338',
    projectId: 'todoapp-7afa3',
    storageBucket: 'todoapp-7afa3.firebasestorage.app',
  );

  // iOS 설정 (사용 안 함)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'YOUR_PROJECT_ID',
    storageBucket: 'YOUR_STORAGE_BUCKET',
    iosBundleId: 'com.example.tasksyncMobile',
  );
}
