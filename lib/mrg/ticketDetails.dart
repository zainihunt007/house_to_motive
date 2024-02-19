import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'checkoutMethod.dart';

class ticketDetails extends StatelessWidget {
  const ticketDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0XFF025B8F),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [InkWell(onTap: () {
            Get.back();
          },
              child: Icon(Icons.arrow_back_ios_new_sharp,color: Colors.white,size: 16,)),

            Text(
              "NQ64 ARCADE",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            SizedBox(
              height: 40,
              width: 40,
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 16),
          child: Column(children: [
            SizedBox(
              height: size.height / 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Enter Ticket Details",
                style: TextStyle(
                    color: Color(0XFF025B8F),
                    fontSize: 17,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            TextFormField(
              decoration: InputDecoration(
                  isDense: true,
                  enabledBorder:
                      OutlineInputBorder(borderRadius:  BorderRadius.circular(20),
                          borderSide: BorderSide(color: Color(0xffD9D9D9))),
                  hintText: "User Name",
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xff7390A1)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            TextFormField(
              decoration: InputDecoration(
                  isDense: true,
                  enabledBorder:
                  OutlineInputBorder(borderRadius:  BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xffD9D9D9))),
                  hintText: "Total members",
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xff7390A1)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            TextFormField(
              decoration: InputDecoration(
                  isDense: true,
                  enabledBorder:
                  OutlineInputBorder(borderRadius:  BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xffD9D9D9))),
                  hintText: "Enter email",
                  hintStyle: TextStyle(fontSize: 14, color: Color(0xff7390A1)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: size.height / 60,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "We will send QR code to this email.",
                style: TextStyle(
                    color: Color(0XFF7390A1),
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.072,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffD9D9D9)),
                  borderRadius: BorderRadius.circular(20),
                ),
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
                  inputDecoration: InputDecoration(isDense: true,
                    border: InputBorder.none,
                    hintText: '0000 0000',hintStyle: TextStyle(color: Color(0XFF7390A1))
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    // ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height / 4,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Column(
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [Color(0xffFF0092), Color(0xff216DFD)],
                      ).createShader(bounds);
                    },
                    child: const Text(
                      "£9.99",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 80,
                  ),
                  Text(
                    "Subtotal",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff707B81)),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: const Size(160, 55),
                  backgroundColor: Color(0xff025B8F),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>CheckoutMethod()));
                },
                child: Text("Continue", style: TextStyle(color: Colors.white)),
              ),
            ],)
            
          ]),
        ),
      ),
    );
  }
}
