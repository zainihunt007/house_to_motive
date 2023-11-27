import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_to_motive/views/screens/navigation_bar/text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../explore_screen.dart';
import '../chat_screen.dart';
import '../home_screens/home_screen.dart';
import '../profile_screen.dart';
import '../search.dart';
import 'color.dart';
import 'custom_paint.dart';
import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectBtn = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                    statusBarColor:Colors.green,
                    statusBarIconBrightness: Brightness.light),
          toolbarHeight: 80,
                centerTitle: true,
                backgroundColor: const Color(0xff025B8F),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Image.asset('assets/pngs/htmlogo.png'),
                ),
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/appbar/Vector@2x.png',
                          height: 9,
                          width: 9,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'My Location',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          const Text(
                            '73 Newport Road, Carnbo',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          Image.asset(
                            'assets/appbar/Vector1.png',
                            height: 9,
                            width: 9,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                actions: [
                  SvgPicture.asset('assets/appbar/heart.svg'),
                  const SizedBox(width: 10),
                  SvgPicture.asset('assets/appbar/Notification.svg'),
                  const SizedBox(width: 10),
                ],
              ),
        backgroundColor: bgColor,
        bottomNavigationBar: Stack(
          children: [
            // Add your home screen widget here
            if (selectBtn == 0) HomeScreen(),
            if(selectBtn == 1) ExploreScreen(),
            if(selectBtn == 2) SearchScreen(),
            if(selectBtn == 3) ChatScreen(),
            if(selectBtn == 4) ProfileScreen(),
            Align(
              alignment: Alignment.bottomCenter,
              child: navigationBar(),
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 10.h,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 0.0),
          topRight:
          Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 0.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < navBtn.length; i++)
            GestureDetector(
              onTap: () => setState(() => selectBtn = i),
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox
  iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      width: 8.h,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: AnimatedContainer(
                height: height,
                width: width,
                duration: const Duration(milliseconds: 600),
                child: isActive
                    ? CustomPaint(
                  painter: ButtonNotch(),
                )
                    : const SizedBox(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: isActive ? SvgPicture.asset(
                height: 20,
                width: 40,
                navBtn2[i].imagePath,
                color: isActive ? selectColor : black,
                // scale: 2,
              ) : SvgPicture.asset(
                height: 20,
                width: 40,
                navBtn[i].imagePath,
                color: isActive ? selectColor : black,
                // scale: 2,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                navBtn[i].name,
                style: isActive ? bntText.copyWith(color: selectColor) : bntText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}