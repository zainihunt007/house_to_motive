import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:house_to_motive/views/screens/video_screen.dart';
import '../../widgets/appbar_location.dart';
import 'package:http/http.dart' as http;



class ExploreScreen extends StatefulWidget {
  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
//   // static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  Future<void> _initMap() async {
    try {
      await placeApiController.determinePosition();
      await _fetchAndMarkLocations();
    } catch (e) {
      print("Error initializing map: $e");
    }
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    final Uint8List bytes = response.bodyBytes;

    // Decode the image to a codec
    final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetWidth: 100, targetHeight: 150);
    final ui.FrameInfo fi = await codec.getNextFrame();

    // Get the image from the frame info
    ui.Image image = fi.image;

    // Create a new picture recorder and canvas
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..isAntiAlias = true;

    // Define the rounded rectangle
    final RRect clipRect = RRect.fromRectAndRadius(
      const Rect.fromLTWH(0, 0, 100.0, 150.0),
      const Radius.circular(20.0),
    );

    // Clip the canvas
    canvas.clipRRect(clipRect);

    // Draw the image onto the canvas
    canvas.drawImage(image, Offset.zero, paint);

    // If you want a border around the rounded image, uncomment the following lines
    /*
  final Paint borderPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10.0; // Adjust border width as needed

  canvas.drawRRect(clipRect, borderPaint);
  */

    // End drawing and get the final image
    final ui.Image finalImage = await pictureRecorder.endRecording().toImage(100, 150);
    final ByteData? byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List finalBytes = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(finalBytes);
  }


  Set<Marker> _markers = {};

  Future<void> _fetchAndMarkLocations() async {
    var videoCollection = FirebaseFirestore.instance.collection('videos');
    var querySnapshot = await videoCollection.get();

    List<String> videoUrls = []; // List to store video URLs

    for (var doc in querySnapshot.docs) {
      String address = doc['location'];
      String imageURL = doc['thumbnailUrl'];
      String videoURL = doc['videoUrl'];
      List<Location> locations = await locationFromAddress(address);

      BitmapDescriptor customIcon = await getBitmapDescriptorFromUrl(imageURL);
      Location location = locations.first;

      _markers.add(
        Marker(
          markerId: MarkerId(doc.id),
          position: LatLng(location.latitude, location.longitude),
          icon: customIcon,
          onTap: () {
            // Open VideoScreen when marker is tapped
            Get.to(() => VideoScreen(videoUrls: videoUrls, initialIndex: videoUrls.indexOf(videoURL)));
          },
        ),
      );

      // Add the video URL to the list
      videoUrls.add(videoURL);
    }

    setState(() {});
  }
  final placeApiController = Get.put(PlacesApi());

  @override
  Widget build(BuildContext context) {
    // if (kDebugMode) {
    //   print(placeApiController.address);
    // }
    // Implement your home screen UI here
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Stack(
              children: [
                SizedBox(
                  height: Get.height / 1.2,
                  width: Get.width,
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: false,
                    onMapCreated: placeApiController.onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: placeApiController.target,
                      zoom: placeApiController.defaultZoom,
                    ),
                    markers: _markers.toSet(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      return placeApiController.getSuggestions(textEditingValue.text);
                    },
                    onSelected: (String selection) {
                      placeApiController.searchPlaces(selection);
                    },
                    fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          decoration: InputDecoration(
                            hintText: "Search what’s near me",
                            hintStyle: const TextStyle(
                              fontFamily: 'ProximaNova',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff424B5A),
                            ),
                            isDense: true,
                            contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      );
                    },
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.only(bottom: 80.0),
      //   child: InkWell(
      //     onTap: (){
      //       _getUserCurrentLocation().then((value) async {
      //         _markers.add(
      //             Marker(
      //                 markerId: const MarkerId('SomeId'),
      //                 position: LatLng(value.latitude ,value.longitude),
      //                 infoWindow:  InfoWindow(
      //                     title: address
      //                 )
      //             )
      //         );
      //         final GoogleMapController controller = await _controller.future;
      //
      //         CameraPosition kGooglePlex =  CameraPosition(
      //           target: LatLng(value.latitude ,value.longitude),
      //           zoom: 14,
      //         );
      //         controller.animateCamera(CameraUpdate.newCameraPosition(kGooglePlex));
      //
      //         // List<Placemark> placemarks = await placemarkFromCoordinates(value.latitude ,value.longitude);
      //         //
      //         //
      //         // final add = placemarks.first;
      //         // address = add.locality.toString() +" "+add.administrativeArea.toString()+" "+add.subAdministrativeArea.toString()+" "+add.country.toString();
      //
      //         setState(() {
      //
      //         });
      //       });
      //     },
      //     child: Container(
      //       width: 48,
      //       height: 48,
      //       decoration: const BoxDecoration(
      //         shape: BoxShape.circle,
      //         gradient: LinearGradient(
      //           colors: [
      //             Color(0xffFF0092),
      //             Color(0xff216DFD),
      //           ],
      //         ),
      //       ),
      //       child: const Icon(
      //         Icons.add,
      //         color: Colors.white,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class PlacesApi extends GetxController{
  final TextEditingController eventLocationController = TextEditingController();
  late GoogleMapController mapController;
  final LatLng target = const LatLng(30.3753, 69.3451);
  final double defaultZoom = 4.0;
  // Zoom level when a location is searched
  final double searchZoom = 15.0;// Example location
  final key = 'AIzaSyDotkOgJK6nWqbYMLFOuQQs8VNpyIOAmGw'; // Replace with your Google API Key

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


// Other code...

  void searchPlaces(String query) async {
    final String encodedQuery = Uri.encodeComponent(query);
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$encodedQuery&inputtype=textquery&fields=geometry&key=$key';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['candidates'] != null && result['candidates'].length > 0) {
          final location = result['candidates'][0]['geometry']['location'];
          mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(location['lat'], location['lng']), zoom: searchZoom),
          ));
        }
      } else {
        if (kDebugMode) {
          print('Failed to load locations: ${response.body}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred while fetching places: $e');
      }
    }
  }

  Future<List<String>> getSuggestions(String query) async {
    final String encodedQuery = Uri.encodeComponent(query);
    final String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$encodedQuery&key=$key';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['predictions'] != null) {
          return List<String>.from(
              result['predictions'].map((prediction) => prediction['description'])
          );
        }
        return [];
      } else {
        if (kDebugMode) {
          print('Failed to load suggestions: ${response.body}');
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred while fetching suggestions: $e');
      }
      return [];
    }
  }

  // GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(0.0, 0.0);
  final double _zoomLevel = 17.0; // Higher value for closer zoom
  String address = "";



  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When permissions are granted, get the current position.
    Position position = await Geolocator.getCurrentPosition();
    _currentPosition = LatLng(position.latitude, position.longitude);
    _getAddressFromLatLng(position);

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _currentPosition,
          zoom: _zoomLevel, // Set the zoom level here
        ),
      ),
    );
  }
  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

        address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
