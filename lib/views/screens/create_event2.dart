import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/create_event3.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CreateEvent2Screen extends StatefulWidget {
  const CreateEvent2Screen({super.key});

  @override
  State<CreateEvent2Screen> createState() => _CreateEvent2ScreenState();
}

class _CreateEvent2ScreenState extends State<CreateEvent2Screen> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    RxBool light0 = true.obs;
    RxBool light1 = true.obs;
    final screenWidth = MediaQuery.of(context).size.width;
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
          'Create Event 2',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.h),
            Text(
              'Date',
              style: GoogleFonts.inter(
                fontSize: 17,
                color: Color(0xff025B8F),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Container(
              height: 6.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black12),
                // color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '12/17/2023',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(),
                        );
                      },
                      child: SvgPicture.asset('assets/svgs/calendar.svg'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text(
                  'Start',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    color: Color(0xff025B8F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 2.7),
                Text(
                  'End',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    color: Color(0xff025B8F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black12),
                      // color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedTime.format(context)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: SvgPicture.asset('assets/svgs/time.svg'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black12),
                      // color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${selectedTime.format(context)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: SvgPicture.asset('assets/svgs/time.svg'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              'Location',
              style: GoogleFonts.inter(
                fontSize: 17,
                color: Color(0xff025B8F),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black12),
                      // color: Colors.blue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Machester Road London',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 1.h),
                Container(
                  height: 6.h,
                  width: 6.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12),
                    // color: Colors.red,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                        'assets/svgs/teenyicons_location-solid.svg'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            ListTile(
              dense: true,
              title: Text(
                'Machester Road London',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black),
              ),
              trailing: Obx(
                    () => Switch(
                  activeTrackColor: Colors.green,
                  value: light0.value,
                  onChanged: (bool value) {
                    light0.value = value;
                  },
                ),
              ),
            ),
            ListTile(
              dense: true,
              title: Text(
                'Machester Road London',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black),
              ),
              trailing: Obx(
                    () => Switch(
                  activeTrackColor: Colors.green,
                  value: light1.value,
                  onChanged: (bool value) {
                    light1.value = value;
                  },
                ),
              ),
            ),
            Spacer(),
            Row(
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
                      child: Text(
                        'Save Draft',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => CreateEvent3Screen());
                    },
                    child: Container(
                      height: 5.5.h,
                      width: screenWidth / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xff025B8F),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
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
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Date&Time Picker.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Your Dialog Content Here",
                style: TextStyle(color: Colors.white)),
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}

// Text(
//   "Selected time: ${selectedTime.format(context)}",
//   style: TextStyle(fontSize: 16),
// ),
// SizedBox(height: 20),
// ElevatedButton(
//   onPressed: () => _selectTime(context),
//   child: Text('Select Time'),
// ),
