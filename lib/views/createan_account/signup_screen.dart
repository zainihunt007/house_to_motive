import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:house_to_motive/views/createan_account/signup_phonenumber.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/custom_field.dart';
import '../../widgets/custom_socialbutton.dart';
import '../../widgets/loginbutton.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
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
                // SizedBox(height: 20),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomSocialButton(
                        svg: "assets/svgs/social/fb.svg", ontap: () {}),
                    const SizedBox(width: 20),
                    CustomSocialButton(
                        svg: "assets/svgs/social/google.svg", ontap: () {}),
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
                SizedBox(
                  height: screenHeight * 0.08,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'User Name',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                CustomEmailField(),
                SizedBox(height: screenHeight * 0.01),
                const CustomPasswordField(),
                SizedBox(height: screenHeight * 0.03),
                CustomButton(
                  title: "Continue",
                  ontap: () {},
                ),
                SizedBox(height: screenHeight * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Have an Account? ',
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
                        'Login',
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
      ),
    );
  }
}
