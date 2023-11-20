import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:house_to_motive/views/login/loginwith_email.dart';
import 'package:house_to_motive/widgets/loginbutton.dart';

class AllowLocationScreen extends StatelessWidget {
  const AllowLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(()=> const LoginWithEmailScreen());
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                          color: Color(0xff424B5A),
                          fontWeight: FontWeight.w700,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 7),
              SvgPicture.asset("assets/svgs/location.svg"),
              SizedBox(height: MediaQuery.of(context).size.height / 17),
              const Text(
                'Enable Your Loaction',
                style: TextStyle(
                    fontSize: 37,
                    fontWeight: FontWeight.w900,
                    color: Color(0xff025B8F)),
              ),
              SizedBox(height: 20),
              const Text(
                'Enable your location for optimize search so we can suggest best match for you',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 6),
              CustomButton(
                title: 'Enable Location',
                ontap: () {
                  Get.to(() => LoginWithEmailScreen());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
