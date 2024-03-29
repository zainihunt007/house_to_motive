import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../mrg/screens/Favourites/newFav.dart';
import '../../push_notification/home_screen.dart';
import '../../widgets/appbar_location.dart';
import 'package:http/http.dart' as http;
import 'notification_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final NotificationServices notificationServices = NotificationServices();

  // Future<void> getAllToken() async {
  //   try {
  //     QuerySnapshot<Map<String, dynamic>> snapshot =
  //         await FirebaseFirestore.instance.collection('users').get();
  //     List<String> deviceTokens = [];
  //
  //     snapshot.docs.forEach((doc) {
  //       // Assuming 'Device Token' is the field name for device token
  //       String deviceToken = doc.data()['Device Token'];
  //       if (deviceToken != null && deviceToken.isNotEmpty) {
  //         deviceTokens.add(deviceToken);
  //       }
  //       print('length: ${deviceTokens.length}');
  //     });
  //
  //     // Now you have all the device tokens in the deviceTokens list
  //     print(deviceTokens);
  //   } catch (error) {
  //     print("Error retrieving device tokens: $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              // SizedBox(height: 1.6.w),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search what’s near me",
                    hintStyle: const TextStyle(
                      fontFamily: 'ProximaNova',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff424B5A),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/svgs/search-normal.svg',
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(
                      'Recent Searches',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: const Color(0xff025B8F),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.5.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading:
                          SvgPicture.asset('assets/svgs/iconoir_refresh.svg'),
                      title: Text(
                        'Lorem ipsum',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff7390A1),
                        ),
                      ),
                      trailing: SvgPicture.asset(
                          'assets/svgs/radix-icons_cross-2.svg'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          notificationServices.getDeviceToken().then((value) async {
            // print('value: ${value.toString()}');
            var data = {
              'to': value.toString(),
              'notification': {
                'title': 'Createex',
                'body': 'Join Createex Company',
                "sound": "jetsons_doorbell.mp3"
              },
              'android': {
                'notification': {
                  'notification_count': 23,
                },
              },
              'data': {'type': 'msj', 'id': 'Asif Taj'}
            };
            await http.post(
              Uri.parse('https://fcm.googleapis.com/fcm/send'),
              body: jsonEncode(data),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization':
                    'key=AAAAooDJnwI:APA91bGZUWgfEnGV379tFwGlbIgll_6-hY0UuoHarXHOYgnm7-qc1F9TFBmHcAPR3UAgFiG-rrkw-pZQj9m5eABroNKul3sczIPoUVgYAH4uNH6PQEPL8B-SRuRnreIBIxZQYtElXfFS'
              },
            );
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80.0),
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xffFF0092),
                  Color(0xff216DFD),
                ],
              ),
            ),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// AppBar(
// centerTitle: true,
// backgroundColor: const Color(0xff025B8F),
// leading: Padding(
// padding: const EdgeInsets.only(left: 4),
// child: Image.asset('assets/pngs/htmlogo.png'),
// ),
// title: Column(
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Image.asset(
// 'assets/appbar/Vector@2x.png',
// height: 9,
// width: 9,
// ),
// SizedBox(width: 1.h),
// const Text(
// 'My Location',
// style: TextStyle(
// fontSize: 12,
// fontWeight: FontWeight.w600,
// color: Colors.white),
// ),
// ],
// ),
// Padding(
// padding: const EdgeInsets.only(left: 8.0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// SizedBox(width: 1.h),
// const Text(
// '73 Newport Road, Carnbo',
// style: TextStyle(
// fontSize: 10,
// fontWeight: FontWeight.w400,
// color: Colors.white),
// ),
// SizedBox(width: 1.h),
// Image.asset(
// 'assets/appbar/Vector1.png',
// height: 9,
// width: 9,
// ),
// ],
// ),
// ),
// ],
// ),
// actions: [
// GestureDetector(
// onTap: (){
// Get.to(() => FavList());
// },
// child: SvgPicture.asset('assets/appbar/heart.svg')),
// const SizedBox(width: 10),
// GestureDetector(
// onTap: (){
// Get.to(() => NotificationScreen());
// },
// child: SvgPicture.asset('assets/appbar/Notification.svg')),
// const SizedBox(width: 10),
// ],
// ),
