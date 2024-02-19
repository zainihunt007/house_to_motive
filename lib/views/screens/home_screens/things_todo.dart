import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/controller/event_controller.dart';
import 'package:house_to_motive/views/screens/video_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../mrg/ArcadeScreen.dart';
import '../../../mrg/Sanzio_Restaurant.dart';
import 'home_model.dart';

class HomeScreen2 extends StatelessWidget {
  HomeScreen2({super.key});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  // Future<List<String>> fetchPublicVideoUrls() async {
  //   List<String> videoUrls = [];
  //   var videoRefs = await firestore.collection('public_videos').get();
  //
  //   for (var doc in videoRefs.docs) {
  //     String videoPath = doc.data()['videoPath'];
  //     String videoUrl = await storage.ref(videoPath).getDownloadURL();
  //     videoUrls.add(videoUrl);
  //   }
  //
  //   return videoUrls;
  // }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TicketController ticketController = Get.put(TicketController());
    return Column(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby Me',
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              InkWell(
                  onTap: () {
                    // Get.to(() => VideoScreen());
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
                            color: const Color(0xff7390A1)),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Latest Videos',
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              InkWell(
                  onTap: () {
                    // Get.to(() => VideoScreen());
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
                'Best match near me - watch and explore',
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
        // SizedBox(
        //   height: 31.25.h,
        //   // height: 250,
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 12),
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: latestVideoUrls.length,
        //       itemBuilder: (context, index) {
        //         // VideoUrls vdourls = videoUrls[index];
        //         return GestureDetector(
        //           onTap: () {
        //             // Get.to(
        //             //   () => VideoPlayerScreen(
        //             //       videoUrl: latestVideoUrls[index].videoUrl,
        //             //       image: latestVideoUrls[index].image),
        //             // );
        //
        //             // Get.to(() => VideoScreen ());
        //           },
        //           child: Container(
        //             width: 48.w, // Adjust width as needed
        //             // height: 50.h,
        //             margin: const EdgeInsets.symmetric(
        //                 horizontal: 4.0), // Adjust for spacing
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(8),
        //               color: Colors.grey,
        //               image: DecorationImage(
        //                 fit: BoxFit.fill,
        //                 image: NetworkImage(latestVideoUrls[index].image),
        //               ),
        //             ),
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //               children: [
        //                 Container(),
        //                 Container(),
        //                 Image.asset(
        //                   'assets/assets2/Video_images/platbtn.png',
        //                   height: 22,
        //                   width: 22,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 31.25.h,
            // height: 250,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
            ),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('videos')
                  .where('timestamp', isGreaterThanOrEqualTo: DateTime.now().toUtc().subtract(Duration(days: 1))) // Filter videos from the last 24 hours
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer effect while waiting for data
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10, // Number of shimmer items
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 48.w,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final documents = snapshot.data!.docs;
                List<String> videoThumbnailUrls = [];
                List<String> videoUrls = [];

                for (var doc in documents) {
                  videoThumbnailUrls.add(doc['thumbnailUrl']);
                  videoUrls.add(doc['videoUrl']);
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: videoThumbnailUrls.length,
                  itemBuilder: (context, index) {
                    // Show actual data
                    return GestureDetector(
                      onTap: () {
                        // Open VideoScreen with the selected video index
                        Get.to(() => VideoScreen(
                            videoUrls: videoUrls, initialIndex: index));
                      },
                      child: Container(
                        width: 48.w,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(videoThumbnailUrls[index]),
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
                );
              },
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Videos',
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              InkWell(
                onTap: () {
                  // Get.to(() => VideoScreen());
                },
                child:
                    SvgPicture.asset('assets/svgs/home/Group 1171274839.svg'),
              ),
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
                'Best match near me - watch and explore',
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
          height: 25.37.h,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 12,
            ),
            child: FutureBuilder(
              future: FirebaseFirestore.instance.collection('videos').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show shimmer effect while waiting for data
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10, // Number of shimmer items
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: 35.w,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                final documents = snapshot.data!.docs;
                List<String> videoThumbnailUrls = [];
                List<String> videoUrls = [];

                for (var doc in documents) {
                  videoThumbnailUrls.add(doc['thumbnailUrl']);
                  videoUrls.add(doc['videoUrl']);
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: videoThumbnailUrls.length,
                  itemBuilder: (context, index) {
                    // Show actual data
                    return GestureDetector(
                      onTap: () {
                        // Open VideoScreen with the selected video index
                        Get.to(() => VideoScreen(
                            videoUrls: videoUrls, initialIndex: index));
                      },
                      child: Container(
                        width: 35.w,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(videoThumbnailUrls[index]),
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
                );
              },
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Food Near Me',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              InkWell(
                  onTap: () {
                    // Get.to(() => VideoScreen());
                  },
                  child: SvgPicture.asset(
                      'assets/svgs/home/Group 1171274839.svg'),),
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
                'Best match near me - watch and explore',
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
                    Get.to(() => const SanzioRestaurant());
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
                                      '£${foodnearby[index].price}',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Events',
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              InkWell(
                  onTap: () {
                    // Get.to(() => VideoScreen());
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
                'Best match near me - watch and explore',
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
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<DocumentSnapshot> docs = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot doc = docs[index];
                    String eventName = doc['eventName'];
                    String photoURL = doc['photoURL'];
                    String description = doc['description'];
                    String startTime = doc['startTime'];
                    String endTime = doc['endTime'];
                    String location = doc['location'];
                    String familyPrice = doc['familyPrice'];
                    String childPrice = doc['childPrice'];
                    String adultPrice = doc['adultPrice'];
                    Timestamp date = doc['date'];
                    String organizerName = doc['userName'];
                    String organizerProfilePic = doc['userProfilePic'] ?? "";
                    bool isPrivate = doc['private'] ?? false;
                    String userId = FirebaseAuth.instance.currentUser!
                        .uid; // Assuming you're using Firebase Authentication
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

                    // if (isPrivate) {
                    //   return Container(); // Skip rendering this event if it's private
                    // }

                    return Obx(
                      () => GestureDetector(
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
                              familyPrice: familyPrice,
                              adultPrice: adultPrice,
                              childPrice: childPrice,
                              oragnizerName: organizerName,
                              OrganizerProfilePic: organizerProfilePic,
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
                                                eventName.length > 35
                                                    ? eventName.substring(
                                                            0, 35) +
                                                        '..'
                                                    : eventName,
                                                style: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              SizedBox(height: 0.3.h),
                                              // Row(
                                              //   children: [
                                              //     GradientText(
                                              //       text: "+200 Going",
                                              //       gradient:
                                              //           const LinearGradient(
                                              //         colors: [
                                              //           Color(0xffFF0092),
                                              //           Color(0xff216DFD),
                                              //         ],
                                              //       ),
                                              //       style: GoogleFonts.inter(
                                              //         fontWeight:
                                              //             FontWeight.w400,
                                              //         fontSize: 10,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              SizedBox(height: 0.3.h),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/svgs/home/map-pin.svg'),
                                                  const SizedBox(width: 3),
                                                  Text(
                                                    location.length > 30
                                                        ? location.substring(
                                                                0, 30) +
                                                            '..'
                                                        : location,
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
                                          // Column(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.spaceBetween,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Container(),
                                          //     const Spacer(),
                                          //     // Row(
                                          //     //   children: [
                                          //     //     Image.asset(
                                          //     //         'assets/pngs/Vector.png'),
                                          //     //     const SizedBox(width: 3),
                                          //     //     Text(
                                          //     //       'Trending',
                                          //     //       style: GoogleFonts.inter(
                                          //     //         fontSize: 10,
                                          //     //         color: const Color(
                                          //     //             0xff025B8F),
                                          //     //         fontWeight:
                                          //     //             FontWeight.w400,
                                          //     //       ),
                                          //     //     ),
                                          //     //     const SizedBox(width: 10),
                                          //     //     Image.asset(
                                          //     //         'assets/pngs/material-symbols_upcoming-outline.png'),
                                          //     //     const SizedBox(width: 3),
                                          //     //     Text(
                                          //     //       'Trending',
                                          //     //       style: GoogleFonts.inter(
                                          //     //         fontSize: 10,
                                          //     //         color: const Color(
                                          //     //             0xff025B8F),
                                          //     //         fontWeight:
                                          //     //             FontWeight.w400,
                                          //     //       ),
                                          //     //     ),
                                          //     //   ],
                                          //     // ),
                                          //     // SizedBox(height: 1.h),
                                          //     // Row(
                                          //     //   children: [
                                          //     //     Image.asset(
                                          //     //         'assets/pngs/majesticons_music.png'),
                                          //     //     const SizedBox(width: 3),
                                          //     //     Text(
                                          //     //       'Hip-hop',
                                          //     //       style: GoogleFonts.inter(
                                          //     //         fontSize: 10,
                                          //     //         color: const Color(
                                          //     //             0xff025B8F),
                                          //     //         fontWeight:
                                          //     //             FontWeight.w400,
                                          //     //       ),
                                          //     //     ),
                                          //     //     const SizedBox(width: 10),
                                          //     //     Image.asset(
                                          //     //         'assets/pngs/majesticons_music-line.png'),
                                          //     //     const SizedBox(width: 3),
                                          //     //     Text(
                                          //     //       'Hot',
                                          //     //       style: GoogleFonts.inter(
                                          //     //         fontSize: 10,
                                          //     //         color: const Color(
                                          //     //             0xff025B8F),
                                          //     //         fontWeight:
                                          //     //             FontWeight.w400,
                                          //     //       ),
                                          //     //     ),
                                          //     //   ],
                                          //     // ),
                                          //     // SizedBox(height: 1.h),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: screenHeight * 0.27,
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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                                .set({
                                              'isFavorite': isFavorite.value
                                            });
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                                const Color(0xff80ffffff),
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
                      ),
                    );
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
    );
  }
}
