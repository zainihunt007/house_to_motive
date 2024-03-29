import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/profile_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  // final videoUrl;
  const VideoScreen(
      {super.key,
      // this.videoUrl,
      required this.videoUrls,
      required this.initialIndex});
  final List<String> videoUrls;
  final int initialIndex;

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
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
            child: StreamBuilder<QuerySnapshot>(
              stream: videosCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error fetching videos'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No videos found'));
                }

                List<DocumentSnapshot> videoDocs = snapshot.data!.docs;

                // List<String> videoLocations =
                //     videoDocs.map((doc) => doc['location'] as String).toList();
                // List<String> userProfilePic = videoDocs
                //     .map((doc) => doc['profileUrl'] as String)
                //     .toList();

                List<String?> videoLocations =
                    videoDocs.map((doc) => doc['location'] as String?).toList();
                List<String?> userProfilePic = videoDocs
                    .map((doc) => doc['profileUrl'] as String?)
                    .toList();

                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.videoUrls.length,
                  controller: PageController(initialPage: widget.initialIndex),
                  itemBuilder: (context, index) {
                    log('profile image: ${userProfilePic[index].toString()}');
                    var videoDoc = videoDocs[index];
                    log('Length of videos: ${videoDocs.length}');

                    videoLikecontroller.checkInitialLikeStatus(
                        videoDoc.id); // Ensure this is correctly implemented

                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('comments')
                          .where('videoId', isEqualTo: videoDoc.id)
                          .snapshots(),
                      builder: (context, commentsSnapshot) {
                        int commentsCount =
                            commentsSnapshot.data?.docs.length ?? 0;

                        return Stack(
                          children: [
                            VideoPlayerScreen(
                                videoUrl: widget.videoUrls[index]),
                            Obx(
                              () => SafeArea(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Row(
                                      children: [],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
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
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(2),
                                                    child: AutoSizeText(
                                                      maxLines: 1,
                                                      'Lorem Lipsam',
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
                                                'Starting Price: £9.99',
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
                                                  // Text(
                                                  //   videoLocations[index]
                                                  //               .length <
                                                  //           30
                                                  //       ? videoLocations[index]
                                                  //       : '${videoLocations[index].substring(0, 30)}...',
                                                  //   style: GoogleFonts.inter(
                                                  //     fontSize: 12,
                                                  //     fontWeight:
                                                  //         FontWeight.w400,
                                                  //     color: Colors.white60,
                                                  //   ),
                                                  // ),
                                                  Text(
                                                    (videoLocations[index]
                                                                    ?.length ??
                                                                0) <
                                                            30
                                                        ? videoLocations[
                                                                index] ??
                                                            ''
                                                        : '${videoLocations[index]?.substring(0, 30) ?? ''}...',
                                                    style: GoogleFonts.inter(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                            children: [
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor:
                                                          Colors.black,
                                                      backgroundImage:
                                                          //     NetworkImage(
                                                          //   userProfilePic[index] ==
                                                          //               null ||
                                                          //           userProfilePic[
                                                          //                   index]
                                                          //               .isEmpty
                                                          //       ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                                                          //       : userProfilePic[
                                                          //           index], // Use the profile picture URL if it's not null or empty
                                                          // ),
                                                          NetworkImage(
                                                        userProfilePic[index] ??
                                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: 40,
                                                    right: 10,
                                                    child: CircleAvatar(
                                                      radius: 6,
                                                      backgroundColor:
                                                          Colors.white,
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
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () =>
                                                          videoLikecontroller
                                                              .toggleLikeDislike(
                                                                  videoDoc.id),
                                                      child: videoLikecontroller
                                                              .userLiked.value
                                                          ? SvgPicture.asset(
                                                              'assets/liked.svg')
                                                          : SvgPicture.asset(
                                                              'assets/svgs/Like icon.svg',
                                                            ),
                                                    ),
                                                    Text(
                                                      videoLikecontroller
                                                          .likesCount
                                                          .toString(),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        openBottomSheet(context,
                                                            videoDoc.id);
                                                      },
                                                      child: SvgPicture.asset(
                                                          'assets/svgs/comments.svg'),
                                                    ),
                                                    Text(
                                                      commentsCount.toString(),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                        fontWeight:
                                                            FontWeight.w500,
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

    var userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user.uid);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      var videoRef =
          FirebaseFirestore.instance.collection('videos').doc(videoId);
      var videoSnapshot = await transaction.get(videoRef);
      if (!videoSnapshot.exists) return;

      List<dynamic> likes = videoSnapshot.data()!['likes'] ?? [];
      if (likes.contains(user.email)) {
        likes.remove(user.email);
        // Remove videoId from user's likedVideos list
        List<dynamic> userLikedVideos =
            (await transaction.get(userDocRef)).data()?['likedVideos'] ?? [];
        userLikedVideos.remove(videoId);
        transaction.update(userDocRef, {'likedVideos': userLikedVideos});
      } else {
        likes.add(user.email);
        // Add videoId to user's likedVideos list
        List<dynamic> userLikedVideos =
            (await transaction.get(userDocRef)).data()?['likedVideos'] ?? [];
        userLikedVideos.add(videoId);
        transaction.update(userDocRef, {'likedVideos': userLikedVideos});
      }
      transaction.update(videoRef, {'likes': likes});
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
void openBottomSheet(BuildContext context, String videoDocId) {
  final TextEditingController commentController = TextEditingController();
  final CollectionReference commentsCollection =
      FirebaseFirestore.instance.collection('comments');

  Get.bottomSheet(
    SingleChildScrollView(
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: commentsCollection
                .where('videoId', isEqualTo: videoDocId)
                .snapshots(),
            builder: (context, snapshot) {
              // Calculate the number of comments dynamically
              String commentCount = snapshot.hasData
                  ? '${snapshot.data!.docs.length} comments'
                  : 'Loading comments...';

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      commentCount, // Use dynamic comment count
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff151923),
                          fontSize: 13.04.px),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child:
                          Icon(Icons.close, color: Colors.black, size: 16.px),
                    ),
                  ],
                ),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('comments')
                .where('videoId', isEqualTo: videoDocId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Error loading comments");
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              var comments = snapshot.data!.docs;

              return SizedBox(
                height: 30.h,
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    var comment = comments[index];
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 2.h),
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(comment['profilePic']
                                    .toString()
                                    .isEmpty
                                ? "https://static.vecteezy.com/system/resources/thumbnails/002/534/006/small/social-media-chatting-online-blank-profile-picture-head-and-body-icon-people-standing-icon-grey-background-free-vector.jpg"
                                : comment['profilePic'].toString()),
                          ),
                          SizedBox(width: 2.h),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment[
                                      'userName'], // Ideally, fetch the user's name using the userId from the comment
                                  style: GoogleFonts.inter(
                                    fontSize: 14.px,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff151923),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  comment['text'] ?? 'No text',
                                  style: GoogleFonts.inter(
                                    fontSize: 14.px,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff151923),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      Colors.black, // Placeholder for user's avatar
                  backgroundImage: NetworkImage(profilePicUrl.toString().isEmpty
                      ? "https://static.vecteezy.com/system/resources/thumbnails/002/534/006/small/social-media-chatting-online-blank-profile-picture-head-and-body-icon-people-standing-icon-grey-background-free-vector.jpg"
                      : profilePicUrl.toString()),
                ),
                SizedBox(width: 2.h),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: "Add comment",
                        isDense: true,
                        prefixIcon: IconButton(
                          onPressed: () async {
                            if (commentController.text.isNotEmpty) {
                              await commentsCollection.add({
                                'userName': data?['User Name'],
                                'profilePic': profilePicUrl.toString(),
                                'videoId': videoDocId,
                                'text': commentController.text,
                              });
                              commentController
                                  .clear(); // Clear the input field
                            }
                          },
                          icon: const Icon(Icons.send),
                        ),
                        hintStyle: GoogleFonts.inter(
                          fontSize: 15.px,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff8A8B8F),
                        ),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        fillColor: const Color(0xffF1F1F3),
                        filled: true,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

// void openBottomSheet(BuildContext context, String videoDocId) {
//   // Debug print to ensure function is called
//   print("Opening bottom sheet for video ID: $videoDocId");
//
//   Get.bottomSheet(
//     SingleChildScrollView(
//       child: Column(
//         children: [
//           StreamBuilder<QuerySnapshot>(
//             stream: FirebaseFirestore.instance
//                 .collection('comments')
//                 .where('videoId', isEqualTo: videoDocId)
//                 .snapshots(),
//             builder: (context, snapshot) {
//               if (snapshot.hasError) {
//                 // Debug print for errors
//                 print("Error fetching comments: ${snapshot.error}");
//                 return Text("Error loading comments");
//               }
//               if (!snapshot.hasData) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               var comments = snapshot.data!.docs;
//               // Debug print to check comments count
//               print("Fetched comments count: ${comments.length}");
//
//               return ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: comments.length,
//                 itemBuilder: (context, index) {
//                   var comment = comments[index];
//                   return ListTile(
//                     title: Text(comment['text'] ?? 'No text'),
//                   );
//                 },
//               );
//             },
//           ),
//           // Additional widgets for posting comments
//         ],
//       ),
//     ),
//     isScrollControlled: true,
//     backgroundColor: Colors.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(20),
//     ),
//   );
// }

// openBottomSheet(context,videoDoc.id);
