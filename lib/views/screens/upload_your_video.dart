import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/navigation_bar/home_page.dart';
import 'package:house_to_motive/views/screens/profile_screen.dart';
import 'package:path/path.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'explore_screen.dart';

class UploadYourViedoScreen extends StatelessWidget {
   UploadYourViedoScreen({super.key});

  // Future<File?> pickVideo() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.video,
  //   );
  //
  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     return file;
  //   } else {
  //     // User canceled the picker
  //     return null;
  //   }
  // }
  //
  //
  // Future<void> uploadVideo(File file) async {
  //   try {
  //     String fileName = basename(file.path);
  //     Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('videos/$fileName');
  //     await firebaseStorageRef.putFile(file);
  //     // You can also get the download URL after uploading
  //     // String downloadURL = await firebaseStorageRef.getDownloadURL();
  //   } on FirebaseException catch (e) {
  //     // Handle any errors
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final formkey = GlobalKey<FormState>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final VideoController videoController = Get.put(VideoController());
    final placeApiController = Get.put(PlacesApi());
    RxBool light0 = true.obs;
    return Scaffold(
      appBar: AppBar(
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
        centerTitle: true,
        backgroundColor: const Color(0xff025B8F),
        title: Text(
          'Upload Your Video',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 17.h,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Create more informative content when you go into greater detail with 4000 characters.',
                            style: TextStyle(
                              fontFamily: 'ProximaNova',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xff7390A1),
                            ),
                          ),
                          SizedBox(
                            height: 3.5.h,
                            child: ListView.builder(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.only(left: 4, right: 4),
                                  child: Container(
                                    height: 2.5.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: const Center(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            child: Text(
                                              '# Hashtags',
                                              style: TextStyle(
                                                  fontFamily: 'ProximaNova',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff7390A1)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Obx(() {
                          if (videoController.isUploading.value) {
                            return Container(
                              height: 17.h,
                              width: 32.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.orange,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Center(
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Image.network(
                                        videoController.thumbnailUrl.value!,
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                      ),
                                      CircularProgressIndicator(
                                          value: videoController
                                                  .uploadProgress.value /
                                              100),
                                      Text(
                                          "${videoController.uploadProgress.value.toStringAsFixed(0)}%"),
                                    ],
                                  ),
                                ),
                              ),
                            ); // Show loading indicator
                          } else {
                            return Container(
                              height: 17.h,
                              width: 32.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.orange,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Obx(() {
                                  if (videoController.thumbnailUrl.value !=
                                      null) {
                                    return SizedBox(
                                      width:
                                          128, // Set the width based on your requirements
                                      height:
                                          128, // Set the height based on your requirements
                                      child: Image.network(
                                        videoController.thumbnailUrl.value!,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  } else {
                                    return Image.asset(
                                        'assets/pngs/Rectangle 19345.png',fit: BoxFit.fill,);
                                  }
                                }),
                              ),
                            ); // Show nothing when not uploading
                          }
                        }),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 4.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(12),
                              ),
                              color: const Color(0xff025B8F).withOpacity(0.7),
                            ),
                            child: InkWell(
                              onTap: () {
                                videoController.pickVideo();
                                videoController.fieldTextEditingController.clear();
                              },
                              child: const Center(
                                  child: Text(
                                'Choose Cover',
                                style: TextStyle(
                                  fontFamily: 'ProximaNova',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 10,
                                  color: Color(0xffF6F9FF),
                                ),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                dense: true,
                leading: SvgPicture.asset('assets/svgs/Profile 1.svg'),
                title: const Text(
                  'Tag People',
                  style: TextStyle(
                    fontFamily: 'ProximaNova',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff424B5A),
                  ),
                ),
                trailing: SvgPicture.asset('assets/svgs/Left Arrow Icon.svg'),
              ),
            ),
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) async {
                if (textEditingValue.text == '') {
                  return const Iterable<String>.empty();
                }
                return placeApiController.getSuggestions(textEditingValue.text);
              },
              onSelected: (String selection) {
                placeApiController.searchPlaces(selection);
                videoController.fieldTextEditingController.text = selection;

              },
              fieldViewBuilder: (BuildContext context, fieldTextEditingController,  fieldFocusNode,  onFieldSubmitted) {
                return TextFormField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  decoration: InputDecoration(
                    hintText: 'Location',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    isDense: true,
                    hintStyle: const TextStyle(
                      fontFamily: 'ProximaNova',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff424B5A),
                    ),
                    prefixIcon: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 29), // Adjust padding for icon positioning
                      child: SvgPicture.asset(
                        'assets/svgs/Locationn.svg',
                        height: 10, // Adjust the size as needed
                        width: 10,
                      ),
                    ),
                    suffixIcon: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 37), // Adjust padding for icon positioning
                      child: SvgPicture.asset(
                        'assets/svgs/Left Arrow Icon.svg',
                        height: 10, // Adjust the size as needed
                        width: 10,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 0.7.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 3.h,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 4, right: 4),
                      child: Container(
                        height: 2.5.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            border: Border.all(color: Colors.black12)),
                        child: const Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  '# Hashtags',
                                  style: TextStyle(
                                      fontFamily: 'ProximaNova',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff7390A1)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                dense: true,
                leading: SvgPicture.asset(
                  'assets/svgs/Video Slash.svg',
                ),
                title: const Text(
                  'Content Disclosure',
                  style: TextStyle(
                    fontFamily: 'ProximaNova',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff424B5A),
                  ),
                ),
                trailing: SvgPicture.asset('assets/svgs/Left Arrow Icon.svg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                dense: true,
                leading: SvgPicture.asset(
                  'assets/svgs/Category.svg',
                ),
                title: const Text(
                  'Add Link',
                  style: TextStyle(
                    fontFamily: 'ProximaNova',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff424B5A),
                  ),
                ),
                trailing: SvgPicture.asset('assets/svgs/Left Arrow Icon.svg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                dense: true,
                leading: SvgPicture.asset(
                  'assets/svgs/bx_world.svg',
                ),
                title: const Text(
                  'Everyone Can View This Post',
                  style: TextStyle(
                    fontFamily: 'ProximaNova',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff424B5A),
                  ),
                ),
                trailing: SvgPicture.asset('assets/svgs/Left Arrow Icon.svg'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListTile(
                  dense: true,
                  leading: SvgPicture.asset(
                    'assets/svgs/Message 18.svg',
                  ),
                  title: const Text(
                    'Allow Comments',
                    style: TextStyle(
                      fontFamily: 'ProximaNova',
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff424B5A),
                    ),
                  ),
                  trailing: Obx(
                    () => Switch(
                      activeTrackColor: Colors.green,
                      value: light0.value,
                      onChanged: (bool value) {
                        light0.value = value;
                      },
                    ),
                  )),
            ),
            SizedBox(height: 0.8.h),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Automatically share to:',
                    style: TextStyle(
                      fontFamily: 'ProximaNova',
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff424B5A),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 5.2.h,
                      width: 5.2.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black12),
                        // color: Colors.black,
                      ),
                      child: Center(
                        child:
                            SvgPicture.asset('assets/svgs/snapchat-logo.svg'),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 5.2.h,
                      width: 5.2.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black12),
                        // color: Colors.black,
                      ),
                      child: Center(
                        child: SvgPicture.asset('assets/svgs/insta-logo.svg'),
                      ),
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Container(
                    height: 5.2.h,
                    width: 5.2.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black12),
                      // color: Colors.black,
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/svgs/chatbubble.svg'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 5.5.h,
                      width: screenWidth / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/svgs/carbon_rule-draft.svg'),
                            SizedBox(width: 1.w),
                            Text(
                              'Draft',
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        // Get.to(() => VideoScreen());
                        videoController.uploadVideo().then((value) {
                          // videoController.fieldTextEditingController.clear();
                          Get.snackbar('Status', 'video uploaded');
                        });
                        Get.off(() => const HomePage());
                      },
                      child: Container(
                        height: 5.5.h,
                        width: screenWidth / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xff025B8F),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  'assets/svgs/eva_upload-outline.svg'),
                              SizedBox(width: 1.w),
                              Text(
                                'Post',
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
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
    );
  }
}

class VideoController extends GetxController {
  var videoFile = Rxn<File>();
  var isUploading = false.obs;
  var thumbnailUrl = Rxn<String>();
  var uploadProgress = 0.0.obs;
  final TextEditingController fieldTextEditingController = TextEditingController();
  // var thumbnail = Rxn<Image>();

  Future<void> pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      videoFile.value = File(result.files.single.path!);
      await generateThumbnail(videoFile.value!); // Generate thumbnail
    } else {
      // User canceled the picker
    }
  }

  // Future<void> generateThumbnaill(File video) async {
  //   final uint8list = await VideoThumbnail.thumbnailData(
  //     video: video.path,
  //     imageFormat: ImageFormat.JPEG,
  //     maxWidth: 128, // Specify the width of the thumbnail
  //     quality: 25,
  //   );
  //
  //   if (uint8list != null) {
  //     thumbnail.value = Image.memory(uint8list);
  //   }
  // }

  // Function to generate a thumbnail from a video file
  Future<void> generateThumbnail(File video) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: video.path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128, // Specify the width of the thumbnail
      quality: 25,
    );

    if (uint8list != null) {
      // Upload thumbnail to Firebase Storage
      String thumbnailFileName =
          'thumbnail_${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference thumbnailStorageRef =
          FirebaseStorage.instance.ref().child('thumbnails/$thumbnailFileName');
      UploadTask thumbnailUploadTask = thumbnailStorageRef.putData(uint8list);

      // Wait for the thumbnail upload to complete
      await thumbnailUploadTask;

      // Get the download URL of the uploaded thumbnail
      thumbnailUrl.value = await thumbnailStorageRef.getDownloadURL();
    }
  }

  // Future<void> uploadToFirestore(String selection) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('videos').add({
  //       'selected_location': selection,
  //     });
  //     print('Value uploaded to Firestore: $selection');
  //   } catch (e) {
  //     print('Error uploading to Firestore: $e');
  //   }
  // }

  Future<void> uploadVideo() async {
    if (fieldTextEditingController.text.isEmpty) {
      // Show an error or handle the case where the location field is empty
      Get.snackbar('Error', 'Location field is empty. Please select a location.');
      print('Location field is empty. Please select a location.');
      return;
    }

    if (videoFile.value == null || thumbnailUrl.value == null) {
      // Handle the case where no file or thumbnail is selected
      print('Video file or thumbnail is missing. Please select both.');
      return;
    }

    try {
      isUploading.value = true;

      // Get the current user's unique ID
      String userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

      String fileName = basename(videoFile.value!.path);

      // Upload the video to Firebase Storage
      Reference videoStorageRef =
      FirebaseStorage.instance.ref().child('user_videos/$userId/$fileName');
      UploadTask videoUploadTask = videoStorageRef.putFile(videoFile.value!);

      // Listen for changes in upload progress
      videoUploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        uploadProgress.value =
            (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
      });

      // Wait for the video upload to complete
      await videoUploadTask;

      // Get the download URL of the uploaded video
      String videoDownloadUrl = await videoStorageRef.getDownloadURL();

      // Add the video metadata to Firestore
      await FirebaseFirestore.instance.collection('videos').add({
        'userId': userId,
        'videoUrl': videoDownloadUrl,
        'thumbnailUrl': thumbnailUrl.value,
        'timestamp': FieldValue.serverTimestamp(), // Optional: Add timestamp
        'location': fieldTextEditingController.text,
        'profileUrl' : profilePicUrl.toString(),
        // 'username' : data!['User Name'],
      });
    } on FirebaseException catch (e) {
      // Handle any errors
      print('Error uploading video: $e');
    } finally {
      isUploading.value = false;
    }
  }
}

// ListTile(
// onTap: (){
// Get.to(() =>  MapScreen());
// },
// dense: true,
// leading: SvgPicture.asset(
// 'assets/svgs/Locationn.svg',
// ),
// title: const Text(
// 'Location',
// style: TextStyle(
// fontFamily: 'ProximaNova',
// fontSize: 12,
// fontWeight: FontWeight.w400,
// color: Color(0xff424B5A),
// ),
// ),
// trailing: SvgPicture.asset('assets/svgs/Left Arrow Icon.svg'),
// ),



// TextFormField(
// decoration: InputDecoration(
// hintText: 'Location',
// contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
// isDense: true,// Adjust this for hint text padding
// hintStyle: TextStyle(
// fontFamily: 'ProximaNova',
// fontSize: 12,
// fontWeight: FontWeight.w400,
// color: Color(0xff424B5A),
// ),
// prefixIcon: Container(
// padding: EdgeInsets.symmetric(horizontal: 29), // Adjust padding for icon positioning
// child: SvgPicture.asset(
// 'assets/svgs/Locationn.svg',
// height: 10, // Adjust the size as needed
// width: 10,
// ),
// ),
// suffixIcon: Container(
// padding: EdgeInsets.symmetric(horizontal: 37), // Adjust padding for icon positioning
// child: SvgPicture.asset(
// 'assets/svgs/Left Arrow Icon.svg',
// height: 10, // Adjust the size as needed
// width: 10,
// ),
// ),
// ),
// ),