import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/mrg/screens/Favourites/newFav.dart';
import 'package:house_to_motive/views/screens/edit_profile_screen.dart';
import 'package:house_to_motive/views/screens/following_screen.dart';
import 'package:house_to_motive/views/screens/privacy_policy_screen.dart';
import 'package:house_to_motive/views/screens/settings_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import '../../mrg/Sanzio_Restaurant.dart';
import '../../mrg/screens/Calender/MyCalander.dart';
import '../../mrg/screens/Ticket.dart';
import '../../widgets/profile_widget.dart';
import 'contactus_screen.dart';
import 'create_event.dart';
import 'faqs_screen.dart';
import 'followers_screen.dart';
import 'notification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _shareContent() {
    Share.share('house_to_motive');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          GestureDetector(
              onTap: (){
                Get.to(() => FavList());
              },
              child: SvgPicture.asset('assets/appbar/heart.svg')),
          const SizedBox(width: 10),
          GestureDetector(
              onTap: (){
                Get.to(() => NotificationScreen());
              },
              child: SvgPicture.asset('assets/appbar/Notification.svg')),
          const SizedBox(width: 10),
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
                        const CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/images/1.jpg'),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const FllowersScreen());
                          },
                          child: Container(
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
                                    color: const Color(0xff7390A1),
                                  ),
                                ),
                                Text(
                                  '745',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff025B8F),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const FollowingScreen());
                          },
                          child: Container(
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
                                    color: const Color(0xff7390A1),
                                  ),
                                ),
                                Text(
                                  '839',
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff025B8F),
                                  ),
                                ),
                              ],
                            ),
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
                                  color: const Color(0xff7390A1),
                                ),
                              ),
                              Text(
                                '52',
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff025B8F),
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
                              color: const Color(0xff7390A1),
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
                    ProfileWidget(
                        svg: 'assets/svgs/userr.svg',
                        title: 'Edit Profile',
                        onTap: () {
                          Get.to(() => const EditProfileScreen());
                        }),
                    ProfileWidget(
                        svg: 'assets/svgs/Ticket 22.svg',
                        title: 'My Tickets',
                        onTap: () {
                          Get.to(() => ticketScreens());
                        }),
                    ProfileWidget(
                        svg: 'assets/svgs/Heart 1.svg',
                        title: "Favorite's",
                        onTap: () {
                          Get.to(() => FavList());
                        }),
                    ProfileWidget(
                        svg: 'assets/svgs/calendar1.svg',
                        title: 'My Dates',
                        onTap: () {
                          Get.to(() => const CalenderScreen());
                        }),
                    ProfileWidget(
                        svg: 'assets/svgs/carbon_intent-request-create.svg',
                        title: 'Create Event',
                        onTap: () {
                          Get.to(() => const CreateEventScreen());
                        }),
                    ProfileWidget(
                        svg: 'assets/svgs/Play Circle.svg',
                        title: 'Create Reel',
                        isDevider: false,
                        onTap: () {}),
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
                    ProfileWidget(
                        svg: 'assets/svgs/faqs.svg',
                        title: 'FAQs',
                        onTap: () {
                          Get.to(() => const FAQSScreen());
                        }),
                    ProfileWidget(
                        svg: 'assets/svgs/Settings.svg',
                        title: 'Settings',
                        onTap: () {
                          Get.to(() => const SettingScreen());
                        }),
                    ProfileWidget(
                        svg: 'assets/svgs/privacy.svg',
                        title: "Privacy Policy",
                        onTap: () {
                          Get.to(() => const PrivacyPolicyScreen());
                        }),
                    ProfileWidget(
                        svg: 'assets/svgs/ph_share-fill.svg',
                        title: 'Invite People',
                        isDevider: false,
                        onTap: () {
                          _shareContent();
                        }),
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
                    ProfileWidget(
                        svg: 'assets/svgs/contact.svg',
                        title: 'Contact Us',
                        onTap: () {
                          Get.to(() => const ContactUSScreen());
                        }),
                    ProfileWidget(
                      svg: 'assets/svgs/Sign Outt.svg',
                      onTap: () {
                        Get.bottomSheet(BottomSheetLogoutDialog());
                      },
                      title: 'Log Out',
                      isDevider: false,
                      red: true,
                    ),
                    const SizedBox(height: 0.7),
                  ],
                ),
              ),
              SizedBox(height: 9.h),
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
              SizedBox(height: 1.7.h),
              Text(
                'Log Out',
                style: GoogleFonts.inter(
                    color: const Color(0xff010101),
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 1.7.h),
              Text(
                textAlign: TextAlign.center,
                'Are you sure you want to logout from HouseToMotive?',
                style: GoogleFonts.inter(
                  color: const Color(0xff424B5A),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 2.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      height: 5.5.h,
                      width: 40.w,
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
                    width: 40.w,
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
