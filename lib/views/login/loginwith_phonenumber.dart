import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:house_to_motive/views/login/loginwith_email.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../widgets/custom_field.dart';
import '../../widgets/custom_socialbutton.dart';
import '../../widgets/loginbutton.dart';
import 'forgot_password.dart';

class LoginWithPhoneNumberScreen extends StatelessWidget {
  const LoginWithPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0,right: 12.0),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.31,
                child: Stack(
                  children: [
                    Opacity(opacity: 0.1,child: Image.asset('assets/pngs/htmimage1.png',),),
                    Positioned(
                      bottom: 80,
                      right: 120,
                      child: SvgPicture.asset(
                        'assets/svgs/splash-logo.svg',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 50,
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            'assets/svgs/back_btn.svg',
                          )),
                    ),
                  ],
                ),
              ),
              const Text(
                'Login To Continue',
                style: TextStyle(
                  fontFamily: 'Mont',
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff025B8F),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01
              ),
              const Text(
                'Welcome back to HouseToMotive!',
                style: TextStyle(
                  fontFamily: 'ProximaNova',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff424B5A),),
              ),
              SizedBox(
                  height: screenHeight * 0.03
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButtonWithIcon(
                    ontap: (){
                      Get.to(()=>  LoginWithEmailScreen());
                    },
                    title: 'With Email',
                    svg: "assets/svgs/social/Mail.svg",
                  ),
                  CustomSocialButton(svg: "assets/svgs/social/google.svg",ontap: (){},),
                  CustomSocialButton(svg: "assets/svgs/social/fb.svg",ontap: (){},),
                ],
              ),
              SizedBox(height: screenHeight * 0.03),
              const Text(
                'Or with Email Phone Number',
                style: TextStyle(
                  fontFamily: 'ProximaNova',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff424B5A),),
              ),
              SizedBox(
                height: screenHeight * 0.02
              ),
              // CheckDotComWidget(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.068,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffD9D9D9)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8),
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        print(
                            number.phoneNumber); // Prints the entered phone number
                      },
                      onInputValidated: (bool value) {
                        // Callback when the phone number is validated or not
                        print(value);
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      // initialValue: _phoneNumber,
                      textFieldController: TextEditingController(),
                      formatInput: false,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputDecoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          fontFamily: 'ProximaNova',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7390A1),),
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(),
                        // ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const CustomPasswordField(title: 'Enter password'),
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
                      fontFamily: 'ProximaNova',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff424B5A),),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(()=> ForgotPasswordScreen());
                    },
                    child: const Text(
                      ' Sign Up',
                      style: TextStyle(
                      fontFamily: 'ProximaNova',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff025B8F),),
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
