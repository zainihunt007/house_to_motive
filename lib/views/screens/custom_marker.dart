import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house_to_motive/views/screens/video_screen.dart';
import 'package:http/http.dart' as http;

//
// class MapSample extends StatefulWidget {
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//   GoogleMapController? _controller;
//   final Set<Marker> _markers = {};
//   final LatLng _center = const LatLng(45.521563, -122.677433);
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchLocationsAndAddMarkers();
//   }
//
//   Future<BitmapDescriptor> _getMarkerBitmap(String url, {int imageWidth = 100, int imageHeight = 150, int borderWidth = 0, double borderRadius = 10.0}) async {
//     try {
//       final Uint8List markerImageBytes = await _getBytesFromNetwork(url);
//       ui.Image image = await _loadImage(markerImageBytes);
//
//       final int totalWidth = imageWidth + borderWidth * 2;
//       final int totalHeight = imageHeight + borderWidth * 2;
//
//       final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
//       final Canvas canvas = Canvas(pictureRecorder);
//
//       final Rect imageRect = Rect.fromLTWH(borderWidth.toDouble(), borderWidth.toDouble(), imageWidth.toDouble(), imageHeight.toDouble());
//       final RRect roundedImageRect = RRect.fromRectXY(imageRect, borderRadius, borderRadius);
//       final Path clipPath = Path()..addRRect(roundedImageRect);
//       canvas.clipPath(clipPath);
//
//       paintImage(canvas: canvas, image: image, rect: imageRect, fit: BoxFit.cover);
//
//       final Paint paint = Paint()
//         ..color = Colors.white
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = borderWidth.toDouble();
//       canvas.drawRRect(roundedImageRect, paint);
//
//       final ui.Image markerAsImage = await pictureRecorder.endRecording().toImage(totalWidth, totalHeight);
//       final ByteData? byteData = await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
//       final Uint8List byteDataAsUint8List = byteData!.buffer.asUint8List();
//
//       return BitmapDescriptor.fromBytes(byteDataAsUint8List);
//     } catch (e) {
//       print('Error getting marker bitmap: $e');
//       return BitmapDescriptor.defaultMarker;
//     }
//   }
//
//   Future<ui.Image> _loadImage(Uint8List imgBytes) async {
//     final Completer<ui.Image> completer = Completer();
//     ui.decodeImageFromList(imgBytes, (ui.Image img) {
//       return completer.complete(img);
//     });
//     return completer.future;
//   }
//
//   Future<Uint8List> _getBytesFromNetwork(String path) async {
//     try {
//       final response = await NetworkAssetBundle(Uri.parse(path)).load(path);
//       return response.buffer.asUint8List();
//     } catch (e) {
//       print('Error getting bytes from network: $e');
//       throw Exception('Failed to load network image.');
//     }
//   }
//
//   void _fetchLocationsAndAddMarkers() async {
//     try {
//       final querySnapshot = await FirebaseFirestore.instance.collection('videos').get();
//       print('Documents found: ${querySnapshot.docs.length}');
//
//       await Future.forEach(querySnapshot.docs, (doc) async {
//         try {
//           var location = _getLatLng(doc['location']);
//           var thumbnailUrl = doc['thumbnailUrl'];
//
//           print('Adding marker for document: ${doc.id}, Location: $location, Thumbnail URL: $thumbnailUrl');
//
//           final customMarker = await _getMarkerBitmap(thumbnailUrl);
//
//           setState(() {
//             _markers.add(
//               Marker(
//                 markerId: MarkerId(doc.id),
//                 position: location,
//                 icon: customMarker,
//               ),
//             );
//           });
//         } catch (e) {
//           print('Error processing document ${doc.id}: $e');
//         }
//       });
//     } catch (e) {
//       print('Error fetching locations from Firestore: $e');
//     }
//   }
//
//
//
//
//   LatLng _getLatLng(dynamic location) {
//     if (location is GeoPoint) {
//       return LatLng(location.latitude, location.longitude);
//     } else {
//       print('Invalid location format');
//       return _center; // Default location
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         onMapCreated: (GoogleMapController controller) {
//           _controller = controller;
//         },
//         initialCameraPosition: CameraPosition(
//           target: _center,
//           zoom: 11.0,
//         ),
//         markers: _markers,
//       ),
//     );
//   }
// }

import 'package:geocoding/geocoding.dart';


class MapSample extends StatefulWidget {
  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  // List<VideoLocation> _videoLocations = [];

  @override
  void initState() {
    super.initState();
    _fetchAndMarkLocations();
    _determinePosition();
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

  // Future<void> _fetchAndMarkLocations() async {
  //   var videoCollection = FirebaseFirestore.instance.collection('videos');
  //   var querySnapshot = await videoCollection.get();
  //
  //   for (var doc in querySnapshot.docs) {
  //     String address = doc['location'];
  //     String imageURL = doc['thumbnailUrl']; // Assuming 'thumbnailUrl' is a field in your document
  //     List<Location> locations = await locationFromAddress(address);
  //
  //     if (locations.isNotEmpty) {
  //       Location location = locations.first;
  //       BitmapDescriptor customIcon = await getBitmapDescriptorFromUrl(imageURL);
  //
  //       _markers.add(
  //         Marker(
  //           markerId: MarkerId(doc.id),
  //           position: LatLng(location.latitude, location.longitude),
  //           icon: customIcon,
  //         ),
  //       );
  //     }
  //   }
  //
  //   setState(() {});
  // }

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

  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(0.0, 0.0);
  final double _zoomLevel = 17.0; // Higher value for closer zoom
  String _address = "";


  Future<void> _determinePosition() async {
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

    _mapController?.animateCamera(
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
      setState(() {
        _address = "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }




  @override
  Widget build(BuildContext context) {
    print(_address.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(_address),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(30.3753, 69.3451),
              zoom: 2,
            ),
            markers: _markers.toSet(),
          ),
        ],
      ),
    );
  }
}
