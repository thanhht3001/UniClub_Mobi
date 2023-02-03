import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicec_mobi/models/common/current_user.dart';

import 'log.dart';

class FirebaseUtils {
  static Future<UserCredential?> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    if (googleAuth != null) {
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return null;
  }

  static Future logout() async {
    if ((await GoogleSignIn().isSignedIn()) == true) {
      GetIt.I.get<CurrentUser>().reset();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      await GoogleSignIn().disconnect();
      await FirebaseAuth.instance.signOut();
      Log.info("Sign out successfully");
    }
  }

  // config local notification
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> display(RemoteMessage message) async {
    try {
  final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
          'high_importance_channel', // id
          'High Importance Notifications',
          channelDescription: "This channel is used for important notification", // name
          importance: Importance.high,
          priority: Priority.high));
  
  await _notificationsPlugin.show(id, message.notification!.title,
      message.notification!.body, notificationDetails);
} on Exception catch (e) {
  Log.debug(e.toString());
}
  }
}
