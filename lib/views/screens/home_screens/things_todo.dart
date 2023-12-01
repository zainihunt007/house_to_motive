import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/home_screens/video_playing_screen.dart';
import 'package:house_to_motive/views/screens/video_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../mrg/ArcadeScreen.dart';
import '../../../mrg/Sanzio_Restaurant.dart';
import 'home_model.dart';

class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.03),
          // SizedBox(
          //   height: 35,
          //   width: MediaQuery.of(context).size.width,
          //   child: ListView.builder(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: tags.length,
          //     itemBuilder: (context, index) {
          //       return Obx(
          //         () => GestureDetector(
          //           onTap: () {
          //             for (int i = 0; i < isSelected.length; i++) {
          //               isSelected[i].value = (i == index);
          //             }
          //           },
          //           child: Container(
          //             margin: EdgeInsets.all(4),
          //             padding: EdgeInsets.symmetric(horizontal: 8),
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.black26),
          //               borderRadius: BorderRadius.circular(12),
          //               color: isSelected[index].value ? Color(0xff025B8F) : null,
          //             ),
          //             child: Center(
          //               child: Text(
          //                 tags[index],
          //                 style: TextStyle(
          //                   color:
          //                       isSelected[index].value ? Colors.white : Color(0xff7390A1),
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              children: [
                Text(
                  'Nearby Me',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const Spacer(),
                InkWell(
                    onTap: (){
                      Get.to(() => VideoScreen());
                    },
                    child: SvgPicture.asset('assets/svgs/home/Group 1171274839.svg')),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: SizedBox(
              height: screenHeight * 0.16,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userDataList.length,
                itemBuilder: (context, index) {
                  UserData userData = userDataList[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(userData.image),
                          maxRadius: 5.h,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          userData.username.length <= 8
                              ? userData.username
                              : '${userData.username.substring(0, 6)}..',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // SizedBox(height: 0.5.h),
                        Text(
                          '(${userData.miles} miles)',
                          style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff7390A1)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              children: [
                Text(
                  'Latest Videos',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const Spacer(),
                InkWell(
                    onTap: (){
                      Get.to(() => VideoScreen());
                    },
                    child: SvgPicture.asset('assets/svgs/home/Group 1171274839.svg')),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Best match nearby you - watch and explore',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff7390A1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          SizedBox(
            height: screenHeight * 0.25,
            // height: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: latestVideoUrls.length,
                itemBuilder: (context, index) {
                  // VideoUrls vdourls = videoUrls[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => VideoPlayerScreen(
                            videoUrl: latestVideoUrls[index].videoUrl,
                            image: latestVideoUrls[index].image),
                      );
                    },
                    child: Container(
                      width: 10.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(latestVideoUrls[index].image),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(),
                          Container(),
                          Image.asset(
                              'assets/svgs/home/icon-park-solid_play.png'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              children: [
                Text(
                  'Videos',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const Spacer(),
                InkWell(
                    onTap: (){
                      Get.to(() => VideoScreen());
                    },
                    child: SvgPicture.asset('assets/svgs/home/Group 1171274839.svg')),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Best match nearby you - watch and explore',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff7390A1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          SizedBox(
            height: screenHeight * 0.25,
            // height: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.6,
                ),
                itemCount: randomVideosUrls.length,
                itemBuilder: (context, index) {
                  // VideoUrls vdourls = videoUrls[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => VideoPlayerScreen(
                            videoUrl: randomVideosUrls[index].videoUrl,
                            image: randomVideosUrls[index].image),
                      );
                    },
                    child: Container(
                      width: 10.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(randomVideosUrls[index].image),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(),
                          Container(),
                          Image.asset(
                              'assets/svgs/home/icon-park-solid_play.png'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              children: [
                Text(
                  'Food Nearby You',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                InkWell(
                    onTap: (){
                      Get.to(() => VideoScreen());
                    },
                    child: SvgPicture.asset('assets/svgs/home/Group 1171274839.svg')),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Best match nearby you - watch and explore',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff7390A1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          SizedBox(
            height: screenHeight * 0.25,
            // height: 250,
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: foodnearby.length,
                itemBuilder: (context, index) {
                  // VideoUrls vdourls = videoUrls[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => SanzioRestaurant());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Stack(
                        children: [
                          Container(
                            height: screenHeight * 0.26,
                            width: Get.width / 1.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // SizedBox(height: 1.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        foodnearby[index].city,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '\$${foodnearby[index].price}',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff025B8F),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 0.3.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      GradientText(
                                        text: "${foodnearby[index].mile} mile",
                                        gradient: const LinearGradient(colors: [
                                          Color(0xffFF0092),
                                          Color(0xff216DFD),
                                        ]),
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 0.3.h),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/svgs/home/map-pin.svg'),
                                      SizedBox(width: 0.3.h),
                                      Text(
                                        foodnearby[index].location,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff7390A1),
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height / 6,
                            width: Get.width / 1.8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  foodnearby[index].image,
                                ),
                              ),
                              // color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 3.5.h,
                                    width: 8.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: const Color(0xff80FFFFFF),
                                        border:
                                            Border.all(color: Colors.white60)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/home/Star 2.svg'),
                                        Text(
                                          foodnearby[index].rating,
                                          style: GoogleFonts.inter(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: const Color(0xff80FFFFFF),
                                    radius: 16,
                                    child: SvgPicture.asset(
                                        'assets/svgs/home/Vector.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              children: [
                Text(
                  'Events',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const Spacer(),
                InkWell(
                    onTap: (){
                      Get.to(() => VideoScreen());
                    },
                    child: SvgPicture.asset('assets/svgs/home/Group 1171274839.svg')),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Best match nearby you - watch and explore',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff7390A1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          GestureDetector(
            onTap: () {
              Get.to(() => ArcadeScreen());
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: Column(
                children: itemList.map((item) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Container(
                          height: screenHeight * 0.32,
                          width: screenWidth / 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title']!,
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 0.3.h),
                                    Row(
                                      children: [
                                        GradientText(
                                          text: "+200 Going",
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xffFF0092),
                                              Color(0xff216DFD),
                                            ],
                                          ),
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 0.3.h),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/home/map-pin.svg'),
                                        const SizedBox(width: 3),
                                        Text(
                                          item['description']!,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff7390A1),
                                            fontSize: 10,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Image.asset('assets/pngs/Vector.png'),
                                        const SizedBox(width: 3),
                                        Text(
                                          'Trending',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            color: const Color(0xff025B8F),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Image.asset(
                                            'assets/pngs/material-symbols_upcoming-outline.png'),
                                        const SizedBox(width: 3),
                                        Text(
                                          'Trending',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            color: const Color(0xff025B8F),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/pngs/majesticons_music.png'),
                                        const SizedBox(width: 3),
                                        Text(
                                          'Hip-hop',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            color: const Color(0xff025B8F),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Image.asset(
                                            'assets/pngs/majesticons_music-line.png'),
                                        const SizedBox(width: 3),
                                        Text(
                                          'Hot',
                                          style: GoogleFonts.inter(
                                            fontSize: 10,
                                            color: const Color(0xff025B8F),
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 1.h),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: screenHeight * 0.25,
                        width: Get.width / 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              // foodnearby[index].image,
                              item['image']!,
                            ),
                          ),
                          // color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: const Color(0xff80FFFFFF),
                                radius: 16,
                                child: SvgPicture.asset(
                                    'assets/svgs/home/Vector.svg'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }
}
