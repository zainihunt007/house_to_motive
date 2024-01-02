import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../mrg/screens/Favourites/newFav.dart';
import 'notification_screen.dart';


// Create a function to generate custom marker icon


class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  // static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  String address = '' ;
  final Completer<GoogleMapController> _controller = Completer();


  Future<Position> _getUserCurrentLocation() async {


    await Geolocator.requestPermission().then((value) {

    }).onError((error, stackTrace){
      print(error.toString());
    });

    return await Geolocator.getCurrentPosition();

  }


  final List<Marker> _markers =  <Marker>[];

  static const CameraPosition _kGooglePlex =  CameraPosition(
    target: LatLng(33.6844, 73.0479),
    zoom: 14,
  );


  List<Marker> list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(33.6844, 73.0479),
        infoWindow: InfoWindow(
            title: 'some Info '
        ),
    ),

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.addAll(list);
    //loadData();
  }

  loadData(){
    _getUserCurrentLocation().then((value) async {
      _markers.add(
          Marker(
              markerId: const MarkerId('SomeId'),
              position: LatLng(value.latitude ,value.longitude),
              infoWindow:  InfoWindow(
                  title: address
              )
          )
      );

      final GoogleMapController controller = await _controller.future;
      CameraPosition _kGooglePlex =  CameraPosition(
        target: LatLng(value.latitude ,value.longitude),
        zoom: 14,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // Implement your home screen UI here
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Color(0xff025B8F),
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
                SizedBox(width: 10),
                Text(
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
                  SizedBox(width: 10),
                  const Text(
                    '73 Newport Road, Carnbo',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(width: 10),
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
          GestureDetector(
              onTap: () {
                Get.to(() => FavList());
              },
              child: SvgPicture.asset('assets/appbar/heart.svg')),
          const SizedBox(width: 10),
          GestureDetector(
              onTap: () {
                Get.to(() => NotificationScreen());
              },
              child: SvgPicture.asset('assets/appbar/Notification.svg')),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Stack(
              children: [
                Container(
                  height: Get.height / 1.27,
                  width: Get.width,
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    initialCameraPosition: _kGooglePlex,
                    mapType: MapType.normal,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: false,
                    markers: Set<Marker>.of(_markers),
                    onMapCreated: (GoogleMapController controller){
                      _controller.complete(controller);
                    },
                  ),
                ),
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 7.h,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search what’s near me",
                          hintStyle: TextStyle(
                            fontFamily: 'ProximaNova',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff424B5A),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/svgs/search-normal.svg',
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: InkWell(
          onTap: (){
            _getUserCurrentLocation().then((value) async {
              _markers.add(
                  Marker(
                      markerId: const MarkerId('SomeId'),
                      position: LatLng(value.latitude ,value.longitude),
                      infoWindow:  InfoWindow(
                          title: address
                      )
                  )
              );
              final GoogleMapController controller = await _controller.future;

              CameraPosition _kGooglePlex =  CameraPosition(
                target: LatLng(value.latitude ,value.longitude),
                zoom: 14,
              );
              controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));

              // List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude ,value.longitude);
              //
              //
              // final add = placemarks.first;
              // address = add.locality.toString() +" "+add.administrativeArea.toString()+" "+add.subAdministrativeArea.toString()+" "+add.country.toString();

              setState(() {

              });
            });
          },
          child: Container(
            width: 48,
            height: 48,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Color(0xffFF0092),
                  Color(0xff216DFD),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
