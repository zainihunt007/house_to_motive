import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:house_to_motive/views/login/splash_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff025B8F),),
              useMaterial3: true,
            ),
            home:SplashScreen(),
          );
        }
    );
  }
}



