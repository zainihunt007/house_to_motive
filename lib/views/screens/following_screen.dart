import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'home_screens/home_model.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Following',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 20,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            visualDensity: const VisualDensity(vertical: -1),
            dense: true,
            title: Text(
              'Makenna Rosser',
              style: GoogleFonts.nunito(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xff161616),
              ),
            ),
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://media.wired.com/photos/63e6d6a0552920ecdc857e88/master/pass/I-Found-My-Chosen-Family-On-Social-Media-Culture-1307394117.jpg'),
              radius: 20,
            ),
            subtitle: Text(
              'Lorem Ipsum',
              style: GoogleFonts.nunito(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: const Color(0xffA5A5A5),
              ),
            ),
            trailing: Container(
              height: 3.5.h,
              width: 16.w,
              decoration: BoxDecoration(
                color: const Color(0xffd9e6f2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: GradientText(
                  text: "Following",
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
              ),
            ),
          );
        },
      ),
    );
  }
}
