import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/edit_profile_screen.dart';
import 'package:house_to_motive/views/screens/privacy_policy_screen.dart';
import 'package:house_to_motive/views/screens/settings_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';

import '../../mrg/Sanzio_Restaurant.dart';
import '../../widgets/profile_widget.dart';
import 'chat_screen.dart';
import 'contactus_screen.dart';
import 'create_event.dart';
import 'faqs_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _shareContent() {
    Share.share('house_to_motive');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: const Color(0xff025B8F),
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
                 SizedBox(width: 1.h),
                const Text(
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
                   SizedBox(width: 1.h),
                  const Text(
                    '73 Newport Road, Carnbo',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(width: 1.h),
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
          SizedBox(width: 1.h),
          SvgPicture.asset('assets/appbar/Notification.svg'),
          SizedBox(width: 1.h),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Container(
                height: Get.height / 6,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/images/1.jpg'),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Followers',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff7390A1),
                                ),
                              ),
                              Text(
                                '745',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff025B8F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Followings',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff7390A1),
                                ),
                              ),
                              Text(
                                '839',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff025B8F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Posts',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff7390A1),
                                ),
                              ),
                              Text(
                                '52',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff025B8F),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Oyinola Agoro',
                          style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Business man',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff7390A1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              // ProfileWidget(),
              Container(
                // height: 50,
                // width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 0.7.h),
                    ProfileWidget(title: 'Edit Profile',onTap: (){
                      Get.to(() => EditProfileScreen());
                    }),
                    ProfileWidget(title: 'My Tickets',onTap: (){
                      Get.to(SanzioRestaurant());
                    }),
                    ProfileWidget(title: "Favorite's",onTap: (){}),
                    ProfileWidget(title: 'My Dates',onTap: (){}),
                    ProfileWidget(title: 'Create Event',onTap: (){
                      Get.to(() => CreateEventScreen());
                    }),
                    ProfileWidget(
                      title: 'Create Reel',
                      isDevider: false,
                        onTap: (){}
                    ),
                    SizedBox(height: 0.7.h),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                // height: 50,
                // width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),

                child: Column(
                  children: [
                    SizedBox(height: 0.7.h),
                    ProfileWidget(title: 'FAQs',onTap: (){
                      Get.to(() => FAQSScreen());
                    }),
                    ProfileWidget(title: 'Settings',onTap: (){
                      Get.to(()=> SettingScreen());
                    }),
                    ProfileWidget(title: "Privacy Policy",onTap: (){
                      Get.to(() => PrivacyPolicyScreen());
                    }),
                    ProfileWidget(
                      title: 'Invite People',
                      isDevider: false,
                        onTap: (){
                          _shareContent();
                        }
                    ),
                    SizedBox(height: 0.7.h),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                // height: 50,
                // width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),

                child: Column(
                  children: [
                    SizedBox(height: 0.7.h),
                    ProfileWidget(title: 'Contact Us',onTap: (){
                      Get.to(()=> ContactUSScreen());
                    }),
                    ProfileWidget(
                      onTap: (){
                        Get.bottomSheet(
                            BottomSheetLogoutDialog());
                      },
                      title: 'Log Out',
                      isDevider: false,
                      red: true,
                    ),
                    SizedBox(height: 0.7),
                  ],
                ),
              ),
              SizedBox(height:9.h),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetLogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Set the background color to transparent
      child: Container(
        height: Get.height / 2.6,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/svgs/Sign Out.svg'),
              const SizedBox(height: 17),
               Text(
                'Log Out',
                style: GoogleFonts.inter(
                    color: Color(0xff010101),
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 17),
              Text(
                textAlign: TextAlign.center,
                'Are you sure you want to logout from HouseToMotive?',
                style: GoogleFonts.inter(
                  color: Color(0xff424B5A),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Container(
                      height: 44,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff090808),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:  Center(
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              color: Color(0xff090808),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 44,
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff025B8F),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // Get.to(() => HomePage());
                      },
                      child:  Center(
                        child: Text(
                          'Logout',
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
