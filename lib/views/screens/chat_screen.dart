import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/chat_ui.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/appbar_location.dart';
import 'home_screens/home_model.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Column(
              children: [
                // SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Recent Chats',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: const Color(0xff025B8F),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                                    fontSize: 10, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Today Messages',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: const Color(0xff025B8F),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const ChatPage());
                      },
                      child: Slidable(
                        // Specify a key if the Slidable is dismissible.
                        // key: const ValueKey(6),

                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          extentRatio: 0.13,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(const BottomSheetDeletDialog());
                              },
                              child: Container(
                                height: 60,
                                width: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xffFFE7E5),
                                ),
                                child: Center(
                                  child:
                                      SvgPicture.asset('assets/svgs/Trash.svg'),
                                ),
                              ),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/3.jpg'),
                              ),
                              title: Text(
                                'Ariana Sime',
                                style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff161616),
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Image.asset('assets/pngs/export.png'),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Hey bro, do you want...',
                                    style: GoogleFonts.nunito(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff575757),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('5:35 PM'),
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Color(0xff025B8F),
                                    child: Center(
                                      child: Text(
                                        '8',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 2.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Yesterday',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: const Color(0xff025B8F),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Slidable(
                      // Specify a key if the Slidable is dismissible.
                      // key: const ValueKey(6),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.13,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(const BottomSheetDeletDialog());
                            },
                            child: Container(
                              height: 60,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xffFFE7E5),
                              ),
                              child: Center(
                                child:
                                    SvgPicture.asset('assets/svgs/Trash.svg'),
                              ),
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/3.jpg'),
                            ),
                            title: Text(
                              'Ariana Sime',
                              style: GoogleFonts.nunito(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff161616),
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Image.asset('assets/pngs/export.png'),
                                const SizedBox(width: 8),
                                Text(
                                  'Hey bro, do you want...',
                                  style: GoogleFonts.nunito(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff575757),
                                  ),
                                ),
                              ],
                            ),
                            trailing: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text('5:35 PM'),
                                CircleAvatar(
                                  radius: 8,
                                  backgroundColor: Color(0xff025B8F),
                                  child: Center(
                                    child: Text(
                                      '8',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetDeletDialog extends StatelessWidget {
  const BottomSheetDeletDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Set the background color to transparent
      child: Container(
        height: 35.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svgs/akar-icons_chat-error.svg'),
              SizedBox(height: 1.7.h),
              Text(
                'Delete Ariana Conversation?',
                style: GoogleFonts.inter(
                    color: const Color(0xff010101),
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 1.7.h),
              Text(
                textAlign: TextAlign.center,
                'Do you really want to delete this conversation?',
                style: GoogleFonts.inter(
                  color: const Color(0xff424B5A),
                  fontSize: 14.px,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 5.5.h,
                      width: 20.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff090808),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: const Color(0xff090808),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 5.5.h,
                    width: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff025B8F),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Get.to(() => HomePage());
                      },
                      child: Center(
                        child: Text(
                          'Delete',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class DataModel {
//   final String imageUrl;
//   final String title;
//   final String subtitle;
//   final int number;
//
//   DataModel({
//     required this.imageUrl,
//     required this.title,
//     required this.subtitle,
//     required this.number,
//   });
// }
//
//   final List<DataModel> data = [
//     DataModel(
//       imageUrl: 'https://example.com/image1.jpg',
//       title: 'Item 1',
//       subtitle: 'Description 1',
//       number: 42,
//     ),
//     DataModel(
//       imageUrl: 'https://example.com/image2.jpg',
//       title: 'Item 2',
//       subtitle: 'Description 2',
//       number: 17,
//     ),
//   ];
