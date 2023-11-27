import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pinput/pinput.dart';

import '../screens/chat_screen.dart';
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
                      BottomSheetDeletDialog());
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
