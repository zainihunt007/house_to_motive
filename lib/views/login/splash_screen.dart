import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:house_to_motive/views/screens/explore_screen.dart';
import 'package:house_to_motive/views/screens/navigation_bar/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../intro_screens/intro_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final placeApiController = Get.put(PlacesApi());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // placeApiController.determinePosition();
    Future.delayed(
      const Duration(seconds: 5), // Adjust the duration as needed
      () {
        nextScreen();
      },
    );
    placeApiController.determinePosition();
  }

  nextScreen() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('isLogin') == false ||
        preferences.getBool('isLogin') == null) {
      Get.offAll(() => const IntroScreenOne());
    } else {
      Get.offAll(
        () => const HomePage(),
        transition: Transition.downToUp,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/pngs/htmimage1.png',
              ),
            ),
            Positioned(
              bottom: 60,
              right: 110,
              child: SvgPicture.asset(
                'assets/svgs/splash-logo.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
