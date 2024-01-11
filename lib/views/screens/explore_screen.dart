import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../mrg/screens/Favourites/newFav.dart';
import 'notification_screen.dart';
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
    _fetchAndMarkLocations();
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
      Rect.fromLTWH(0, 0, 100.0, 150.0),
      Radius.circular(20.0),
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

    for (var doc in querySnapshot.docs) {
      String address = doc['location'];
      String imageURL = doc['thumbnailUrl']; // Assuming 'thumbnailUrl' is a field in your document
      List<Location> locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        Location location = locations.first;
        BitmapDescriptor customIcon = await getBitmapDescriptorFromUrl(imageURL);

        _markers.add(
          Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(location.latitude, location.longitude),
            icon: customIcon,
          ),
        );
      }
    }

    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final placeApiController = Get.put(PlacesApi());
    // Implement your home screen UI here
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 80,
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
          GestureDetector(
              onTap: () {
                Get.to(() => FavList());
              },
              child: SvgPicture.asset('assets/appbar/heart.svg')),
          const SizedBox(width: 10),
          GestureDetector(
              onTap: () {
                Get.to(() => const NotificationScreen());
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
        print('Failed to load locations: ${response.body}');
      }
    } catch (e) {
      print('Error occurred while fetching places: $e');
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
        print('Failed to load suggestions: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Error occurred while fetching suggestions: $e');
      return [];
    }
  }
}
