import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:house_to_motive/views/createan_account/verify_phonenumber.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../widgets/loginbutton.dart';

class SignupWithPhoneNumberScreen extends StatelessWidget {
  const SignupWithPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
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
                'Enter Phone Number',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Color(0xff025B8F),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              const Text(
                textAlign: TextAlign.center,
                'Please enter your valid phone number. We will send you a 6-digit code to verify your account. ',
                style: TextStyle(
                  color: Color(0xff424B5A),
                  fontSize: 14,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.074,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
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
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                      ),
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      selectorTextStyle: TextStyle(color: Colors.black),
                      // initialValue: _phoneNumber,
                      textFieldController: TextEditingController(),
                      formatInput: false,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputDecoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Phone Number',
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(),
                        // ),
                      ),
                    ),
                  ),
                ),
              ),
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
                    'Didn’t get the code? ',
                    style: TextStyle(
                      color: Color(0xff424B5A),
                      fontSize: 14,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => CreateaccVerifyNumberScreen());
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