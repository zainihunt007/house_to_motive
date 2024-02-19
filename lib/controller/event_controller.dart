import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/event_model.dart';

RxBool isSelected = false.obs;
// RxBool isCommentDisable = false.obs;
// RxBool isPrivate = false.obs;

class TicketController extends GetxController {
  final CollectionReference ticketsCollection =
      FirebaseFirestore.instance.collection('tickets');
  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController childPriceController = TextEditingController();
  final TextEditingController adultPriceController = TextEditingController();
  final TextEditingController familyPriceController = TextEditingController();



  // Future<String?> uploadImage(File imageFile) async {
  //   try {
  //     Reference storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('ticket_images')
  //         .child(DateTime.now().toString());
  //     UploadTask uploadTask = storageRef.putFile(imageFile);
  //     TaskSnapshot snapshot = await uploadTask;
  //     String downloadURL = await snapshot.ref.getDownloadURL();
  //     return downloadURL;
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //     return null;
  //   }
  // }

  Rx<TimeOfDay> selectedTime = TimeOfDay.now().obs;
  Rx<TimeOfDay> selectedTimeEnd = TimeOfDay.now().obs;

  RxBool isPrivate = false.obs;
  RxBool isCommentDisable = false.obs;
  RxBool isEventFavourite = false.obs;


  Rx<DateTime> selectedDay = DateTime.now().obs;

  void onDaySelected(DateTime day, DateTime focusedDay) {
    selectedDay(day);
  }

  Rx<DateTime> getSelectedDay() => selectedDay;



  void togglePrivate(bool value) {
    isPrivate.value = value;
  }

  void toggleCommentDisable(bool value) {
    isCommentDisable.value = value;
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay initialTime = selectedTime.value;
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null && picked != initialTime) {
      selectedTime.value = picked;
    }
  }

  Future<void> selectTimeEnd(BuildContext context) async {
    TimeOfDay initialTime = selectedTimeEnd.value;
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null && picked != initialTime) {
      selectedTimeEnd.value = picked;
    }
  }

  var selectedImage = Rx<File?>(null);

  // picking profile image
  pickedImage() async {
    final picker = ImagePicker();
    try {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        log(selectedImage.value.toString());
      } else {
        Get.snackbar(
          "No Image",
          "Please Select Image",
        );
      }
    } catch (e) {
      Get.snackbar(
        "An Error",
        " ${e.toString()}",
      );
    }
  }

  Future<Map<String, dynamic>?> getCurrentUserDetails() async {
    // Assuming you have a way to get the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userSnapshot.exists) {
      return userSnapshot.data() as Map<String, dynamic>?;
    }
    return null;
  }

  Future uploadImageToFirebase(
      {isPaid,
        date,
        startTime,
        endTime,
        location,
        eventName,
        description,
        private,
        commentDisable,
        isEventFavourite,
        childPriceController,
        adultPriceController,
        familyPriceController
      }) async {
    if (selectedImage.value == null) return;

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference storageReference = storage
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}.png');

    UploadTask uploadTask = storageReference.putFile(selectedImage.value!);
    await uploadTask.whenComplete(() => print('Image uploaded to Firebase'));

    String? imageUrl = await storageReference.getDownloadURL();
    print('Download URL: $imageUrl');

    if (imageUrl.isNotEmpty) {
      Map<String, dynamic>? userDetails = await getCurrentUserDetails();
      addTicket(
        isPaid: isPaid,
        date: date,
        startTime: startTime,
        endTime: endTime,
        locationController: locationController.text,
        childPriceController: childPriceController.text,
        eventName: eventName,
        description: description,
        photoURL: imageUrl,
        private: private,
        commentDisable: commentDisable,
        isEventFavourite: isEventFavourite,
        familyPriceController: familyPriceController.text,
        adultPriceController: adultPriceController.text,
        userName: userDetails?['User Name'],
        userProfilePic: userDetails?['profilePic'],
      );
    }
  }

  void addTicket({
    required bool isPaid,
    required Rx<DateTime> date,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required String locationController,
    required String eventName,
    required String description,
    required String photoURL,
    required bool private,
    required bool commentDisable,
    required isEventFavourite,
    required String childPriceController,
    required String adultPriceController,
    required String familyPriceController,
    required String userName,
    required String userProfilePic,
  }) {
    String id = ticketsCollection.doc().id;
    bool isPaid = isSelected.value;

    Ticket newTicket = Ticket(
      id: id,
      isPaid: isPaid,
      date: date.value,
      startTime: startTime,
      endTime: endTime,
      location: locationController,
      eventName: eventName,
      description: description,
      photoURL: photoURL,
      private: private,
      commentDisable: commentDisable,
      isEventFavourite: isEventFavourite == false.obs,
      adultPrice: adultPriceController,
      childPrice: childPriceController,
      familyPrice: familyPriceController,
      userName: userName,
      userProfilePic: userProfilePic,
    );

    ticketsCollection
        .doc(id)
        .set(newTicket.toMap())
        .then(
          (value) => print('Ticket added to Firestore'),
    )
        .catchError((error) => print('Failed to add ticket: $error'));
  }




}

