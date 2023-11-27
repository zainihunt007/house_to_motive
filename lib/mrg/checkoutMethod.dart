import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:house_to_motive/mrg/paymentMethod.dart';

import 'congratulationsScreen.dart';

class CheckoutMethod extends StatefulWidget {
  const CheckoutMethod({Key? key}) : super(key: key);

  @override
  State<CheckoutMethod> createState() => _CheckoutMethodState();
}

class _CheckoutMethodState extends State<CheckoutMethod> {
  final List<Map<String, dynamic>> paymentMethods = [
    {
      'icon': 'assets/mastercard.svg',
      'cardNumber': '**** **** **** 8395',
    },
    {
      'icon': 'assets/paypal.svg',
      'cardNumber': '**** **** **** 6246',
    },
    {
      'icon': 'assets/logos_visa.svg',
      'cardNumber': '** **** **** 624',
    },
    {
      'icon': 'assets/apple.svg',
      'cardNumber': '**** **** **** 9876',
    },
    {
      'icon': 'assets/google.svg',
      'cardNumber': '**** **** **** 1859',
    },
  ];

  late List<bool> selectedList;

  @override
  void initState() {
    super.initState();
    selectedList = List<bool>.generate(paymentMethods.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xffF6F9FF),
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0XFF025B8F),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.white,
                size: 16,
              ),
            ),
            const Text(
              "Checkout",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(
              height: 40,
              width: 40,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 16),
          child: Column(
            children: [
              SizedBox(
                height: size.height / 40,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Payment Method",
                  style: TextStyle(
                    color: Color(0XFF025B8F),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: paymentMethods.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      PaymentMethodCard(
                        icon: paymentMethods[index]['icon'],
                        cardNumber: paymentMethods[index]['cardNumber'],
                        isSelected: selectedList[index],
                        onSelected: (isSelected) {
                          setState(() {
                            // Update the selectedList to have only one true value at a time
                            selectedList = List<bool>.generate(paymentMethods.length, (index) => false);
                            selectedList[index] = isSelected;
                          });
                        },
                      ),
                      SizedBox(height: size.height / 50),
                    ],
                  );
                },
              ),
              SizedBox(height: size.height / 80),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  side: const BorderSide(color: Color(0xff025BBF)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  backgroundColor: const Color(0xffF6F9FF),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PaymentMethodProcess()),
                  );
                },
                child: const Text("Add New Card", style: TextStyle(color: Color(0xff025BBF))),
              ),
              SizedBox(height: size.height / 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Coupon",
                  style: TextStyle(
                    color: Color(0XFF025B8F),
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: size.height / 70),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter referral or coupon code to get a discount on tickets",
                  style: TextStyle(
                    color: Color(0XFF025B8F),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Transform.scale(
                    scale: 0.4,
                    child: SvgPicture.asset("assets/ticket-discount.svg"),
                  ),
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                  ),
                  hintText: "Enter referral / coupon code",
                  hintStyle: const TextStyle(fontSize: 14, color: Color(0xff7390A1)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          "\$29.97",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
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
                          color: Color(0xff707B81),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: const Size(160, 54),
                      backgroundColor: const Color(0xff025B8F),
                    ),
                    onPressed: () {
                      _showBottomSheetSlider(context);
                    },
                    child: const Text("Pay", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20, width: 20),
            ],
          ),
        ),
      ),
    );
  }
  void _showBottomSheetSlider(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.50,
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Expanded(child: congratulationScreen()),
              // Add your content here
            ],
          ),
        );
      },
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final String icon;
  final String cardNumber;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const PaymentMethodCard({
    Key? key,
    required this.icon,
    required this.cardNumber,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected(!isSelected);
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
            ),
          ],color: Colors.white,
          // color: isSelected ? Colors.blue : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const SizedBox(width: 2),
              SvgPicture.asset(
                icon,
                // height: 32,
                // width: 32,
              ),
              SizedBox(
                width: Get.width / 50,
              ),
              Text(
                "  $cardNumber",
                style: TextStyle(color:  Colors.black , fontSize: 14),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected ? Colors.blue : Colors.white,
                      border: Border.all(color: Colors.blue),
                    ),
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
