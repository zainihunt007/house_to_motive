import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../upload_your_video.dart';
import 'events_nearme.dart';
import 'things_todo.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // List<String> tags = [
  //   'All',
  //   'Concert',
  //   'Sport',
  //   'Festival',
  //   'Trade Shows',
  //   'videos',
  //   'Music'
  // ];

  // List<RxBool> isSelected = List<RxBool>.generate(7, (index) => false.obs);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    RxBool isSelected = true.obs;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff025B8F),
          leading: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Image.asset('assets/pngs/htmlogo.png'),
          ),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/appbar/Vector@2x.png',
                    height: 9,
                    width: 9,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'My Location',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    const Text(
                      '73 Newport Road, Carnbo',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    Image.asset(
                      'assets/appbar/Vector1.png',
                      height: 9,
                      width: 9,
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            SvgPicture.asset('assets/appbar/heart.svg'),
            const SizedBox(width: 10),
            SvgPicture.asset('assets/appbar/Notification.svg'),
            const SizedBox(width: 10),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (isSelected.value == false) {
                              isSelected.value = true;
                            }
                          },
                          child: Container(
                            height: screenHeight * 0.07,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              color: isSelected.value
                                  ? const Color(0xff025B8F)
                                  : Colors.white,
                            ),
                            child: Center(
                              child: isSelected.value
                                  ? Text(
                                      '🎉  Things to Do',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white),
                                    )
                                  : Text(
                                      '🎉 Things to Do',
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Color(0xff025B8F)),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (isSelected.value == true) {
                              isSelected.value = false;
                            }
                          },
                          child: Container(
                            height: screenHeight * 0.07,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              color: !isSelected.value
                                  ? const Color(0xff025B8F)
                                  : Colors.white,
                            ),
                            child: Center(
                              child: !isSelected.value
                                  ? Text(
                                '🗓️  Events Near Me',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Colors.white),
                              )
                                  : Text(
                                '🗓️  Events Near Me',
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: Color(0xff025B8F)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                isSelected.value
                    ? const HomeScreen2()
                    : const EventsNearmeScreen(),
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.of(context).push(_createRoute());
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Color(0xffFF0092),
                    Color(0xff216DFD),
                  ],
                ),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ListTile(
// leading: CircleAvatar(
// backgroundImage: AssetImage(userData.image),
// ),
// title: Text(userData.username),
// subtitle: Text('${userData.miles} miles'),
// // Add more widgets or customize the ListTile as needed
// );

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const UploadYourViedoScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
