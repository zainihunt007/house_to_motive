import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/controller/event_controller.dart';
import 'package:house_to_motive/views/screens/home_screens/video_playing_screen.dart';
import 'package:house_to_motive/views/screens/video_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../mrg/ArcadeScreen.dart';
import '../../../mrg/Sanzio_Restaurant.dart';
import 'home_model.dart';

class HomeScreen2 extends StatelessWidget {
   HomeScreen2({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<List<String>> fetchPublicVideoUrls() async {
    List<String> videoUrls = [];
    var videoRefs = await firestore.collection('public_videos').get();

    for (var doc in videoRefs.docs) {
      String videoPath = doc.data()['videoPath'];
      String videoUrl = await storage.ref(videoPath).getDownloadURL();
      videoUrls.add(videoUrl);
    }

    return videoUrls;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TicketController ticketController = Get.put(TicketController());
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
                    onTap: () {
                      Get.to(() => VideoScreen());
                    },
                    child: SvgPicture.asset(
                        'assets/svgs/home/Group 1171274839.svg')),
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
                    onTap: () {
                      Get.to(() => VideoScreen());
                    },
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
                      // Get.to(
                      //   () => VideoPlayerScreen(
                      //       videoUrl: latestVideoUrls[index].videoUrl,
                      //       image: latestVideoUrls[index].image),
                      // );

                      Get.to(() => VideoScreen ());
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
                            'assets/assets2/Video_images/platbtn.png',
                            height: 22,
                            width: 22,
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
                  'Videos',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const Spacer(),
                InkWell(
                    onTap: () {
                      Get.to(() => VideoScreen());
                    },
                    child: SvgPicture.asset(
                        'assets/svgs/home/Group 1171274839.svg'),),
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
            height: screenHeight * 0.25, // Adjust height as needed
            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: FutureBuilder(
                // Replace with your Firestore query to fetch the data
                future: FirebaseFirestore.instance.collection('videos').get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading indicator while fetching data
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final documents = snapshot.data!.docs;

                  // Create a list to store the thumbnail URLs
                  List<String> randomVideosUrls = [];

                  // Iterate through the documents and extract thumbnail URLs
                  for (var doc in documents) {
                    // Check if the document has a thumbnailUrl field
                    if (doc['thumbnailUrl'] != null) {
                      randomVideosUrls.add(doc['thumbnailUrl']);
                    }
                  }

                  return SizedBox(
                    height: screenHeight * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: randomVideosUrls.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigation logic
                            Get.to(() => VideoScreen());
                          },
                          child: Container(
                            width: 15.h,
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(randomVideosUrls[index]),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(),
                                Container(),
                                Image.asset('assets/svgs/home/icon-park-solid_play.png'),
                              ],
                            ),
                          ),
                        );
                      },
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
                    onTap: () {
                      Get.to(() => VideoScreen());
                    },
                    child: SvgPicture.asset(
                        'assets/svgs/home/Group 1171274839.svg')),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
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
            height: 26.h,
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
                    onTap: () {
                      Get.to(() => VideoScreen());
                    },
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
                    color: const Color(0xff7390A1),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('tickets')
                  .where('private', isEqualTo: false)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<DocumentSnapshot> docs = snapshot.data!.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot doc = docs[index];
                      String eventName = doc['eventName'];
                      String photoURL = doc['photoURL'];
                      String description = doc['description'];
                      String startTime = doc['startTime'];
                      String endTime = doc['endTime'];
                      String location = doc['location'];
                      Timestamp date = doc['date'];
                      bool isPrivate = doc['private'] ?? false;
                      String userId = FirebaseAuth.instance.currentUser!.uid; // Assuming you're using Firebase Authentication
                      RxBool isFavorite = RxBool(false);

                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(userId)
                          .collection('favorites')
                          .doc(doc.id)
                          .get()
                          .then((favoriteDoc) {
                        if (favoriteDoc.exists) {
                          isFavorite.value = favoriteDoc['isFavorite'];
                        }
                      });

                      if (isPrivate) {
                        return Container(); // Skip rendering this event if it's private
                      }

                      return Obx(() => GestureDetector(
                        onTap: () {
                          Get.to(
                                () => ArcadeScreen(
                              description: description,
                              photoURL: photoURL,
                              startTime: startTime,
                              endTime: endTime,
                              eventName: eventName,
                              location: location,
                              date: date,
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 12),
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
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                eventName,
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
                                                    gradient:
                                                    const LinearGradient(
                                                      colors: [
                                                        Color(0xffFF0092),
                                                        Color(0xff216DFD),
                                                      ],
                                                    ),
                                                    style: GoogleFonts.inter(
                                                      fontWeight:
                                                      FontWeight.w400,
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
                                                    'Description',
                                                    style: GoogleFonts.inter(
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color: const Color(
                                                          0xff7390A1),
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
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Container(),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      'assets/pngs/Vector.png'),
                                                  const SizedBox(width: 3),
                                                  Text(
                                                    'Trending',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xff025B8F),
                                                      fontWeight:
                                                      FontWeight.w400,
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
                                                      color: const Color(
                                                          0xff025B8F),
                                                      fontWeight:
                                                      FontWeight.w400,
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
                                                      color: const Color(
                                                          0xff025B8F),
                                                      fontWeight:
                                                      FontWeight.w400,
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
                                                      color: const Color(
                                                          0xff025B8F),
                                                      fontWeight:
                                                      FontWeight.w400,
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
                                        photoURL,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            isFavorite.toggle();
                                            log(doc.id.toString());
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userId)
                                                .collection('favorites')
                                                .doc(doc.id)
                                                .set({'isFavorite': isFavorite.value});
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                            const Color(0xff80FFFFFF),
                                            radius: 16,
                                            child: Icon(
                                              size: 2.5.h,
                                              isFavorite.value
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: Colors
                                                  .red, // Customize the color as needed
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),);
                    },
                  );
                }
              },
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

