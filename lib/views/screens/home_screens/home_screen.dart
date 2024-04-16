import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/appbar_location.dart';
import '../explore_screen.dart';
import '../upload_your_video.dart';
import 'events_nearme.dart';
import 'things_todo.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final placeApiController = Get.put(PlacesApi());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // List<String> tags = [
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    RxBool isSelected = true.obs;

    return Obx(
      () => Scaffold(
        appBar: const CustomAppBar(),
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
                                  ? const Text(
                                      '🎉  Things to Do',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white),
                                    )
                                  : const Text(
                                      '🎉 Things to Do',
                                      style: TextStyle(
                                        fontFamily: 'arial',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: Color(0xff025B8F),
                                      ),
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
                                  ? const Text(
                                      '🗓️  Events Near Me',
                                      style: TextStyle(
                                          fontFamily: 'arial',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                          color: Colors.white),
                                    )
                                  : const Text(
                                      '🗓️  Events Near Me',
                                      style: TextStyle(
                                          fontFamily: 'arial',
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
                isSelected.value ? HomeScreen2() : const EventsNearmeScreen(),
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
        UploadYourViedoScreen(),
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
