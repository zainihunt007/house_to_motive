import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:house_to_motive/views/login/splash_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'firebase_options.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // GetLocationByApi getLocationByApi = Get.put(GetLocationByApi(),tag: 'getLocationByApi');

// @override
//   void initState() {
//     super.initState();
//     getLocationByApi.getLocationData();
//   }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff025B8F);
    return ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
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
        }
    );
  }
}



