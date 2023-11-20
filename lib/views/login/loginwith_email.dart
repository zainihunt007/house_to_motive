import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:house_to_motive/widgets/custom_socialbutton.dart';

import '../../widgets/loginbutton.dart';
import '../../widgets/custom_field.dart';
import '../createan_account/signup_screen.dart';
import 'loginwith_phonenumber.dart';

class LoginWithEmailScreen extends StatelessWidget {
  const LoginWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
                            // Get.back();
                          },
                          child: Image.asset(
                            'assets/pngs/back_btn.png',
                          )),
                    ),
                  ],
                ),
              ),
              const Text(
                'Login To Continue',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff025B8F),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              const Text(
                'Welcome back to HouseToMotive!',
                style: TextStyle(
                  color: Color(0xff424B5A),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButtonWithIcon(
                      ontap: () {
                        Get.to(() => LoginWithPhoneNumberScreen());
                      },
                      title: 'Login With Email',
                      svg: "assets/svgs/social/Call.svg"),
                  CustomSocialButton(
                      svg: "assets/svgs/social/google.svg", ontap: () {}),
                  CustomSocialButton(
                    svg: "assets/svgs/social/fb.svg",
                    ontap: () {},
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              const Text(
                'Or with Email',
                style: TextStyle(
                  color: Color(0xff424B5A),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              CustomEmailField(),
              SizedBox(height: screenHeight * 0.01),
              const CustomPasswordField(),
              SizedBox(height: screenHeight * 0.03),
              CustomButton(
                title: "Login",
                ontap: () {},
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'New User?',
                    style: TextStyle(
                      color: Color(0xff424B5A),
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const SignupScreen());
                    },
                    child: const Text(
                      ' Sign Up',
                      style: TextStyle(
                        color: Color(0xff025B8F),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
