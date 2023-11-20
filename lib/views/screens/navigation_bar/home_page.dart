import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_to_motive/views/screens/navigation_bar/text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../home_screens/home_screen.dart';
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
    return Scaffold(
      // backgroundColor: bgColor,
      body: Stack(
        children: [
          // Add your home screen widget here
          if (selectBtn == 0) HomeScreen(),
          if(selectBtn == 1) ExploreScreen(),
          Align(
            alignment: Alignment.bottomCenter,
            child: navigationBar(),
          )
        ],
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

  SizedBox iconBtn(int i) {
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
class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement your home screen UI here
    return Center(
      child: Text(
        'Explore Screen',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}