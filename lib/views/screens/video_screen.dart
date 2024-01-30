import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../mrg/Review_Screen.dart';

class VideoScreen extends StatelessWidget {
  final videoUrl;
  VideoScreen(
      {super.key,
      this.videoUrl,
      required this.videoUrls,
      required this.initialIndex});
  final List<String> videoUrls;
  final int initialIndex;

  final videoLikecontroller = Get.put(VideoController());

  late final DocumentSnapshot videoDoc;

  void _shareContent() {
    Share.share('house_to_motive');
  }

  String? userId = FirebaseAuth.instance.currentUser?.uid;

  final CollectionReference videosCollection =
      FirebaseFirestore.instance.collection('videos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder<QuerySnapshot?>(
              future: videosCollection.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching videos'));
                }

                if (!snapshot.hasData ||
                    snapshot.data == null ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No videos found'));
                }

                List<DocumentSnapshot> videoDocs = snapshot.data!.docs;

                // List<DocumentSnapshot> videoDocs = snapshot.data!.docs;
                List videoLocations =
                    videoDocs.map((doc) => doc['location']).toList();
                // List<String> username =
                //     videoDocs.map((doc) => doc['username'].toString()).toList();
                List<String> userProfilePic = videoDocs
                    .map((doc) => doc['profileUrl'].toString())
                    .toList();

                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: videoUrls.length,
                  controller: PageController(initialPage: initialIndex),
                  itemBuilder: (context, index) {
                    var videoDoc = videoDocs[index];
                    videoLikecontroller.checkInitialLikeStatus(videoDoc.id);

                    return Stack(
                      children: [
                        VideoPlayerScreen(videoUrl: videoUrls[index]),
                        Obx(
                          () => SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Row(
                                  children: [],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: 30,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                child: AutoSizeText(
                                                  maxLines: 1,
                                                  'Lorem Lipsam',
                                                  // username[index],
                                                  style: GoogleFonts.inter(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '@NQ64 ARCADE',
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.white60,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Opening Time : 10: am to 2:00 AM',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white60,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            'Starting Price: \$9.99',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white60,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Row(
                                            children: [
                                              Image.asset(
                                                  'assets/pngs/Location.png'),
                                              const SizedBox(width: 10),
                                              Text(
                                                videoLocations[index].length <
                                                        30
                                                    ? videoLocations[index]
                                                    : videoLocations[index]
                                                            .substring(0, 30) +
                                                        '...',
                                                style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white60,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.02),
                                        ],
                                      ),
                                      Column(
                                        // mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Stack(
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.black,
                                                  backgroundImage: NetworkImage(
                                                      userProfilePic[index]),
                                                ),
                                              ),
                                              const Positioned(
                                                top: 40,
                                                right: 10,
                                                child: CircleAvatar(
                                                  radius: 6,
                                                  backgroundColor: Colors.white,
                                                  backgroundImage: AssetImage(
                                                      'assets/pngs/Subscribe button.png'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            height: 60,
                                            width: 46,
                                            // color: Colors.red,
                                            child: Column(
                                              children: [
                                                InkWell(
                                                    onTap: () =>
                                                        videoLikecontroller
                                                            .toggleLikeDislike(
                                                                videoDoc.id),
                                                    child: SvgPicture.asset(
                                                      'assets/svgs/Like icon.svg',
                                                      color: videoLikecontroller
                                                              .userLiked.value
                                                          ? Colors.red
                                                          : Colors.white,
                                                    )),
                                                Text(
                                                  videoLikecontroller.likesCount
                                                      .toString(),
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white60,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            height: 60,
                                            width: 46,
                                            // color: Colors.red,
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    openBottomSheet();
                                                  },
                                                  child: SvgPicture.asset(
                                                      'assets/svgs/comments.svg'),
                                                ),
                                                Text(
                                                  '256',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white60,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          SizedBox(
                                            height: 60,
                                            width: 46,
                                            // color: Colors.red,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    _shareContent();
                                                  },
                                                  child: SvgPicture.asset(
                                                      'assets/svgs/share.svg'),
                                                ),
                                                Text(
                                                  '256',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white60,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 19,
                    ),
                  ),
                  const Text(
                    'What’s near me ',
                    style: TextStyle(
                        fontFamily: 'ProximaNova',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  const Text(
                    '|',
                    style: TextStyle(
                        fontFamily: 'ProximaNova',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffDADADA)),
                  ),
                  const Text(
                    'Based on Likes',
                    style: TextStyle(
                        fontFamily: 'ProximaNova',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffDADADA)),
                  ),
                  SvgPicture.asset('assets/svgs/Search icon.svg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Color(0xff025B8F),
            ));
          }
        },
      ),
    );
  }
}

class VideoController extends GetxController {
  var likesCount = 0.obs;
  var userLiked = false.obs;

  Future<void> toggleLikeDislike(String videoId) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) return;

    var videoRef = FirebaseFirestore.instance.collection('videos').doc(videoId);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      var videoSnapshot = await transaction.get(videoRef);
      if (!videoSnapshot.exists) return;

      List<dynamic> likes = videoSnapshot.data()!['likes'] ?? [];
      if (likes.contains(user.email)) {
        likes.remove(user.email);
        userLiked.value = false;
      } else {
        likes.add(user.email);
        userLiked.value = true;
      }
      transaction.update(videoRef, {'likes': likes});
      likesCount.value = likes.length;
    });
  }

  // void getLikesCount(String videoId) async {
  //   var videoRef = FirebaseFirestore.instance.collection('videos').doc(videoId);
  //   videoRef.snapshots().listen((snapshot) {
  //     var likes = snapshot.data()?['likes'] ?? [];
  //     likesCount.value = likes.length;
  //   });
  // }

  Future<void> checkInitialLikeStatus(String videoId) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) return;

    var videoRef = FirebaseFirestore.instance.collection('videos').doc(videoId);
    var videoSnapshot = await videoRef.get();
    if (!videoSnapshot.exists) return;

    List<dynamic> likes = videoSnapshot.data()?['likes'] ?? [];
    userLiked.value = likes.contains(user.email);
    likesCount.value = likes.length;
  }
}

// void openBottomSheet() {
//   Get.bottomSheet(
//     ListView.builder(
//       itemCount: 3,
//       itemBuilder: (context, index) {
//         return ListTile(
//           leading: CircleAvatar(backgroundColor: Colors.black),
//           contentPadding: EdgeInsets.only(bottom: 20),
//           title: Text('data'),
//           subtitle: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('dsfnlsd; fsdfbsdjfsd '),
//               SizedBox(height: 3),
//               Row(
//                 children: [
//                   Text(
//                     '5h',
//                     style: GoogleFonts.inter(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       color: Color(0xff8A8B8F),
//                     ),
//                   ),
//                   SizedBox(width: 3),
//                   Text('Reply',style: GoogleFonts.inter(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: Color(0xff8A8B8F),
//                   ),),
//                 ],
//               )
//             ],
//           ),
//         );
//       },
//     ),
//     backgroundColor: Colors.white,
//     elevation: 0,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//   );
// }
void openBottomSheet() {
  Get.bottomSheet(
    Column(
      children: [
        SizedBox(
          height: 2.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '3 comments',
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff151923),
                    fontSize: 13.04.px),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.close, color: Colors.black, size: 16.px),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 2.h,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.black,
                            backgroundImage: AssetImage('assets/images/2.jpg'),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'name',
                            style: GoogleFonts.inter(
                              fontSize: 14.px,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff151923),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'dsifjsd fsdf sdf sefsd fsdf ',
                            style: GoogleFonts.inter(
                              fontSize: 14.px,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff151923),
                            ),
                          ),
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Text(
                                '5h',
                                style: GoogleFonts.inter(
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8A8B8F),
                                ),
                              ),
                              SizedBox(width: 3),
                              Text(
                                'Reply',
                                style: GoogleFonts.inter(
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff8A8B8F),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                ],
              ),
            );
          },
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
              ),
              SizedBox(
                width: 2.h,
              ),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Add comment",
                    hintStyle: GoogleFonts.inter(
                      fontSize: 15.px,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff8A8B8F),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
    ),
  );
}
