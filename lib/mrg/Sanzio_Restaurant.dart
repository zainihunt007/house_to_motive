import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'ArcadeScreen.dart';
import 'Review_Screen.dart';
class SanzioRestaurant extends StatefulWidget {
  const SanzioRestaurant({Key? key}) : super(key: key);

  @override
  State<SanzioRestaurant> createState() => _SanzioRestaurantState();
}

class _SanzioRestaurantState extends State<SanzioRestaurant> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width /600,),
          child: Column(
      children: [
          Stack(
            children: [
              Image.asset("assets/Rectangle 6.png",fit: BoxFit.cover),
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: size.height / 4.8,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 19,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: size.width / 1.8,
                      ),
                      SvgPicture.asset("assets/Frame 48095548.svg"),
                      SizedBox(
                        width: size.width / 40,
                      ),
                      SvgPicture.asset("assets/Frame 48095547.svg"),
                    ],
                  ),
                  SizedBox(
                    height: size.height / 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      children: [
                        InkWell(onTap:(){

                        },
                          child: Container(
                            width: size.width / 3.5,
                            height: size.height / 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                colors: [Color(0xffFF0092), Color(0xff216DFD)],
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>ArcadeScreen()));
                              },
                              child: const Center(
                                child: Text(
                                  'Open Map',
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: size.width / 2.2,
                        ),
                        InkWell(onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>ArcadeScreen()));
                        },
                          child: Container(
                            width: size.width / 5,
                            height: size.height / 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color(0XFF21C663)
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>ArcadeScreen()));
                              },
                              child: const Center(
                                child: Text(
                                  'Open ',
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: size.height / 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sanzio Restaurant",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$43.99",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0XFF025B8F)),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Row(
                  children: [
                    Image.asset("assets/Location.png"),
                    const Text("  540 Manchester Road London SE81 6UN",
                        style: TextStyle(fontSize: 14, color: Color(0xff707B81))),
                  ],
                ),
                SizedBox(
                  height: size.height / 100,
                ),
                Row(
                  children: [
                    Image.asset("assets/stopwatch.png"),
                    const Text("  Open: 10:00 am - 2:00 pm",
                        style: TextStyle(fontSize: 14, color: Color(0xff707B81))),
                    SizedBox(
                      width: size.width / 40,
                    ),
                    Image.asset("assets/Star 2.png"),
                    const Text(" 91 (5.0)",
                        style: TextStyle(fontSize: 14, color: Color(0xff707B81))),
                  ],
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Description",
                      style: TextStyle(
                          color: Color(0xff3D3D3D),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
                SizedBox(
                  height: size.height / 40,
                ),
                const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    style: TextStyle(color: Color(0XFF7390A1), fontSize: 12)),
                SizedBox(height: size.height/40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 40,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage("assets/model1.jpg"),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage("assets/model2.jpg"),
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage("assets/model2.jpg"),
                          ),
                        ],
                      ),
                    ),
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          colors: [Color(0xffFF0092), Color(0xff216DFD)],
                        ).createShader(bounds);
                      },
                      child: const Text(
                        "369 Followers",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(width: size.width/6,),
                    Container(  width: MediaQuery.of(context).size.width * 0.2,height: 35,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          color:  Colors.grey.shade200),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Color(0xffFF0092), Color(0xff216DFD)],
                          ).createShader(bounds);
                        },
                 child:   Center(
                   child: Text(
                          "Follow",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                 ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const Expanded(child: ReviewScreen()),
      ],
    ),
        ));
  }
}
