import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:house_to_motive/views/createan_account/signup_screen.dart';
import '../../widgets/custom_field.dart';
import '../../widgets/loginbutton.dart';


class UpdatePasswordScreen extends StatelessWidget {
  const UpdatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
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
                          onTap: (){
                            Get.back();
                          },
                          child: Image.asset('assets/pngs/back_btn.png',)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0,right: 12.0),
                child: Column(
                  children: [
                    const Text(
                      'Update Password',
                      style: TextStyle(
                        fontFamily: 'Mont',
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xff025B8F),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    const Text(
                      textAlign: TextAlign.center,
                      "Password must have 8 digits mix of characters, numbers and symbols.",
                      style: TextStyle(
                        fontFamily: 'ProximaNova',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff424B5A),),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const CustomPasswordField(title: 'Enter password'),
                    SizedBox(height: screenHeight * 0.01),
                    const CustomPasswordField(title: 'Confirm password',),
                    SizedBox(height: screenHeight * 0.03),
                    CustomButton(
                      title: "Update Password",
                      ontap: () {
                        Get.to(()=> SignupScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
