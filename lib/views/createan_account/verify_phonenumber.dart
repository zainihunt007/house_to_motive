import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

import '../screens/navigation_bar/home_page.dart';

class CreateaccVerifyNumberScreen extends StatelessWidget {
  const CreateaccVerifyNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.31,
                child: Stack(
                  children: [
                    Image.asset('assets/pngs/htmimage.png'),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Image.asset(
                        'assets/pngs/htmlogo.png',
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 50,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset(
                            'assets/pngs/back_btn.png',
                          )),
                    ),
                  ],
                ),
              ),
              const Text(
                '00:36',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff025B8F),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              const Text(
                textAlign: TextAlign.center,
                "Type the verification code  we’ve sent youat +923484812310",
                style: TextStyle(
                  color: Color(0xff424B5A),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Pinput(
                length: 6,
                defaultPinTheme: PinTheme(
                  textStyle: const TextStyle(fontSize: 22),
                  height: 56,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Color(0xff025B8F)
                    border: Border.all(color: Colors.black38),
                    // color: Colors.black38
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                      backgroundColor: Colors.red, BottomSheetDialog());
                },
                child: const Text(
                  "Send Again",
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xff025B8F),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomSheetDialog extends StatelessWidget {
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
              SvgPicture.asset('assets/svgs/bsicon.svg'),
              const SizedBox(height: 7),
              const Text(
                'Code Verified',
                style: TextStyle(
                    color: Color(0xff010101),
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 7),
              const Text(
                textAlign: TextAlign.center,
                '6 digit code is verified, now can you login with your email / phone number and password!',
                style: TextStyle(
                  color: Color(0xff424B5A),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 44,
                    width: 140,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xff090808),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        'Close',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff090808),
                            fontWeight: FontWeight.w500),
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
                        Get.to(() => HomePage());
                      },
                      child: const Center(
                        child: Text(
                          'Let me in',
                          style: TextStyle(
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
