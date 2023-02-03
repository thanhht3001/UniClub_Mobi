import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:unicec_mobi/utils/log.dart';
import 'package:unicec_mobi/utils/router.dart';
import 'dependencies/app_dependencies.dart';
import 'utils/firebase.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Log.info("Handling a background message: ${message.messageId}");
  print('SenderId: ${message.senderId}');  
  // print('Data:${message.data.toString()}');
  print('message.notification.title: ${message.notification?.title}');
  print('message.notification.title: ${message.notification?.body}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // name
    description: 'This channel is used for important notification',
    importance: Importance.high);

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseUtils.initialize();
  await AppDependencies.setup();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.subscribeToTopic(('UniCEC'));
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniCEC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //initialRoute: "/onboarding",
      initialRoute: Routes.splash,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => Routes.getRoute(settings),
      //home: Login(),
    );
  }
}
