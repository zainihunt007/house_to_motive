import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../views/screens/notification_screen.dart';
import '../../constants/color.dart';
import 'FavEvents.dart';
import 'FavVideos.dart';
import 'myfavourite.dart';

// class FavListController extends GetxController {
//   RxBool isSelectedVideos = false.obs;
//   RxBool isSelectedEvents = false.obs;
//   RxBool isSelectedRestaurants = false.obs;
//
//   void selectVideos() {
//     isSelectedVideos.value = true;
//     isSelectedEvents.value = false;
//     isSelectedRestaurants.value = false;
//   }
//
//   void selectEvents() {
//     isSelectedVideos.value = false;
//     isSelectedEvents.value = true;
//     isSelectedRestaurants.value = false;
//   }
//
//   void selectRestaurants() {
//     isSelectedVideos.value = false;
//     isSelectedEvents.value = false;
//     isSelectedRestaurants.value = true;
//   }
// }
//
// class FavList extends StatelessWidget {
//   FavList({Key? key}) : super(key: key);
//
//   final FavListController controller = Get.put(FavListController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//             size: 19,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xff025B8F),
//         title: Text(
//           'My Favourites',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Obx(
//               () => Row(
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     controller.selectVideos();
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>FavVideos()));
//                   },
//                   child: Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width / 3,
//                     decoration: BoxDecoration(
//                       borderRadius: controller.isSelectedVideos.value ?
//                       BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         topLeft: Radius.circular(10),
//
//                       ) : BorderRadius.only(topRight: Radius.circular(0),
//                         bottomRight: Radius.circular(0),
//                         bottomLeft: Radius.circular(20),
//                         topLeft: Radius.circular(20),  ),
//                       color: controller.isSelectedVideos.value
//                           ? const Color(0xff025B8F)
//                           : Colors.white,
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Videos",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: controller.isSelectedVideos.value
//                               ? Colors.white
//                               : seagreen,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     controller.selectEvents();
//                   },
//                   child: Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width / 3,
//                     decoration: BoxDecoration(
//                       borderRadius: controller.isSelectedVideos.value ? BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//
//                         topLeft: Radius.circular(10),)
//                               :
//                           BorderRadius.only(
//                             topRight: Radius.circular(0),
//                             topLeft: Radius.circular(0),
//                             bottomRight: Radius.circular(0),
//                             bottomLeft: Radius.circular(0)
//
//
//                       ),
//                       color: controller.isSelectedEvents.value
//                           ? const Color(0xff025B8F)
//                           : Colors.white,
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Events",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: controller.isSelectedEvents.value
//                               ? Colors.white
//                               : seagreen,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     controller.selectRestaurants();
//                   },
//                   child: Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width / 3,
//                     decoration: BoxDecoration(
//                       borderRadius:
//                       controller.isSelectedVideos.value ?
//                       BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         topLeft: Radius.circular(10),
//                       )
//                       :
//                         BorderRadius.only(
//                         topLeft: Radius.circular(0),
//                     bottomLeft: Radius.circular(0),
//                     topRight: Radius.circular(20),
//                     bottomRight:
//                       Radius.circular(20)
//                     ),
//                       color: controller.isSelectedRestaurants.value
//                           ? const Color(0xff025B8F)
//                           : Colors.white,
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Restaurants",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: controller.isSelectedRestaurants.value
//                               ? Colors.white
//                               : seagreen,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FavListController extends GetxController {
//   RxBool isSelectedVideos = false.obs;
//   RxBool isSelectedEvents = false.obs;
//   RxBool isSelectedRestaurants = false.obs;
//
//   void selectVideos() {
//     isSelectedVideos.value = true;
//     isSelectedEvents.value = false;
//     isSelectedRestaurants.value = false;
//   }
//
//   void selectEvents() {
//     isSelectedVideos.value = false;
//     isSelectedEvents.value = true;
//     isSelectedRestaurants.value = false;
//   }
//
//   void selectRestaurants() {
//     isSelectedVideos.value = false;
//     isSelectedEvents.value = false;
//     isSelectedRestaurants.value = true;
//   }
// }
//
// class FavList extends StatefulWidget {
//   FavList({Key? key}) : super(key: key);
//
//   @override
//   State<FavList> createState() => _FavListState();
// }
//
// class _FavListState extends State<FavList> {
//   final FavListController controller = Get.put(FavListController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () {
//             Get.back();
//           },
//           child: const Icon(
//             Icons.arrow_back_ios,
//             color: Colors.white,
//             size: 19,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xff025B8F),
//         title: Text(
//           'My Favourites',
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body:Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Row(
//           children: List.generate(
//             3,
//                 (index) {
//               final selected = controller.selectedIndex.value == index;
//               return Expanded(
//                 child: GestureDetector(
//                   onTap: () {
//                     controller.selectItem(index);
//                   },
//                   child: Container(
//                     height: 40,
//                     decoration: BoxDecoration(
//                       color: selected ? const Color(0xff025B8F) : Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(
//                           selected ? 10.0 : 0.0,
//                         ),
//                         bottomLeft: Radius.circular(
//                           selected ? 10.0 : 0.0,
//                         ),
//                         topRight: Radius.circular(
//                           selected ? 10.0 : 0.0,
//                         ),
//                         bottomRight: Radius.circular(
//                           selected ? 10.0 : 0.0,
//                         ),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         index == 0
//                             ? "Videos"
//                             : index == 1
//                             ? "Events"
//                             : "Restaurants",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w400,
//                           color: selected ? Colors.white : seagreen,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//
//
//
// );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//     );
//   }
// }
//
// class NavigationButtons extends StatelessWidget {
//   final MyController _controller = Get.put(MyController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: Obx(() => Container(
//               height: 40,
//               width: MediaQuery.of(context).size.width / 3,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(_controller.isVideoSelected.value ? 10 : 0),
//                   topLeft: Radius.circular(_controller.isVideoSelected.value ? 10 : 0),
//                   topRight: Radius.circular(_controller.isRestaurantSelected.value ? 10 : 0),
//                   bottomRight: Radius.circular(_controller.isRestaurantSelected.value ? 10 : 0),
//                 ),
//                 color: _controller.isVideoSelected.value ? Colors.red : Colors.transparent,
//               ),
//               child: Center(
//                 child: Text(
//                   'Video',
//                   style: TextStyle(
//                     color: _controller.isVideoSelected.value ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//             )),
//           ),
//           Expanded(
//             child: Obx(() => Container(
//               height: 40,
//               width: MediaQuery.of(context).size.width / 3,
//               decoration: BoxDecoration(
//                 color: _controller.isEventSelected.value ? Colors.blue : Colors.transparent,
//               ),
//               child: Center(
//                 child: Text(
//                   'Event',
//                   style: TextStyle(
//                     color: _controller.isEventSelected.value ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//             )),
//           ),
//           Expanded(
//             child: Obx(() => Container(
//               height: 40,
//               width: MediaQuery.of(context).size.width / 3,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(_controller.isEventSelected.value ? 10 : 0),
//                   bottomRight: Radius.circular(_controller.isEventSelected.value ? 10 : 0),
//                 ),
//                 color: _controller.isRestaurantSelected.value ? Colors.black : Colors.transparent,
//               ),
//               child: Center(
//                 child: Text(
//                   'Restaurants',
//                   style: TextStyle(
//                     color: _controller.isRestaurantSelected.value ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//             )),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class MyController extends GetxController {
//   RxBool isVideoSelected = false.obs;
//   RxBool isEventSelected = false.obs;
//   RxBool isRestaurantSelected = false.obs;
//
//   void selectVideo() {
//     isVideoSelected.value = true;
//     isEventSelected.value = false;
//     isRestaurantSelected.value = false;
//   }
//
//   void selectEvent() {
//     isVideoSelected.value = false;
//     isEventSelected.value = true;
//     isRestaurantSelected.value = false;
//   }
//
//   void selectRestaurant() {
//     isVideoSelected.value = false;
//     isEventSelected.value = false;
//     isRestaurantSelected.value = true;
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Getx Navigation'),
//       ),
//       body: NavigationButtons()
class FavListController extends GetxController {
  RxBool isSelectedVideos = true.obs;
  RxBool isSelectedEvents = false.obs;
  RxBool isSelectedRestaurants = false.obs;

  void selectVideos() {
    isSelectedVideos.value = true;
    isSelectedEvents.value = false;
    isSelectedRestaurants.value = false;
  }

  void selectEvents() {
    isSelectedVideos.value = false;
    isSelectedEvents.value = true;
    isSelectedRestaurants.value = false;
  }

  void selectRestaurants() {
    isSelectedVideos.value = false;
    isSelectedEvents.value = false;
    isSelectedRestaurants.value = true;
  }
}

class FavList extends StatefulWidget {
  FavList({Key? key}) : super(key: key);

  @override
  State<FavList> createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  final FavListController controller = Get.put(FavListController());

  int flag = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'My Favourites',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          // GestureDetector(
          //     onTap: (){
          //       Get.to(() => FavList());
          //     },
          //     child: SvgPicture.asset('assets/appbar/heart.svg')),
          const SizedBox(width: 10),
          GestureDetector(
              onTap: (){
                Get.to(() => NotificationScreen());
              },
              child: SvgPicture.asset('assets/appbar/Notification.svg')),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
        child: Column(
          children: [
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.selectVideos();
                        setState(() {
                          flag = 1;
                        });

                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>FavVideos()));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: controller.isSelectedVideos.value
                              ? BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                )
                              : BorderRadius.only(
                                  topRight: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                          color: controller.isSelectedVideos.value
                              ? const Color(0xff025B8F)
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Videos",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: controller.isSelectedVideos.value
                                  ? Colors.white
                                  : seagreen,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.selectEvents();
                        setState(() {
                          flag = 2;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: controller.isSelectedVideos.value
                              ? BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                )
                              : BorderRadius.only(
                                  topRight: Radius.circular(0),
                                  topLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(0),
                                  bottomLeft: Radius.circular(0)),
                          color: controller.isSelectedEvents.value
                              ? const Color(0xff025B8F)
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Events",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: controller.isSelectedEvents.value
                                  ? Colors.white
                                  : seagreen,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.selectRestaurants();
                        setState(() {
                          flag = 3;
                        });
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: controller.isSelectedVideos.value
                              ? BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                )
                              : BorderRadius.only(
                                  topLeft: Radius.circular(0),
                                  bottomLeft: Radius.circular(0),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                          color: controller.isSelectedRestaurants.value
                              ? const Color(0xff025B8F)
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            "Restaurants",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: controller.isSelectedRestaurants.value
                                  ? Colors.white
                                  : seagreen,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            flag == 1
                ? Expanded(child: FavVideos())
                : flag == 2
                    ? Expanded(child: FavEvents())
                    : flag == 3
                        ? Expanded(
                            child: FavRestaurants())
                        : Expanded(
                            child: Container(
                            color: Colors.white,
                            child: FavVideos(),
                          ))
          ],
        ),
      ),
    );
  }
}
