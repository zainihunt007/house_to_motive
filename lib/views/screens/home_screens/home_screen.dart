import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/home_screens/video_playing_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_player/video_player.dart';

import '../../../widgets/home_widgets.dart';
import 'home_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // List<String> tags = [
  //   'All',
  //   'Concert',
  //   'Sport',
  //   'Festival',
  //   'Trade Shows',
  //   'videos',
  //   'Music'
  // ];

  // List<RxBool> isSelected = List<RxBool>.generate(7, (index) => false.obs);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff025B8F),
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
                SizedBox(width: 10),
                Text(
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
                  SizedBox(width: 10),
                  Text(
                    '73 Newport Road, Carnbo',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
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
          SizedBox(width: 10),
          SvgPicture.asset('assets/appbar/Notification.svg'),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                child: ButtonWidget(),
              ),
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
                    Spacer(),
                    SvgPicture.asset('assets/svgs/home/Group 1171274839.svg'),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: SizedBox(
                  height: screenHeight * 0.15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: userDataList.length,
                    itemBuilder: (context, index) {
                      UserData userData = userDataList[index];
                      return Padding(
                        padding: const EdgeInsets.only(left: 6, right: 6),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(userData.image),
                              maxRadius: 35,
                            ),
                            SizedBox(height: 5),
                            Text(
                              userData.username.length <= 10
                                  ? userData.username
                                  : '${userData.username.substring(0, 6)}..',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '(${userData.miles} miles)',
                              style: GoogleFonts.inter(
                                  fontSize: 10, fontWeight: FontWeight.w400),
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
                    GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                            'assets/svgs/home/Group 1171274839.svg')),
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
                        color: Color(0xff7390A1),
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          width: 100.0,
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
                    GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                            'assets/svgs/home/Group 1171274839.svg')),
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
                        color: Color(0xff7390A1),
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          width: 100.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  NetworkImage(randomVideosUrls[index].image),
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
                    GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                            'assets/svgs/home/Group 1171274839.svg')),
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
                        color: Color(0xff7390A1),
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
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.95,
                    ),
                    itemCount: foodnearby.length,
                    itemBuilder: (context, index) {
                      // VideoUrls vdourls = videoUrls[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Stack(
                          children: [
                            Container(
                              height: screenHeight * 0.26,
                              width: screenWidth / 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
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
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff025B8F),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GradientText(
                                          text:
                                              "${foodnearby[index].mile} mile",
                                          gradient: LinearGradient(colors: [
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
                                    SizedBox(height: 3),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/svgs/home/map-pin.svg'),
                                        SizedBox(width: 3),
                                        Text(
                                          foodnearby[index].location,
                                          style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff7390A1),
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
                              width: Get.width / 1,
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
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Color(0xff80FFFFFF),
                                          border: Border.all(
                                              color: Colors.white60)),
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
                                      backgroundColor: Color(0xff80FFFFFF),
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
                    GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                            'assets/svgs/home/Group 1171274839.svg')),
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
                        color: Color(0xff7390A1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Padding(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          GradientText(
                                            text: "+200 Going",
                                            gradient: LinearGradient(
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
                                      SizedBox(height: 3),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/svgs/home/map-pin.svg'),
                                          SizedBox(width: 3),
                                          Text(
                                            item['description']!,
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff7390A1),
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
                                      Spacer(),
                                      Row(
                                        children: [
                                          Image.asset('assets/pngs/Vector.png'),
                                          SizedBox(width: 3),
                                          Text(
                                            'Trending',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color: Color(0xff025B8F),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Image.asset('assets/pngs/material-symbols_upcoming-outline.png'),
                                          SizedBox(width: 3),
                                          Text(
                                            'Trending',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color: Color(0xff025B8F),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Image.asset('assets/pngs/majesticons_music.png'),
                                          SizedBox(width: 3),
                                          Text(
                                            'Hip-hop',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color: Color(0xff025B8F),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Image.asset('assets/pngs/majesticons_music-line.png'),
                                          SizedBox(width: 3),
                                          Text(
                                            'Hot',
                                            style: GoogleFonts.inter(
                                              fontSize: 10,
                                              color: Color(0xff025B8F),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
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
                                  backgroundColor: Color(0xff80FFFFFF),
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
              SizedBox(
                height: 12.h,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: Container(
          width: 48,
          height: 48,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xffFF0092),
                Color(0xff216DFD),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ListTile(
// leading: CircleAvatar(
// backgroundImage: AssetImage(userData.image),
// ),
// title: Text(userData.username),
// subtitle: Text('${userData.miles} miles'),
// // Add more widgets or customize the ListTile as needed
// );