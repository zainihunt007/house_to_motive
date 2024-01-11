import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:house_to_motive/views/screens/navigation_bar/text_style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../mrg/screens/Favourites/newFav.dart';
import '../explore_screen.dart';
import '../chat_screen.dart';
import '../home_screens/home_screen.dart';
import '../notification_screen.dart';
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
  List<String> selectedSvg = [
    'assets/selected/Home Filled.svg',
    'assets/selected/Explore Filled.svg',
    'assets/selected/Search Filled.svg',
    'assets/selected/My Chat Filled.svg',
    'assets/selected/My Profile.svg',
  ];
  List<String> unSelectedSvg = [
    'assets/unselected/Home.svg',
    'assets/unselected/Explore.svg',
    'assets/unselected/Search.svg',
    'assets/unselected/My Chat.svg',
    'assets/unselected/My Profile.svg',
  ];
  int currentIndex = 0;
  int selectBtn = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                  GestureDetector(
                      onTap: (){
                        Get.to(() => FavList());
                      },
                      child: SvgPicture.asset('assets/appbar/heart.svg')),
                  const SizedBox(width: 10),
                  GestureDetector(
                      onTap: (){
                        Get.to(() => NotificationScreen());
                      },
                      child: SvgPicture.asset('assets/appbar/Notification.svg')),
                  const SizedBox(width: 10),
                ],
              ),
        backgroundColor: bgColor,
        bottomNavigationBar: Stack(
          children: [
            if(currentIndex==0) HomeScreen(),
            if(currentIndex==1) ExploreScreen(),
            if(currentIndex==2)const SearchScreen(),
            if(currentIndex==3)const ChatScreen(),
            if(currentIndex==4) ProfileScreen(),
            Align(alignment: Alignment.bottomCenter,child:ClipPath(
              clipper: MyCustomClipper(currentIndex),
              child: Container(
                height: height*0.09,
                width: double.infinity,
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: width*0.06,top: height*0.02,right: width*0.06 ),
                  shrinkWrap: true,
                  itemCount: selectedSvg.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          child:currentIndex==index? SvgPicture.asset(selectedSvg[index]):SvgPicture.asset(unSelectedSvg[index]),
                        ),SizedBox(width:index==3?width *0.09:index==2?width *0.09:width *0.11,)
                      ],
                    );
                  },
                ),
              ),
            ),),


            Positioned(bottom: height*0.08,
                left: currentIndex == 0
                    ? width*0.09
                    : currentIndex == 1
                    ? width*0.29
                    : currentIndex == 2
                    ? width*0.49
                    : currentIndex == 3
                    ? width*0.69
                    : currentIndex == 4
                    ? width*0.89
                    : 0,
                child: Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xff025B8F)),
                )),
          ],
        ),
      ),
    );
  }
}
class MyCustomClipper extends CustomClipper<Path> {
  int? currentIndex;
  MyCustomClipper(this.currentIndex);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    if (currentIndex == 0) {
      path.quadraticBezierTo(
          size.width * 0.10, size.height * 0.50, size.width * 0.20, 0);
      path.lineTo(size.width * 0.20, 0);
      path.lineTo(size.width, 0);
    } else if (currentIndex == 1) {
      path.lineTo(size.width * 0.20, 0);

      path.quadraticBezierTo(
          size.width * 0.30, size.height * 0.50, size.width * 0.40, 0);
      path.lineTo(size.width * 0.40, 0);
      path.lineTo(size.width, 0);
    } else if (currentIndex == 2) {
      path.lineTo(size.width * 0.40, 0);
      path.quadraticBezierTo(
          size.width * 0.50, size.height * 0.50, size.width * 0.60, 0);
      path.lineTo(size.width * 0.60, 0);
      path.lineTo(size.width, 0);
    } else if (currentIndex == 3) {
      path.lineTo(size.width * 0.60, 0);
      path.quadraticBezierTo(
          size.width * 0.70, size.height * 0.50, size.width * 0.80, 0);
      path.lineTo(size.width * 0.80, 0);
      path.lineTo(size.width, 0);
    } else if (currentIndex == 4) {
      path.lineTo(size.width * 0.80, 0);
      path.quadraticBezierTo(
          size.width * 0.90, size.height * 0.50, size.width, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, 0);
    } else {
      path.quadraticBezierTo(
          size.width * 0.10, size.height * 0.50, size.width * 0.20, 0);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// AnimatedContainer navigationBar() {
//   return AnimatedContainer(
//     height: 10.h,
//     duration: const Duration(milliseconds: 400),
//     decoration: BoxDecoration(
//       color: white,
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 0.0),
//         topRight:
//         Radius.circular(selectBtn == navBtn.length - 1 ? 0.0 : 0.0),
//       ),
//     ),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         for (int i = 0; i < navBtn.length; i++)
//           GestureDetector(
//             onTap: () => setState(() => selectBtn = i),
//             child: iconBtn(i),
//           ),
//       ],
//     ),
//   );
// }
//
// SizedBox
// iconBtn(int i) {
//   bool isActive = selectBtn == i ? true : false;
//   var height = isActive ? 60.0 : 0.0;
//   var width = isActive ? 50.0 : 0.0;
//   return SizedBox(
//     width: 8.h,
//     child: Padding(
//       padding: const EdgeInsets.only(bottom: 10),
//       child: Stack(
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: AnimatedContainer(
//               height: height,
//               width: width,
//               duration: const Duration(milliseconds: 600),
//               child: isActive
//                   ? CustomPaint(
//                 painter: ButtonNotch(),
//               )
//                   : const SizedBox(),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: isActive ? SvgPicture.asset(
//               height: 20,
//               width: 40,
//               navBtn2[i].imagePath,
//               color: isActive ? selectColor : black,
//               // scale: 2,
//             ) : SvgPicture.asset(
//               height: 20,
//               width: 40,
//               navBtn[i].imagePath,
//               color: isActive ? selectColor : black,
//               // scale: 2,
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Text(
//               navBtn[i].name,
//               style: isActive ? bntText.copyWith(color: selectColor) : bntText,
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
