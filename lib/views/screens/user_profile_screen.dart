import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../mrg/screens/Favourites/newFav.dart';
import 'notification_screen.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff025B8F),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 19,
          ),
        ),
        title: Text(
          'Sabir’s Profile',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.to(() => FavList());
              },
              child: SvgPicture.asset('assets/appbar/heart.svg')),
          const SizedBox(width: 10),
          GestureDetector(
              onTap: () {
                Get.to(() => const NotificationScreen());
              },
              child: SvgPicture.asset('assets/appbar/Notification.svg')),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: 10.px,
            ),
            Container(
              height: Get.height / 6,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black,
                        ),
                        Text(
                          'Sabir Khan',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'UI UX Designer',
                          style: GoogleFonts.inter(
                            color: Color(0xff7390A1),
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30.px),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50.px,
                              // width: 50.px,
                              // color: Colors.black,
                              child: Column(
                                children: [
                                  Text(
                                    'Followers',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff7390A1),
                                    ),
                                  ),
                                  Text(
                                    '748',
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff025B8F),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.px),
                            SizedBox(
                              height: 50.px,
                              // width: 50.px,
                              // color: Colors.black,
                              child: Column(
                                children: [
                                  Text(
                                    'Followings',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff7390A1),
                                    ),
                                  ),
                                  Text(
                                    '839',
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff025B8F),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.px),
                            SizedBox(
                              height: 50.px,
                              // width: 50.px,
                              // color: Colors.black,
                              child: Column(
                                children: [
                                  Text(
                                    'Posts',
                                    style: GoogleFonts.inter(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff7390A1),
                                    ),
                                  ),
                                  Text(
                                    '52',
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff025B8F),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 25,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff025B8F), width: 1),
                                  borderRadius: BorderRadius.circular(20.px),
                                ),
                                child: Center(
                                  child: Text(
                                    'Chat',
                                    style: TextStyle(
                                      fontFamily: 'ProximaNova',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff025B8F),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20.px),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 25,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff025B8F), width: 1),
                                  borderRadius: BorderRadius.circular(20.px),
                                ),
                                child: Center(
                                  child: Text(
                                    'Follow',
                                    style: TextStyle(
                                      fontFamily: 'ProximaNova',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff025B8F),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.px,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: 0.8,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                              image: NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7TVrffjrHepe_Fh-vP_EByglUKU9MA1mmkYa17rr31Q&s'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Center(
                          child: Image.asset(
                            'assets/assets2/Video_images/platbtn.png',
                            height: 2.5.h,
                            width: 2.5.h,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
