import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/widgets/custom_field.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../widgets/loginbutton.dart';
import 'notification_screen.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Edit Profile',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Stack(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.black,
                    backgroundImage: AssetImage('assets/images/3.jpg'),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 10,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      // backgroundImage: AssetImage('assets/images/2.jpg'),
                      radius: 8,
                      backgroundColor: Color(0xff025B8F),
                      child: Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                          size: 10,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.06),
            CustomEmailField(),
            CustomEmailField(),
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
                          number.phoneNumber);
                    },
                    onInputValidated: (bool value) {

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
            Spacer(),
            CustomButton(
              title: "Login",
              ontap: () {
                Get.to(() => NotificationScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
