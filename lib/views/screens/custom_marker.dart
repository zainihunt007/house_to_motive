// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:house_to_motive/views/screens/video_screen.dart';
// import 'package:http/http.dart' as http;
//
// //
// // class MapSample extends StatefulWidget {
// //   @override
// //   State<MapSample> createState() => MapSampleState();
// // }
// //
// // class MapSampleState extends State<MapSample> {
// //   GoogleMapController? _controller;
// //   final Set<Marker> _markers = {};
// //   final LatLng _center = const LatLng(45.521563, -122.677433);
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchLocationsAndAddMarkers();
// //   }
// //
// //   Future<BitmapDescriptor> _getMarkerBitmap(String url, {int imageWidth = 100, int imageHeight = 150, int borderWidth = 0, double borderRadius = 10.0}) async {
// //     try {
// //       final Uint8List markerImageBytes = await _getBytesFromNetwork(url);
// //       ui.Image image = await _loadImage(markerImageBytes);
// //
// //       final int totalWidth = imageWidth + borderWidth * 2;
// //       final int totalHeight = imageHeight + borderWidth * 2;
// //
// //       final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
// //       final Canvas canvas = Canvas(pictureRecorder);
// //
// //       final Rect imageRect = Rect.fromLTWH(borderWidth.toDouble(), borderWidth.toDouble(), imageWidth.toDouble(), imageHeight.toDouble());
// //       final RRect roundedImageRect = RRect.fromRectXY(imageRect, borderRadius, borderRadius);
// //       final Path clipPath = Path()..addRRect(roundedImageRect);
// //       canvas.clipPath(clipPath);
// //
// //       paintImage(canvas: canvas, image: image, rect: imageRect, fit: BoxFit.cover);
// //
// //       final Paint paint = Paint()
// //         ..color = Colors.white
// //         ..style = PaintingStyle.stroke
// //         ..strokeWidth = borderWidth.toDouble();
// //       canvas.drawRRect(roundedImageRect, paint);
// //
// //       final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(totalWidth, totalHeight);
// //       final ByteData? byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
// //       final Uint8List byteDataAsUint8List = byteData!.buffer.asUint8List();
// //
// //       return BitmapDescriptor.fromBytes(byteDataAsUint8List);
// //     } catch (e) {
// //       print('Error getting marker bitmap: $e');
// //       return BitmapDescriptor.defaultMarker;
// //     }
// //   }
// //
// //   Future<ui.Image> _loadImage(Uint8List imgBytes) async {
// //     final Completer<ui.Image> completer = Completer();
// //     ui.decodeImageFromList(imgBytes, (ui.Image img) {
// //       return completer.complete(img);
// //     });
// //     return completer.future;
// //   }
// //
// //   Future<Uint8List> _getBytesFromNetwork(String path) async {
// //     try {
// //       final response = await NetworkAssetBundle(Uri.parse(path)).load(path);
// //       return response.buffer.asUint8List();
// //     } catch (e) {
// //       print('Error getting bytes from network: $e');
// //       throw Exception('Failed to load network image.');
// //     }
// //   }
// //
// //   void _fetchLocationsAndAddMarkers() async {
// //     try {
// //       final querySnapshot = await FirebaseFirestore.instance.collection('videos').get();
// //       print('Documents found: ${querySnapshot.docs.length}');
// //
// //       await Future.forEach(querySnapshot.docs, (doc) async {
// //         try {
// //           var location = _getLatLng(doc['location']);
// //           var thumbnailUrl = doc['thumbnailUrl'];
// //
// //           print('Adding marker for document: ${doc.id}, Location: $location, Thumbnail URL: $thumbnailUrl');
// //
// //           final customMarker = await _getMarkerBitmap(thumbnailUrl);
// //
// //           setState(() {
// //             _markers.add(
// //               Marker(
// //                 markerId: MarkerId(doc.id),
// //                 position: location,
// //                 icon: customMarker,
// //               ),
// //             );
// //           });
// //         } catch (e) {
// //           print('Error processing document ${doc.id}: $e');
// //         }
// //       });
// //     } catch (e) {
// //       print('Error fetching locations from Firestore: $e');
// //     }
// //   }
// //
// //
// //
// //
// //   LatLng _getLatLng(dynamic location) {
// //     if (location is GeoPoint) {
// //       return LatLng(location.latitude, location.longitude);
// //     } else {
// //       print('Invalid location format');
// //       return _center; // Default location
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: GoogleMap(
// //         onMapCreated: (GoogleMapController controller) {
// //           _controller = controller;
// //         },
// //         initialCameraPosition: CameraPosition(
// //           target: _center,
// //           zoom: 11.0,
// //         ),
// //         markers: _markers,
// //       ),
// //     );
// //   }
// // }
//
// import 'package:geocoding/geocoding.dart';
//
//
// class MapSample extends StatefulWidget {
//   @override
//   _MapSampleState createState() => _MapSampleState();
// }
//
// class _MapSampleState extends State<MapSample> {
//   // List<VideoLocation> _videoLocations = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchAndMarkLocations();
//     _determinePosition();
//   }
//
//   Future<BitmapDescriptor> getBitmapDescriptorFromUrl(String url) async {
//     final http.Response response = await http.get(Uri.parse(url));
//     final Uint8List bytes = response.bodyBytes;
//
//     // Decode the image to a codec
//     final ui.Codec codec = await ui.instantiateImageCodec(bytes, targetWidth: 100, targetHeight: 150);
//     final ui.FrameInfo fi = await codec.getNextFrame();
//
//     // Get the image from the frame info
//     ui.Image image = fi.image;
//
//     // Create a new picture recorder and canvas
//     final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//     final Canvas canvas = Canvas(pictureRecorder);
//     final Paint paint = Paint()..isAntiAlias = true;
//
//     // Define the rounded rectangle
//     final RRect clipRect = RRect.fromRectAndRadius(
//       Rect.fromLTWH(0, 0, 100.0, 150.0),
//       Radius.circular(20.0),
//     );
//
//     // Clip the canvas
//     canvas.clipRRect(clipRect);
//
//     // Draw the image onto the canvas
//     canvas.drawImage(image, Offset.zero, paint);
//
//     // If you want a border around the rounded image, uncomment the following lines
//     /*
//   final Paint borderPaint = Paint()
//     ..color = Colors.white
//     ..style = PaintingStyle.stroke
//     ..strokeWidth = 10.0; // Adjust border width as needed
//
//   canvas.drawRRect(clipRect, borderPaint);
//   */
//
//     // End drawing and get the final image
//     final ui.Image finalImage = await pictureRecorder.endRecording().toImage(100, 150);
//     final ByteData? byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
//     final Uint8List finalBytes = byteData!.buffer.asUint8List();
//
//     return BitmapDescriptor.fromBytes(finalBytes);
//   }
//
//
//   Set<Marker> _markers = {};
//
//   // Future<void> _fetchAndMarkLocations() async {
//   //   var videoCollection = FirebaseFirestore.instance.collection('videos');
//   //   var querySnapshot = await videoCollection.get();
//   //
//   //   for (var doc in querySnapshot.docs) {
//   //     String address = doc['location'];
//   //     String imageURL = doc['thumbnailUrl']; // Assuming 'thumbnailUrl' is a field in your document
//   //     List<Location> locations = await locationFromAddress(address);
//   //
//   //     if (locations.isNotEmpty) {
//   //       Location location = locations.first;
//   //       BitmapDescriptor customIcon = await getBitmapDescriptorFromUrl(imageURL);
//   //
//   //       _markers.add(
//   //         Marker(
//   //           markerId: MarkerId(doc.id),
//   //           position: LatLng(location.latitude, location.longitude),
//   //           icon: customIcon,
//   //         ),
//   //       );
//   //     }
//   //   }
//   //
//   //   setState(() {});
//   // }
//
//   Future<void> _fetchAndMarkLocations() async {
//     var videoCollection = FirebaseFirestore.instance.collection('videos');
//     var querySnapshot = await videoCollection.get();
//
//     List<String> videoUrls = []; // List to store video URLs
//
//     for (var doc in querySnapshot.docs) {
//       String address = doc['location'];
//       String imageURL = doc['thumbnailUrl'];
//       String videoURL = doc['videoUrl'];
//       List<Location> locations = await locationFromAddress(address);
//
//       BitmapDescriptor customIcon = await getBitmapDescriptorFromUrl(imageURL);
//       Location location = locations.first;
//
//       _markers.add(
//         Marker(
//           markerId: MarkerId(doc.id),
//           position: LatLng(location.latitude, location.longitude),
//           icon: customIcon,
//           onTap: () {
//             // Open VideoScreen when marker is tapped
//             Get.to(() => VideoScreen(videoUrls: videoUrls, initialIndex: videoUrls.indexOf(videoURL)));
//           },
//         ),
//       );
//
//       // Add the video URL to the list
//       videoUrls.add(videoURL);
//     }
//
//     setState(() {});
//   }
//
//   GoogleMapController? _mapController;
//   LatLng _currentPosition = LatLng(0.0, 0.0);
//   final double _zoomLevel = 17.0; // Higher value for closer zoom
//   String _address = "";
//
//
//   // Future<void> _determinePosition() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;
//   //
//   //   // Check if location services are enabled.
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     return Future.error('Location services are disabled.');
//   //   }
//   //
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       return Future.error('Location permissions are denied');
//   //     }
//   //   }
//   //
//   //   if (permission == LocationPermission.deniedForever) {
//   //     return Future.error(
//   //         'Location permissions are permanently denied, we cannot request permissions.');
//   //   }
//   //
//   //   // When permissions are granted, get the current position.
//   //   Position position = await Geolocator.getCurrentPosition();
//   //   _currentPosition = LatLng(position.latitude, position.longitude);
//   //   _getAddressFromLatLng(position);
//   //
//   //   _mapController?.animateCamera(
//   //     CameraUpdate.newCameraPosition(
//   //       CameraPosition(
//   //         target: _currentPosition,
//   //         zoom: _zoomLevel, // Set the zoom level here
//   //       ),
//   //     ),
//   //   );
//   // }
//   Future<void> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // If location services are not enabled, show a dialog to enable them.
//       bool enableLocationServices = await Geolocator.openLocationSettings();
//       if (!enableLocationServices) {
//         throw Exception('Location services are disabled.');
//       }
//     }
//
//     // Check location permission.
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permissions are denied.');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       throw Exception('Location permissions are permanently denied.');
//     }
//
//     // When permissions are granted, get the current position.
//     Position position = await Geolocator.getCurrentPosition();
//     _currentPosition = LatLng(position.latitude, position.longitude);
//     await _getAddressFromLatLng(position);
//
//     _mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: _currentPosition,
//           zoom: _zoomLevel,
//         ),
//       ),
//     );
//   }
//   Future<void> _getAddressFromLatLng(Position position) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         position.latitude,
//         position.longitude,
//       );
//
//       Placemark place = placemarks[0];
//       setState(() {
//         _address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     print(_address.toString());
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_address),
//       ),
//       body: Stack(
//         children: [
//           GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: LatLng(30.3753, 69.3451),
//               zoom: 2,
//             ),
//             markers: _markers.toSet(),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:house_to_motive/views/screens/video_screen.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

import '../../mrg/ArcadeScreen.dart';

// class TicketsNearMe extends StatefulWidget {
//   @override
//   _TicketsNearMeState createState() => _TicketsNearMeState();
// }
//
// class _TicketsNearMeState extends State<TicketsNearMe> {
//   List<String> nearbyTicketsIds = []; // Store IDs of nearby tickets
//
//   @override
//   void initState() {
//     super.initState();
//     checkNearbyTickets();
//   }
//
//   Future<void> checkNearbyTickets() async {
//     Position currentPosition = await _determinePosition();
//
//     FirebaseFirestore.instance
//         .collection('tickets')
//         .get()
//         .then((querySnapshot) {
//       querySnapshot.docs.forEach((ticket) async {
//         String ticketLocationAddress = ticket.get('location');
//         List<Location> locations =
//             await locationFromAddress(ticketLocationAddress);
//
//         if (locations.isNotEmpty) {
//           // Assuming the first result is the most accurate
//           Location ticketLocation = locations.first;
//           double distance = Geolocator.distanceBetween(
//             currentPosition.latitude,
//             currentPosition.longitude,
//             ticketLocation.latitude,
//             ticketLocation.longitude,
//           );
//
//           // Check if the ticket is within 1km radius
//           if (distance <= 1000) {
//             setState(() {
//               nearbyTicketsIds.add(ticket.id); // Add ticket ID to the list
//             });
//           }
//         }
//       });
//     });
//   }
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       throw Exception(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Tickets Near Me'),
//       ),
//       body: Center(
//         child: nearbyTicketsIds.isEmpty
//             ? Text('No nearby tickets found.')
//             : ListView.builder(
//                 itemCount: nearbyTicketsIds.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text('Ticket ID: ${nearbyTicketsIds[index]}'),
//                     // You can expand this ListTile to show more information about each ticket
//                   );
//                 },
//               ),
//       ),
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:house_to_motive/mrg/ArcadeScreen.dart';
//
// import 'home_screens/home_model.dart';

// class CheckNearbyTickets extends StatefulWidget {
//   const CheckNearbyTickets({super.key});
//
//   @override
//   State<CheckNearbyTickets> createState() => _CheckNearbyTicketsState();
// }
//
// class _CheckNearbyTicketsState extends State<CheckNearbyTickets> {
//   List<TicketInfo> nearbyTickets = []; // Updated to store TicketInfo objects
//
//   @override
//   void initState() {
//     super.initState();
//     checkNearbyTickets();
//   }
//
//   bool isLoading = true; // Add a boolean variable to track loading state
//
//   Future<void> checkNearbyTickets() async {
//     setState(() {
//       isLoading =
//           true; // Set loading state to true when fetching tickets starts
//     });
//
//     Position currentPosition = await _determinePosition();
//
//     FirebaseFirestore.instance
//         .collection('tickets')
//         .where('private', isEqualTo: false)
//         .get()
//         .then((querySnapshot) {
//       querySnapshot.docs.forEach((ticket) async {
//         String ticketLocationAddress = ticket.get('location');
//         List<Location> locations =
//             await locationFromAddress(ticketLocationAddress);
//
//         if (locations.isNotEmpty) {
//           Location ticketLocation = locations.first;
//           double distance = Geolocator.distanceBetween(
//             currentPosition.latitude,
//             currentPosition.longitude,
//             ticketLocation.latitude,
//             ticketLocation.longitude,
//           );
//
//           if (distance <= 1000) {
//             setState(() {
//               nearbyTickets.add(TicketInfo(
//                 id: ticket.id,
//                 eventName: ticket.get('eventName'),
//                 photoURL: ticket.get('photoURL'),
//                 location: ticket.get('location'),
//                 date: ticket.get('date'),
//                 familyPrice: ticket.get('familyPrice'),
//                 startTime: ticket.get('startTime'),
//                 endTime: ticket.get('endTime'),
//                 childPrice: ticket.get('childPrice'),
//                 adultPrice: ticket.get('adultPrice'),
//                 description: ticket.get('description'),
//               ));
//             });
//           }
//         }
//       });
//
//       setState(() {
//         isLoading =
//             false; // Set loading state to false when fetching tickets is completed
//       });
//     });
//   }
//
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       throw Exception('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         throw Exception('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       throw Exception(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tickets Near Me'),
//       ),
//       body: isLoading
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : nearbyTickets.isEmpty
//               ? const Center(child: Text('No nearby tickets found.'))
//               : ListView.builder(
//                   itemCount: nearbyTickets.length,
//                   itemBuilder: (context, index) {
//                     TicketInfo ticket = nearbyTickets[index];
//                     return GestureDetector(
//                       onTap: () {
//                         Get.to(
//                           () => ArcadeScreen(
//                             photoURL: ticket.photoURL,
//                             eventName: ticket.eventName,
//                             location: ticket.location,
//                             adultPrice: ticket.adultPrice,
//                             childPrice: ticket.childPrice,
//                             date: ticket.date,
//                             endTime: ticket.endTime,
//                             familyPrice: ticket.familyPrice,
//                             description: ticket.description,
//                             startTime: 'START TIME',
//                           ),
//                         );
//
//                         // Get.to(
//                         //   () => DataTransfer(
//                         //     name: ticket.eventName,
//                         //     photoUrl: ticket.photoURL,
//                         //     location: ticket.location,
//                         //     date: ticket.date,
//                         //   ),
//                         // );
//                       },
//                       child: Stack(
//                         children: [
//                           Stack(
//                             children: [
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 12),
//                                 child: Container(
//                                   height: screenHeight * 0.32,
//                                   width: screenWidth / 1,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     color: Colors.white,
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(6.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               ticket.eventName.length > 35
//                                                   ? ticket.eventName
//                                                           .substring(0, 35) +
//                                                       '..'
//                                                   : ticket.eventName,
//                                               style: GoogleFonts.inter(
//                                                 fontWeight: FontWeight.w700,
//                                                 color: Colors.black,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                             SizedBox(height: 0.3.h),
//                                             // Row(
//                                             //   children: [
//                                             //     GradientText(
//                                             //       text: "+200 Going",
//                                             //       gradient:
//                                             //           const LinearGradient(
//                                             //         colors: [
//                                             //           Color(0xffFF0092),
//                                             //           Color(0xff216DFD),
//                                             //         ],
//                                             //       ),
//                                             //       style: GoogleFonts.inter(
//                                             //         fontWeight:
//                                             //             FontWeight.w400,
//                                             //         fontSize: 10,
//                                             //       ),
//                                             //     ),
//                                             //   ],
//                                             // ),
//                                             SizedBox(height: 0.3.h),
//                                             Row(
//                                               children: [
//                                                 SvgPicture.asset(
//                                                     'assets/svgs/home/map-pin.svg'),
//                                                 const SizedBox(width: 3),
//                                                 Text(
//                                                   ticket.eventName.length > 30
//                                                       ? ticket.eventName
//                                                               .substring(
//                                                                   0, 30) +
//                                                           '..'
//                                                       : ticket.eventName,
//                                                   style: GoogleFonts.inter(
//                                                     fontWeight: FontWeight.w400,
//                                                     color:
//                                                         const Color(0xff7390A1),
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         // Column(
//                                         //   mainAxisAlignment:
//                                         //       MainAxisAlignment.spaceBetween,
//                                         //   crossAxisAlignment:
//                                         //       CrossAxisAlignment.start,
//                                         //   children: [
//                                         //     Container(),
//                                         //     const Spacer(),
//                                         //     // Row(
//                                         //     //   children: [
//                                         //     //     Image.asset(
//                                         //     //         'assets/pngs/Vector.png'),
//                                         //     //     const SizedBox(width: 3),
//                                         //     //     Text(
//                                         //     //       'Trending',
//                                         //     //       style: GoogleFonts.inter(
//                                         //     //         fontSize: 10,
//                                         //     //         color: const Color(
//                                         //     //             0xff025B8F),
//                                         //     //         fontWeight:
//                                         //     //             FontWeight.w400,
//                                         //     //       ),
//                                         //     //     ),
//                                         //     //     const SizedBox(width: 10),
//                                         //     //     Image.asset(
//                                         //     //         'assets/pngs/material-symbols_upcoming-outline.png'),
//                                         //     //     const SizedBox(width: 3),
//                                         //     //     Text(
//                                         //     //       'Trending',
//                                         //     //       style: GoogleFonts.inter(
//                                         //     //         fontSize: 10,
//                                         //     //         color: const Color(
//                                         //     //             0xff025B8F),
//                                         //     //         fontWeight:
//                                         //     //             FontWeight.w400,
//                                         //     //       ),
//                                         //     //     ),
//                                         //     //   ],
//                                         //     // ),
//                                         //     // SizedBox(height: 1.h),
//                                         //     // Row(
//                                         //     //   children: [
//                                         //     //     Image.asset(
//                                         //     //         'assets/pngs/majesticons_music.png'),
//                                         //     //     const SizedBox(width: 3),
//                                         //     //     Text(
//                                         //     //       'Hip-hop',
//                                         //     //       style: GoogleFonts.inter(
//                                         //     //         fontSize: 10,
//                                         //     //         color: const Color(
//                                         //     //             0xff025B8F),
//                                         //     //         fontWeight:
//                                         //     //             FontWeight.w400,
//                                         //     //       ),
//                                         //     //     ),
//                                         //     //     const SizedBox(width: 10),
//                                         //     //     Image.asset(
//                                         //     //         'assets/pngs/majesticons_music-line.png'),
//                                         //     //     const SizedBox(width: 3),
//                                         //     //     Text(
//                                         //     //       'Hot',
//                                         //     //       style: GoogleFonts.inter(
//                                         //     //         fontSize: 10,
//                                         //     //         color: const Color(
//                                         //     //             0xff025B8F),
//                                         //     //         fontWeight:
//                                         //     //             FontWeight.w400,
//                                         //     //       ),
//                                         //     //     ),
//                                         //     //   ],
//                                         //     // ),
//                                         //     // SizedBox(height: 1.h),
//                                         //   ],
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 height: screenHeight * 0.27,
//                                 width: Get.width / 1,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   image: DecorationImage(
//                                     fit: BoxFit.fill,
//                                     image: NetworkImage(
//                                       ticket.photoURL,
//                                     ),
//                                   ),
//                                 ),
//                                 child: const Padding(
//                                   padding: EdgeInsets.all(12),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       // GestureDetector(
//                                       //   onTap: () async {
//                                       //     isFavorite.toggle();
//                                       //     log(doc.id.toString());
//                                       //     await FirebaseFirestore.instance
//                                       //         .collection('users')
//                                       //         .doc(userId)
//                                       //         .collection('favorites')
//                                       //         .doc(doc.id)
//                                       //         .set({
//                                       //       'isFavorite': isFavorite.value
//                                       //     });
//                                       //   },
//                                       //   child: CircleAvatar(
//                                       //     backgroundColor:
//                                       //     const Color(0xff80FFFFFF),
//                                       //     radius: 16,
//                                       //     child: Icon(
//                                       //       size: 2.5.h,
//                                       //       isFavorite.value
//                                       //           ? Icons.favorite
//                                       //           : Icons.favorite_border,
//                                       //       color: Colors
//                                       //           .red, // Customize the color as needed
//                                       //     ),
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class LikedVideosScreen extends StatelessWidget {
//   final String userId;
//
//   LikedVideosScreen({required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Liked Videos'),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           var likedVideos = snapshot.data!.get('likedVideos') as List<dynamic>;
//
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 2,
//               mainAxisSpacing: 2,
//               childAspectRatio: 0.8,
//             ),
//             itemCount: likedVideos.length,
//             itemBuilder: (context, index) {
//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance.collection('videos').doc(likedVideos[index]).get(),
//                 builder: (context, videoSnapshot) {
//                   if (videoSnapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//
//                   if (!videoSnapshot.hasData || videoSnapshot.data!.data() == null) {
//                     return const SizedBox(); // Return an empty container if the data is null or doesn't exist
//                   }
//
//                   var videoData = videoSnapshot.data!.data() as Map<String, dynamic>;
//
//                   return GestureDetector(
//                     onTap: () async {
//                       List<String> videoUrls = [];
//                       for (var likedVideo in likedVideos) {
//                         var videoSnapshot = await FirebaseFirestore.instance.collection('videos').doc(likedVideo).get();
//                         if (videoSnapshot.exists) {
//                           var videoData = videoSnapshot.data() as Map<String, dynamic>;
//                           videoUrls.add(videoData['videoUrl']);
//                         }
//                       }
//
//                       // Pass all video URLs to the VideoScreen
//                       Get.to(() => VideoScreen(videoUrls: videoUrls, initialIndex: index),);
//                     },
//                     child: Stack(
//                       children: [
//                         Container(
//                           height: 200,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             image: DecorationImage(
//                               image: NetworkImage(videoData['thumbnailUrl']),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         Center(
//                           child: Image.asset(
//                             'assets/assets2/Video_images/platbtn.png',
//                             height: 2.5.h,
//                             width: 2.5.h,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



// Card(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
// Expanded(
// child: Image.network(
// videoData['thumbnailUrl'] ?? '', // Handle null values
// fit: BoxFit.cover,
// ),
// ),
// Padding(
// padding: EdgeInsets.all(8.0),
// child: Text(
// videoData['title'] ?? 'Title not available', // Handle null values
// style: TextStyle(fontWeight: FontWeight.bold),
// ),
// ),
// ],
// ),
// ),

// class LikedVideosScreen extends StatelessWidget {
//   final String userId;
//
//   LikedVideosScreen({required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Liked Videos'),
//       ),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance.collection('users').doc(userId).snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           var likedVideos = snapshot.data!.get('likedVideos') as List<dynamic>;
//
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               crossAxisSpacing: 2,
//               mainAxisSpacing: 2,
//               childAspectRatio: 0.8,
//             ),
//             itemCount: likedVideos.length,
//             itemBuilder: (context, index) {
//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance.collection('videos').doc(likedVideos[index]).get(),
//                 builder: (context, videoSnapshot) {
//                   if (videoSnapshot.connectionState == ConnectionState.waiting) {
//                     return CircularProgressIndicator();
//                   }
//
//                   if (!videoSnapshot.hasData || videoSnapshot.data!.data() == null) {
//                     return SizedBox(); // Return an empty container if the data is null or doesn't exist
//                   }
//
//                   var videoData = videoSnapshot.data!.data() as Map<String, dynamic>;
//
//                   return buildVideoGestureDetector(videoData, likedVideos, index);
//                 },
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
// GestureDetector buildVideoGestureDetector(
//     Map<String, dynamic> videoData,
//     List<dynamic> likedVideos,
//     int index,
//     ) {
//   return GestureDetector(
//     onTap: () async {
//       List<Future<String>> videoUrlFutures = [];
//       for (var videoId in likedVideos) {
//         videoUrlFutures.add(FirebaseFirestore.instance
//             .collection('videos')
//             .doc(videoId)
//             .get()
//             .then((videoSnapshot) =>
//         videoSnapshot.data()!['videoUrl'] as String));
//       }
//
//       List<String> videoUrls = await Future.wait(videoUrlFutures);
//
//       Get.to(() => VideoScreen(
//         videoUrls: videoUrls,
//         initialIndex: index,
//       ));
//     },
//     child: Stack(
//       children: [
//         Container(
//           height: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             image: DecorationImage(
//               image: NetworkImage(videoData['thumbnailUrl']),
//               fit: BoxFit.fill,
//             ),
//           ),
//         ),
//         Center(
//           child: Image.asset(
//             'assets/assets2/Video_images/platbtn.png',
//             height: 2.5.h,
//             width: 2.5.h,
//           ),
//         ),
//       ],
//     ),
//   );
// }

class TicketInfo {
  String id;
  String eventName;
  String photoURL;
  String location;
  Timestamp date; // Explicitly using Timestamp
  String adultPrice;
  String childPrice;
  String familyPrice;
  String startTime;
  String endTime;
  String description;

  TicketInfo({
    required this.id,
    required this.eventName,
    required this.photoURL,
    required this.location,
    required this.date, // Making it required and explicitly of type Timestamp
    required this.adultPrice,
    required this.familyPrice,
    required this.childPrice,
    required this.endTime,
    required this.startTime,
    required this.description,
  });
}





