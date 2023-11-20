import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:house_to_motive/views/login/verify_phonenumber.dart';
import 'package:house_to_motive/widgets/loginbutton.dart';

import '../../widgets/custom_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0,right: 12.0),
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
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff025B8F),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              const Text(
                textAlign: TextAlign.center,
                "Enter email / phone number.We will send you a 6-digit code to verify your account.",
                style: TextStyle(
                  color: Color(0xff424B5A),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomEmailField(),
              SizedBox(height: screenHeight * 0.03),
              CustomButton(
                title: 'Reset Password',
                ontap: () {},
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Didn’t get the code? ',
                    style: TextStyle(
                      color: Color(0xff424B5A),
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => VerifyPhoneNumberScreen());
                    },
                    child: const Text(
                      ' Resend Again',
                      style: TextStyle(
                        color: Color(0xff025B8F),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
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
