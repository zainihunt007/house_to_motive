import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house_to_motive/views/screens/navigation_bar/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../intro_screens/intro_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 4), // Adjust the duration as needed
      () {
        nextScreen();
      },
    );
  }

  nextScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('isLogin') == false ||
        preferences.getBool('isLogin') == null) {
      Get.offAll(() => const IntroScreenOne());
    } else {
      Get.offAll(() => const HomePage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          height: MediaQuery.of(context).size.height / 2,
          width: MediaQuery.of(context).size.width / 2,
          'assets/pngs/htmlogo.png',
        ),
      ),
    );
  }
}
