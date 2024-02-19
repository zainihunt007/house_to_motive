import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/controller/event_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../views/screens/home_screens/home_model.dart';
import '../../ArcadeScreen.dart';

class FavEvents extends StatefulWidget {
  const FavEvents({super.key});

  @override
  State<FavEvents> createState() => _FavEventsState();
}

class _FavEventsState extends State<FavEvents> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    TicketController ticketController = Get.put(TicketController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('favorites')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No favorite events found.'),
                );
              } else {
                List<String> favoriteEventIds =
                    snapshot.data!.docs.map((doc) => doc.id).toList();

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: favoriteEventIds.length,
                  itemBuilder: (context, index) {
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('tickets')
                          .doc(favoriteEventIds[index])
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<DocumentSnapshot> eventSnapshot) {
                        if (eventSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox
                              .shrink(); // or a placeholder widget
                        }

                        if (!eventSnapshot.hasData ||
                            !eventSnapshot.data!.exists) {
                          return const SizedBox
                              .shrink(); // or a placeholder widget
                        }

                        DocumentSnapshot doc = eventSnapshot.data!;
                        // bool isFavorite = favoriteEventIds.contains(doc.id);
                        String eventName = doc['eventName'];
                        String photoURL = doc['photoURL'];
                        String description = doc['description'];
                        String startTime = doc['startTime'];
                        String endTime = doc['endTime'];
                        String location = doc['location'];
                        Timestamp date = doc['date'];
                        bool isPrivate = doc['private'] ?? false;
                        RxBool isFavorite =
                            favoriteEventIds.contains(doc.id).obs;

                        if (isPrivate) {
                          return Container(); // Skip rendering this event if it's private
                        }

                        // Rest of your existing code for displaying each event...
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
                                  familyPrice: '',
                                  childPrice: '',
                                  adultPrice: '',
                                ),
                              );
                            },
                            child: Stack(
                              children: [
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: Container(
                                        height: screenHeight * 0.32,
                                        width: screenWidth / 1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                        style:
                                                            GoogleFonts.inter(
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
                                                        style:
                                                            GoogleFonts.inter(
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                        style:
                                                            GoogleFonts.inter(
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
                                                        style:
                                                            GoogleFonts.inter(
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
                                                        style:
                                                            GoogleFonts.inter(
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
                                                        style:
                                                            GoogleFonts.inter(
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
                                                if (isFavorite.value) {
                                                  // Remove from favorites
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .collection('favorites')
                                                      .doc(doc.id)
                                                      .delete();
                                                } else {
                                                  // Add to favorites
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.uid)
                                                      .collection('favorites')
                                                      .doc(doc.id)
                                                      .set({});
                                                }
                                                // Refresh the favorite list
                                                // setState(() {});
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
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.only(left: 12, right: 12),
// child: FutureBuilder(
// future: FirebaseFirestore.instance
//     .collection('tickets')
//     .where('isEventFavourite', isEqualTo: true)
//     .get(),
// builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return const Center(child: CircularProgressIndicator(),);
// } else if (snapshot.hasError) {
// return Text('Error: ${snapshot.error}');
// } else {
// List<DocumentSnapshot> docs = snapshot.data!.docs;
// return ListView.builder(
// shrinkWrap: true,
// physics: const NeverScrollableScrollPhysics(),
// itemCount: docs.length,
// itemBuilder: (context, index) {
// DocumentSnapshot doc = docs[index];
// String eventName = doc['eventName'];
// String photoURL = doc['photoURL'];
// String description = doc['description'];
// String startTime = doc['startTime'];
// String endTime = doc['endTime'];
// String location = doc['location'];
// Timestamp date = doc['date'];
// bool isPrivate = doc['private'] ?? false;
// RxBool isFavorite = RxBool(doc['isEventFavourite']);
// //
// // if (isPrivate) {
// //   return Container(); // Skip rendering this event if it's private
// // }
//
// return GestureDetector(
// onTap: () {
// Get.to(
// () => ArcadeScreen(
// description: description,
// photoURL: photoURL,
// startTime: startTime,
// endTime: endTime,
// eventName: eventName,
// location: location,
// date: date,
// ),
// );
// },
// child: Stack(
// children: [
// Stack(
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(vertical: 12),
// child: Container(
// height: screenHeight * 0.32,
// width: screenWidth / 1,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(8),
// color: Colors.white,
// ),
// child: Padding(
// padding: const EdgeInsets.all(6.0),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Column(
// mainAxisAlignment:
// MainAxisAlignment.end,
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Text(
// eventName,
// style: GoogleFonts.inter(
// fontWeight: FontWeight.w700,
// color: Colors.black,
// fontSize: 14,
// ),
// ),
// SizedBox(height: 0.3.h),
// Row(
// children: [
// GradientText(
// text: "+200 Going",
// gradient: const LinearGradient(
// colors: [
// Color(0xffFF0092),
// Color(0xff216DFD),
// ],
// ),
// style: GoogleFonts.inter(
// fontWeight: FontWeight.w400,
// fontSize: 10,
// ),
// ),
// ],
// ),
// SizedBox(height: 0.3.h),
// Row(
// children: [
// SvgPicture.asset(
// 'assets/svgs/home/map-pin.svg'),
// const SizedBox(width: 3),
// Text(
// 'Description',
// style: GoogleFonts.inter(
// fontWeight: FontWeight.w400,
// color:
// const Color(0xff7390A1),
// fontSize: 10,
// ),
// ),
// ],
// ),
// ],
// ),
// Column(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Container(),
// const Spacer(),
// Row(
// children: [
// Image.asset(
// 'assets/pngs/Vector.png'),
// const SizedBox(width: 3),
// Text(
// 'Trending',
// style: GoogleFonts.inter(
// fontSize: 10,
// color:
// const Color(0xff025B8F),
// fontWeight: FontWeight.w400,
// ),
// ),
// const SizedBox(width: 10),
// Image.asset(
// 'assets/pngs/material-symbols_upcoming-outline.png'),
// const SizedBox(width: 3),
// Text(
// 'Trending',
// style: GoogleFonts.inter(
// fontSize: 10,
// color:
// const Color(0xff025B8F),
// fontWeight: FontWeight.w400,
// ),
// ),
// ],
// ),
// SizedBox(height: 1.h),
// Row(
// children: [
// Image.asset(
// 'assets/pngs/majesticons_music.png'),
// const SizedBox(width: 3),
// Text(
// 'Hip-hop',
// style: GoogleFonts.inter(
// fontSize: 10,
// color:
// const Color(0xff025B8F),
// fontWeight: FontWeight.w400,
// ),
// ),
// const SizedBox(width: 10),
// Image.asset(
// 'assets/pngs/majesticons_music-line.png'),
// const SizedBox(width: 3),
// Text(
// 'Hot',
// style: GoogleFonts.inter(
// fontSize: 10,
// color:
// const Color(0xff025B8F),
// fontWeight: FontWeight.w400,
// ),
// ),
// ],
// ),
// SizedBox(height: 1.h),
// ],
// ),
// ],
// ),
// ),
// ),
// ),
// Container(
// height: screenHeight * 0.25,
// width: Get.width / 1,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(8),
// image: DecorationImage(
// fit: BoxFit.fill,
// image: NetworkImage(
// photoURL,
// ),
// ),
// ),
// child: Obx(
// () => Padding(
// padding: const EdgeInsets.all(12),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// GestureDetector(
// onTap: () async{
// isFavorite.toggle();
// await FirebaseFirestore.instance
//     .collection('tickets')
//     .doc(doc.id) // Assuming documentId is the document ID
//     .update({
// 'isEventFavourite': isFavorite.value,
// });                                          },
// child: CircleAvatar(
// backgroundColor:
// const Color(0xff80FFFFFF),
// radius: 16,
// child: Icon(
// size: 2.5.h,
// isFavorite.value
// ? Icons.favorite
//     : Icons.favorite_border,
// color: Colors
//     .red, // Customize the color as needed
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// ],
// ),
// ],
// ),
// );
// },
// );
// }
// },
// ),
// ),

// Padding(
// padding: const EdgeInsets.only(left: 12, right: 12),
// child: SingleChildScrollView(
// child: Column(
// children: itemList.map((item) {
// return Stack(
// children: [
// Padding(
// padding: const EdgeInsets.symmetric(vertical: 12),
// child: Container(
// height: screenHeight * 0.32,
// width: screenWidth / 1,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(8),
// color: Colors.white,
// ),
// child: Padding(
// padding: const EdgeInsets.all(6.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// item['title']!,
// style: GoogleFonts.inter(
// fontWeight: FontWeight.w700,
// color: Colors.black,
// fontSize: 14,
// ),
// ),
// const SizedBox(height: 3),
// Row(
// children: [
// GradientText(
// text: "+200 Going",
// gradient: const LinearGradient(
// colors: [
// Color(0xffFF0092),
// Color(0xff216DFD),
// ],
// ),
// style: GoogleFonts.inter(
// fontWeight: FontWeight.w400,
// fontSize: 10,
// ),
// ),
// ],
// ),
// const SizedBox(height: 3),
// Row(
// children: [
// SvgPicture.asset(
// 'assets/svgs/home/map-pin.svg'),
// const SizedBox(width: 3),
// Text(
// item['description']!,
// style: GoogleFonts.inter(
// fontWeight: FontWeight.w400,
// color: const Color(0xff7390A1),
// fontSize: 10,
// ),
// ),
// ],
// ),
// ],
// ),
// Column(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(),
// const Spacer(),
// Row(
// children: [
// Image.asset('assets/pngs/Vector.png'),
// const SizedBox(width: 3),
// Text(
// 'Trending',
// style: GoogleFonts.inter(
// fontSize: 10,
// color: const Color(0xff025B8F),
// fontWeight: FontWeight.w400,
// ),
// ),
// const SizedBox(width: 10),
// Image.asset(
// 'assets/pngs/material-symbols_upcoming-outline.png'),
// const SizedBox(width: 3),
// Text(
// 'Trending',
// style: GoogleFonts.inter(
// fontSize: 10,
// color: const Color(0xff025B8F),
// fontWeight: FontWeight.w400,
// ),
// ),
// ],
// ),
// const SizedBox(height: 10),
// Row(
// children: [
// Image.asset(
// 'assets/pngs/majesticons_music.png'),
// const SizedBox(width: 3),
// Text(
// 'Hip-hop',
// style: GoogleFonts.inter(
// fontSize: 10,
// color: const Color(0xff025B8F),
// fontWeight: FontWeight.w400,
// ),
// ),
// const SizedBox(width: 10),
// Image.asset(
// 'assets/pngs/majesticons_music-line.png'),
// const SizedBox(width: 3),
// Text(
// 'Hot',
// style: GoogleFonts.inter(
// fontSize: 10,
// color: const Color(0xff025B8F),
// fontWeight: FontWeight.w400,
// ),
// ),
// ],
// ),
// const SizedBox(height: 10),
// ],
// ),
// ],
// ),
// ),
// ),
// ),
// Container(
// height: screenHeight * 0.25,
// width: Get.width / 1,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(8),
// image: DecorationImage(
// fit: BoxFit.fill,
// image: NetworkImage(
// // foodnearby[index].image,
// item['image']!,
// ),
// ),
// // color: Colors.white,
// ),
// child: Padding(
// padding: const EdgeInsets.all(12),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.end,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// CircleAvatar(
// backgroundColor: const Color(0xff80FFFFFF),
// radius: 16,
// child:
// SvgPicture.asset('assets/svgs/home/Vector.svg'),
// ),
// ],
// ),
// ),
// ),
// ],
// );
// }).toList(),
// ),
// ),
// ),

// FirebaseFirestore.instance
//     .collection('tickets')
// .where('isFavorite',
// isEqualTo:
// true) // Add this line to filter events with private set to false
//     .snapshots(),
