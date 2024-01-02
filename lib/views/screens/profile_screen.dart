import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/mrg/screens/Favourites/newFav.dart';
import 'package:house_to_motive/utils/utils.dart';
import 'package:house_to_motive/views/login/loginwith_email.dart';
import 'package:house_to_motive/views/screens/edit_profile_screen.dart';
import 'package:house_to_motive/views/screens/following_screen.dart';
import 'package:house_to_motive/views/screens/privacy_policy_screen.dart';
import 'package:house_to_motive/views/screens/settings_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
import '../../mrg/screens/Calender/MyCalander.dart';
import '../../mrg/screens/Ticket.dart';
import '../../widgets/profile_widget.dart';
import 'contactus_screen.dart';
import 'create_event.dart';
import 'faqs_screen.dart';
import 'followers_screen.dart';
import 'notification_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  void _shareContent() {
    Share.share('house_to_motive');
  }

  Future<DocumentSnapshot> getUserDetails(String userId) async {
    return FirebaseFirestore.instance.collection('users').doc(userId).get();
  }
  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      var userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();

      return userDocument.data();
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;

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
              onTap: () {
                Get.to(() => FavList());
              },
              child: SvgPicture.asset('assets/appbar/heart.svg')),
          const SizedBox(width: 10),
          GestureDetector(
              onTap: () {
                Get.to(() => const NotificationScreen());
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

                        FutureBuilder(
                          future: fetchUserData(),
                          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text("Error: ${snapshot.error}");
                            } else if (snapshot.hasData) {
                              String? profilePicUrl = snapshot.data?['profilePic'];
                              return profilePicUrl != null
                                  ? CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.black,
                                    backgroundImage: NetworkImage(profilePicUrl),
                                  ) : CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage('assets/pngs/user_profile.png'),
                              );
                            } else {
                              return Text("No user data available");
                            }
                          },
                        ),
                        // CircleAvatar(
                        //   radius: 35,
                        //   backgroundImage: AssetImage('assets/images/1.jpg'),
                        // ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const FllowersScreen());
                          },
                          child: SizedBox(
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
                          child: SizedBox(
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
                        SizedBox(
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
                        FutureBuilder<DocumentSnapshot>(
                          future: getUserDetails(auth.currentUser!.uid),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text("User not found");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              Map<String, dynamic> data =
                                  snapshot.data!.data() as Map<String, dynamic>;
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                        data['User Name'],
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const Text("Loading...");
                          },
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
                          Get.to(() => EditProfileScreen());
                        }),
                    ProfileWidget(
                        svg: 'assets/svgs/Ticket 22.svg',
                        title: 'My Tickets',
                        onTap: () {
                          Get.to(() => const ticketScreens());
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
                          // Get.to(() => const MapsScreen());
                        }),
                    ProfileWidget(
                      svg: 'assets/svgs/Sign Outt.svg',
                      onTap: () {
                        Get.bottomSheet(const BottomSheetLogoutDialog());
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
  const BottomSheetLogoutDialog({super.key});

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
                        _signOut();
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

void _signOut() {
  FirebaseAuth.instance.signOut().then((value) {
    Get.to(() => LoginWithEmailScreen());
    Utils().ToastMessage('Sign Out');
  }).onError((error, stackTrace) {
    Utils().ToastMessage(error.toString());
  });
  FirebaseAuth.instance.currentUser;
}
