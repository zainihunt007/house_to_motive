import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../../../mrg/ArcadeScreen.dart';
import '../custom_marker.dart';
import 'home_model.dart';

class EventsNearmeScreen extends StatefulWidget {
  const EventsNearmeScreen({super.key});

  @override
  State<EventsNearmeScreen> createState() => _EventsNearmeScreenState();
}

class _EventsNearmeScreenState extends State<EventsNearmeScreen> {
  List<TicketInfo> nearbyTickets = [];

  @override
  void initState() {
    super.initState();
    checkNearbyTickets();
  }

  bool isLoading = true; // Add a boolean variable to track loading state

  Future<void> checkNearbyTickets() async {
    setState(() {
      isLoading =
          true; // Set loading state to true when fetching tickets starts
    });

    Position currentPosition = await _determinePosition();

    FirebaseFirestore.instance
        .collection('tickets')
        .where('private', isEqualTo: false)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((ticket) async {
        String ticketLocationAddress = ticket.get('location');
        List<Location> locations =
            await locationFromAddress(ticketLocationAddress);

        if (locations.isNotEmpty) {
          Location ticketLocation = locations.first;
          double distance = Geolocator.distanceBetween(
            currentPosition.latitude,
            currentPosition.longitude,
            ticketLocation.latitude,
            ticketLocation.longitude,
          );

          if (distance <= 1000) {
            setState(() {
              nearbyTickets.add(TicketInfo(
                id: ticket.id,
                eventName: ticket.get('eventName'),
                photoURL: ticket.get('photoURL'),
                location: ticket.get('location'),
                date: ticket.get('date'),
                familyPrice: ticket.get('familyPrice'),
                startTime: ticket.get('startTime'),
                endTime: ticket.get('endTime'),
                childPrice: ticket.get('childPrice'),
                adultPrice: ticket.get('adultPrice'),
                description: ticket.get('description'),
              ));
            });
          }
        }
      });

      setState(() {
        isLoading =
            false; // Set loading state to false when fetching tickets is completed
      });
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              children: [
                Text(
                  'Upcoming Events',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const Spacer(),
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
                  'Events in this week',
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
          isLoading
              ? SizedBox(
                  // height: screenHeight * 0.32,
                  width: screenWidth / 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 1, // Number of shimmer items
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            height: screenHeight * 0.27,
                            width: screenWidth / 1,
                            // margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Center(
                  //   child: CircularProgressIndicator(),
                  // ),
                )
              : nearbyTickets.isEmpty
                  ? const Center(child: Text('No nearby tickets found.'))
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: nearbyTickets.length,
                      itemBuilder: (context, index) {
                        TicketInfo ticket = nearbyTickets[index];
                        RxBool isFavorite = false.obs;
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ArcadeScreen(
                                photoURL: ticket.photoURL,
                                eventName: ticket.eventName,
                                location: ticket.location,
                                adultPrice: ticket.adultPrice,
                                childPrice: ticket.childPrice,
                                date: ticket.date,
                                endTime: ticket.endTime,
                                familyPrice: ticket.familyPrice,
                                description: ticket.description,
                                startTime: ticket.startTime,
                              ),
                            );

                            // Get.to(
                            //   () => DataTransfer(
                            //     name: ticket.eventName,
                            //     photoUrl: ticket.photoURL,
                            //     location: ticket.location,
                            //     date: ticket.date,
                            //   ),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: Stack(
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
                                                ticket.eventName.length > 35
                                                    ? ticket.eventName
                                                            .substring(0, 35) +
                                                        '..'
                                                    : ticket.eventName,
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
                                                    ticket.location.length > 30
                                                        ? ticket.location
                                                                .substring(
                                                                    0, 30) +
                                                            '..'
                                                        : ticket.location,
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
                                              // Row(
                                              //   children: [
                                              //     Image.asset(
                                              //         'assets/pngs/Vector.png'),
                                              //     const SizedBox(width: 3),
                                              //     Text(
                                              //       'Trending',
                                              //       style: GoogleFonts.inter(
                                              //         fontSize: 10,
                                              //         color: const Color(
                                              //             0xff025B8F),
                                              //         fontWeight:
                                              //             FontWeight.w400,
                                              //       ),
                                              //     ),
                                              //     const SizedBox(width: 10),
                                              //     Image.asset(
                                              //         'assets/pngs/material-symbols_upcoming-outline.png'),
                                              //     const SizedBox(width: 3),
                                              //     Text(
                                              //       'Trending',
                                              //       style: GoogleFonts.inter(
                                              //         fontSize: 10,
                                              //         color: const Color(
                                              //             0xff025B8F),
                                              //         fontWeight:
                                              //             FontWeight.w400,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(height: 1.h),
                                              // Row(
                                              //   children: [
                                              //     Image.asset(
                                              //         'assets/pngs/majesticons_music.png'),
                                              //     const SizedBox(width: 3),
                                              //     Text(
                                              //       'Hip-hop',
                                              //       style: GoogleFonts.inter(
                                              //         fontSize: 10,
                                              //         color: const Color(
                                              //             0xff025B8F),
                                              //         fontWeight:
                                              //             FontWeight.w400,
                                              //       ),
                                              //     ),
                                              //     const SizedBox(width: 10),
                                              //     Image.asset(
                                              //         'assets/pngs/majesticons_music-line.png'),
                                              //     const SizedBox(width: 3),
                                              //     Text(
                                              //       'Hot',
                                              //       style: GoogleFonts.inter(
                                              //         fontSize: 10,
                                              //         color: const Color(
                                              //             0xff025B8F),
                                              //         fontWeight:
                                              //             FontWeight.w400,
                                              //       ),
                                              //     ),
                                              //   ],
                                              // ),
                                              // SizedBox(height: 1.h),
                                            ],
                                          ),
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
                                        ticket.photoURL,
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
                                            // log(doc.id.toString());
                                            // await FirebaseFirestore.instance
                                            //     .collection('users')
                                            //     .doc(userId)
                                            //     .collection('favorites')
                                            //     .doc(doc.id)
                                            //     .set({
                                            //   'isFavorite': isFavorite.value
                                            // });
                                          },
                                          child: Obx(
                                            () => CircleAvatar(
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
          // Padding(
          //   padding: const EdgeInsets.only(left: 12, right: 12),
          //   child: Column(
          //     children: itemList.map((item) {
          //       return Stack(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.symmetric(vertical: 12),
          //             child: Container(
          //               height: screenHeight * 0.32,
          //               width: screenWidth / 1,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(8),
          //                 color: Colors.white,
          //               ),
          //               child: Padding(
          //                 padding: const EdgeInsets.all(6.0),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Column(
          //                       mainAxisAlignment: MainAxisAlignment.end,
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Text(
          //                           item['title']!,
          //                           style: GoogleFonts.inter(
          //                             fontWeight: FontWeight.w700,
          //                             color: Colors.black,
          //                             fontSize: 14,
          //                           ),
          //                         ),
          //                         const SizedBox(height: 3),
          //                         Row(
          //                           children: [
          //                             GradientText(
          //                               text: "+200 Going",
          //                               gradient: const LinearGradient(
          //                                 colors: [
          //                                   Color(0xffFF0092),
          //                                   Color(0xff216DFD),
          //                                 ],
          //                               ),
          //                               style: GoogleFonts.inter(
          //                                 fontWeight: FontWeight.w400,
          //                                 fontSize: 10,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                         const SizedBox(height: 3),
          //                         Row(
          //                           children: [
          //                             SvgPicture.asset(
          //                                 'assets/svgs/home/map-pin.svg'),
          //                             const SizedBox(width: 3),
          //                             Text(
          //                               item['description']!,
          //                               style: GoogleFonts.inter(
          //                                 fontWeight: FontWeight.w400,
          //                                 color: const Color(0xff7390A1),
          //                                 fontSize: 10,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ],
          //                     ),
          //                     Column(
          //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                       crossAxisAlignment: CrossAxisAlignment.start,
          //                       children: [
          //                         Container(),
          //                         const Spacer(),
          //                         Row(
          //                           children: [
          //                             Image.asset('assets/pngs/Vector.png'),
          //                             const SizedBox(width: 3),
          //                             Text(
          //                               'Trending',
          //                               style: GoogleFonts.inter(
          //                                 fontSize: 10,
          //                                 color: const Color(0xff025B8F),
          //                                 fontWeight: FontWeight.w400,
          //                               ),
          //                             ),
          //                             const SizedBox(width: 10),
          //                             Image.asset(
          //                                 'assets/pngs/material-symbols_upcoming-outline.png'),
          //                             const SizedBox(width: 3),
          //                             Text(
          //                               'Trending',
          //                               style: GoogleFonts.inter(
          //                                 fontSize: 10,
          //                                 color: const Color(0xff025B8F),
          //                                 fontWeight: FontWeight.w400,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                         const SizedBox(height: 10),
          //                         Row(
          //                           children: [
          //                             Image.asset(
          //                                 'assets/pngs/majesticons_music.png'),
          //                             const SizedBox(width: 3),
          //                             Text(
          //                               'Hip-hop',
          //                               style: GoogleFonts.inter(
          //                                 fontSize: 10,
          //                                 color: const Color(0xff025B8F),
          //                                 fontWeight: FontWeight.w400,
          //                               ),
          //                             ),
          //                             const SizedBox(width: 10),
          //                             Image.asset(
          //                                 'assets/pngs/majesticons_music-line.png'),
          //                             const SizedBox(width: 3),
          //                             Text(
          //                               'Hot',
          //                               style: GoogleFonts.inter(
          //                                 fontSize: 10,
          //                                 color: const Color(0xff025B8F),
          //                                 fontWeight: FontWeight.w400,
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                         const SizedBox(height: 10),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //           Container(
          //             height: screenHeight * 0.25,
          //             width: Get.width / 1,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(8),
          //               image: DecorationImage(
          //                 fit: BoxFit.fill,
          //                 image: NetworkImage(
          //                   // foodnearby[index].image,
          //                   item['image']!,
          //                 ),
          //               ),
          //               // color: Colors.white,
          //             ),
          //             child: Padding(
          //               padding: const EdgeInsets.all(12),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   CircleAvatar(
          //                     backgroundColor: const Color(0xff80FFFFFF),
          //                     radius: 16,
          //                     child:
          //                     SvgPicture.asset('assets/svgs/home/Vector.svg'),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ),
          //         ],
          //       );
          //     }).toList(),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12),
            child: Row(
              children: [
                Text(
                  'Past Events',
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                const Spacer(),
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
                  'Event happened in Past',
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
                                  const SizedBox(height: 3),
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
                                  const SizedBox(height: 3),
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
                                  const SizedBox(height: 10),
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
                                  const SizedBox(height: 10),
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
          SizedBox(
            height: 12.h,
          ),
        ],
      ),
    );
  }
}
