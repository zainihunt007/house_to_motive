import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/video_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class UploadYourViedoScreen extends StatelessWidget {
  const UploadYourViedoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
      body: Column(
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
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Expanded(
                                            child: Text(
                                              '# Hashtags',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff7390A1)),
                                            ),
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
                      Container(
                        height: 17.h,
                        width: 32.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.orange,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset('assets/images/4.jpg',
                              fit: BoxFit.fill),
                        ),
                      ),
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
                          child: const Center(
                              child: Text(
                            'Choose Cover',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                              color: Color(0xffF6F9FF),
                            ),
                          )),
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
                'assets/svgs/Locationn.svg',
              ),
              title: const Text(
                'Location',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff424B5A),
                ),
              ),
              trailing: SvgPicture.asset('assets/svgs/Left Arrow Icon.svg'),
            ),
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
                              padding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              child: Expanded(
                                child: Text(
                                  '# Hashtags',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff7390A1)),
                                ),
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
                    width:5.2.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black12),
                      // color: Colors.black,
                    ),
                    child: Center(
                      child: SvgPicture.asset('assets/svgs/snapchat-logo.svg'),
                    ),
                  ),
                ),
                SizedBox(width: 1.w),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 5.2.h,
                    width:5.2.h,
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
                  width:5.2.h,
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
                          SvgPicture.asset('assets/svgs/carbon_rule-draft.svg'),
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
                    onTap: (){
                        Get.to(() => VideoScreen());
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
                            SvgPicture.asset('assets/svgs/eva_upload-outline.svg'),
                            SizedBox(width: 1.w),
                            Text(
                              'Post',
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
