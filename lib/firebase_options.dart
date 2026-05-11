import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] 
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAALU5AYnTyGY1uW2swHzJXlKx7iJS4zZY',
    appId: '1:632302541021:web:91e517ad3fd5e7f4d32334',
    messagingSenderId: '632302541021',
    projectId: 'medicall-test-mahmoud',
    authDomain: 'medicall-test-mahmoud.firebaseapp.com',
    storageBucket: 'medicall-test-mahmoud.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeRkk8oCBqUZBUphRCxOd3vMiFX5u4z58',
    appId: '1:632302541021:android:68cedd9518844e98d32334',
    messagingSenderId: '632302541021',
    projectId: 'medicall-test-mahmoud',
    storageBucket: 'medicall-test-mahmoud.firebasestorage.app',
  );

}