import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:house_to_motive/controller/event_controller.dart';
import 'package:house_to_motive/mrg/ticketDetails.dart';
import 'package:intl/intl.dart';
import 'Sanzio_Restaurant.dart';

class ArcadeScreen extends StatefulWidget {
  final description;
  final photoURL;
  final startTime;
  final endTime;
  final eventName;
  final location;
  final date;
  const ArcadeScreen({
    Key? key,
    required this.description,
    required this.photoURL,
    required this.startTime,
    required this.endTime,
    required this.eventName,
    required this.location,
    required this.date,
  }) : super(key: key);

  @override
  State<ArcadeScreen> createState() => _ArcadeScreenState();
}

class _ArcadeScreenState extends State<ArcadeScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime date = widget.date.toDate();

    // Format the DateTime to a string
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    final Size size = MediaQuery.of(context).size;
    TicketController ticketController = Get.put(TicketController());
    return Scaffold(
        backgroundColor: const Color(0xffF6F9FF),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 500,
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.height / 3,
                      child: Image.network(
                        widget.photoURL,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: size.height / 4.8,
                            ),
                            IconButton(
                              onPressed: () {
                                Get.back();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new,
                                size: 19,
                                color: Colors.white,
                              ),
                            ),
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
                          height: size.height / 28,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            children: [
                              Container(
                                width: size.width / 3.5,
                                height: size.height / 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xffFF0092),
                                      Color(0xff216DFD)
                                    ],
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    // Button pressed action
                                  },
                                  child: const Center(
                                    child: Text(
                                      'Open Map',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width / 2.2,
                              ),
                              Container(
                                width: size.width / 5,
                                height: size.height / 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: const Color(0XFF21C663)),
                                child: InkWell(
                                  onTap: () {
                                    // Button pressed action
                                  },
                                  child: const Center(
                                    child: Text(
                                      'Open ',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.eventName,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            "\$9.99",
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
                          Text(
                            "  ${widget.location}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xff707B81),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 100,
                      ),
                      Row(
                        children: [
                          Image.asset("assets/stopwatch.png"),
                          Text(
                              "  Open: ${widget.startTime} - ${widget.endTime}",
                              style: const TextStyle(
                                  fontSize: 14, color: Color(0xff707B81))),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          Image.asset("assets/Star 2.png"),
                          const Text(" 91 (5.0)",
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xff707B81))),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("assets/model2.jpg"),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height / 90),
                            const Text(
                              "Jame",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                            SizedBox(height: size.height / 80),
                            const Text(
                              "Organizer",
                              style: TextStyle(
                                  color: Color(0xff8A8B8F), fontSize: 12),
                            ),
                          ],
                        ),
                        trailing: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade200),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                colors: [Color(0xffFF0092), Color(0xff216DFD)],
                              ).createShader(bounds);
                            },
                            child: const Center(
                              child: Text(
                                "Follow",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      //
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Tickets Type",
                            style: TextStyle(
                                color: Color(0xff3D3D3D),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          )),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const ticketDetails()));
                            },
                            child: Container(
                              height: size.height / 14,
                              width: size.width / 3,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: const Color(0xffE45900)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height / 55,
                                  ),
                                  const Text("Regular",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  SizedBox(
                                    height: size.height / 400,
                                  ),
                                  const Text("\$9.99",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const ticketDetails()));
                            },
                            child: Container(
                              height: size.height / 14,
                              width: size.width / 3,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0XFF4ADE80),
                                    Color(0XFF256F40)
                                  ]),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: const Color(0xffE45900)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height / 55,
                                  ),
                                  const Text("VIP",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  SizedBox(
                                    height: size.height / 400,
                                  ),
                                  const Text("\$19.00",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width / 40,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const ticketDetails()));
                            },
                            child: Container(
                              height: size.height / 14,
                              width: size.width / 3,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0XFFFBD22F),
                                    Color(0XFFC89F00)
                                  ]),
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: const Color(0xffE45900)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: size.height / 55,
                                  ),
                                  const Text("Table",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  SizedBox(
                                    height: size.height / 400,
                                  ),
                                  const Text("\$29.00",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),

                      SizedBox(
                        height: size.height / 40,
                      ),
                      //
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Time and Venue",
                            style: TextStyle(
                                color: Color(0xff3D3D3D),
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: ListTile(
                              leading: SvgPicture.asset("assets/Date.svg"),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(formattedDate,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                  SizedBox(height: size.height / 55),
                                  const Text(
                                    "Sunday, 5:30PM - 7:30PM",
                                    style: TextStyle(
                                        fontSize: 8, color: Color(0XFF707B81)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  8.0), // Adjust the spacing between ListTiles
                          Flexible(
                            child: ListTile(
                              leading: SvgPicture.asset("assets/loc.svg"),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("158 The Green",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.black)),
                                  SizedBox(height: size.height / 55),
                                  const Text(
                                    "Eko Hotel and Suite. VI",
                                    style: TextStyle(
                                        fontSize: 8, color: Color(0XFF707B81)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),

                      Container(
                        height: size.height / 11,
                        color: Colors.white,
                        child: Row(
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
                                      backgroundImage:
                                          AssetImage("assets/model2.jpg"),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage("assets/model1.jpg"),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage("assets/model2.jpg"),
                                  ),
                                ],
                              ),
                            ),
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  colors: [
                                    Color(0xffFF0092),
                                    Color(0xff216DFD)
                                  ],
                                ).createShader(bounds);
                              },
                              child: const Text(
                                "780 Attending",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: size.width / 6,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    colors: [
                                      Color(0xffFF0092),
                                      Color(0xff216DFD)
                                    ],
                                  ).createShader(bounds);
                                },
                                child: const Center(
                                  child: Text(
                                    "Invite",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 40,
                      ),
                      Container(
                        height: size.height / 11,
                        color: Colors.white,
                        child: Row(
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
                                      backgroundImage:
                                          AssetImage("assets/model1.jpg"),
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          AssetImage("assets/model2.jpg"),
                                    ),
                                  ),
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundImage:
                                        AssetImage("assets/model2.jpg"),
                                  ),
                                ],
                              ),
                            ),
                            ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  colors: [
                                    Color(0xffFF0092),
                                    Color(0xff216DFD)
                                  ],
                                ).createShader(bounds);
                              },
                              child: const Text(
                                "748 Followers",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: size.width / 6,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.shade200),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    colors: [
                                      Color(0xffFF0092),
                                      Color(0xff216DFD)
                                    ],
                                  ).createShader(bounds);
                                },
                                child: const Center(
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
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 30),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        style: TextStyle(
                            color: Color(0xff3D3D3D),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      )),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 30),
                  child: Text(widget.description,
                      style: const TextStyle(
                          color: Color(0XFF7390A1), fontSize: 12)),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fixedSize: const Size(300, 50),
                    backgroundColor: const Color(0xff025B8F),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ticketDetails()));
                  },
                  child: const Text("Book Your Ticket - \$9.99",
                      style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(
                  height: 20,
                  width: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
