import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/navigation_bar/home_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../mrg/screens/Favourites/newFav.dart';
import '../../push_notification/home_screen.dart';
import '../../widgets/appbar_location.dart';
import 'package:http/http.dart' as http;
import 'explore_screen.dart';
import 'notification_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final NotificationServices notificationServices = NotificationServices();
  final placeApiController = Get.put(PlacesApi());
  TextEditingController searchController = TextEditingController();

  // This will hold the filtered list of searches
  List<String> filteredSearches = [];

  @override
  void initState() {
    super.initState();
    placeApiController.getRecentSearchesFromSharedPreferences();
    // Listen to changes in the search field and filter the recent searches accordingly
    searchController.addListener(_filterSearches);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    searchController.dispose();
    super.dispose();
  }

  void _filterSearches() {
    // Use the text from the searchController to filter the recent searches
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredSearches = placeApiController.recentSearches.where((search) {
        return search.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _navigateToExploreScreen(String location) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          selectedIndex: 1,
          searchQuery: location,
          status: true,
        ),
      ),
    );
  }

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
                  controller: searchController,
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
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemCount: searchController.text.isEmpty
                        ? placeApiController.recentSearches.length
                        : filteredSearches.length,
                    itemBuilder: (context, index) {
                      String searchQuery = searchController.text.isEmpty
                          ? placeApiController.recentSearches[index]
                          : filteredSearches[index];
                      return ListTile(
                        onTap: () {
                          _navigateToExploreScreen(searchQuery);
                        },
                        leading:
                            SvgPicture.asset('assets/svgs/iconoir_refresh.svg'),
                        title: Text(
                          searchQuery,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff7390A1),
                          ),
                        ),
                        trailing: GestureDetector(
                          onTap: () {
                            placeApiController.removeRecentSearch(index);
                          },
                          child: SvgPicture.asset(
                              'assets/svgs/radix-icons_cross-2.svg'),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          // notificationServices.getDeviceToken().then((value) async {
          //   // print('value: ${value.toString()}');
          //   var data = {
          //     'to': value.toString(),
          //     'notification': {
          //       'title': 'Createex',
          //       'body': 'Join Createex Company',
          //       "sound": "jetsons_doorbell.mp3"
          //     },
          //     'android': {
          //       'notification': {
          //         'notification_count': 23,
          //       },
          //     },
          //     'data': {'type': 'msj', 'id': 'Asif Taj'}
          //   };
          //   await http.post(
          //     Uri.parse('https://fcm.googleapis.com/fcm/send'),
          //     body: jsonEncode(data),
          //     headers: {
          //       'Content-Type': 'application/json; charset=UTF-8',
          //       'Authorization':
          //           'key=AAAAooDJnwI:APA91bGZUWgfEnGV379tFwGlbIgll_6-hY0UuoHarXHOYgnm7-qc1F9TFBmHcAPR3UAgFiG-rrkw-pZQj9m5eABroNKul3sczIPoUVgYAH4uNH6PQEPL8B-SRuRnreIBIxZQYtElXfFS'
          //     },
          //   );
          // });
          placeApiController.determinePosition();
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
