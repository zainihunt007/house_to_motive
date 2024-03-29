import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:house_to_motive/push_notification/firebase_api.dart';
import 'package:house_to_motive/push_notification/home_screen.dart';
import 'package:house_to_motive/views/login/splash_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotification();
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   if (message.notification != null) {
  //     print('background notification is tapped');
  //     navigatorKey.currentState?.pushNamed("/message", arguments: message);
  //   }
  // });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // GetLocationByApi getLocationByApi = Get.put(GetLocationByApi(),tag: 'getLocationByApi');
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getLocationByApi.getLocationData();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.isTokenRefresh();
    updateDeviceToken();

    notificationServices.getDeviceToken().then((value) {
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }

  Future<void> updateDeviceToken() async {
    String? deviceToken = await FirebaseMessaging.instance.getToken();

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update({'Device Token': deviceToken});
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff025B8F);
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primaryColor,
          // colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff025B8F),),
          scaffoldBackgroundColor: const Color(0xFFF6F9FF),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      );
    });
  }
}
