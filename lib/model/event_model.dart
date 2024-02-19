
import 'package:flutter/material.dart';

class Ticket {
  final String? id;
  final bool? isPaid;
  final bool? private;
  final bool? commentDisable;
  final DateTime? date;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String? location;
  final String? eventName;
  final String? description;
  String? photoURL;// Nullable URL to uploaded photo/ URL to uploaded photo, you may handle photo upload separately
  final bool? isEventFavourite;
  final String? childPrice;
  final String? adultPrice;
  final String? familyPrice;
  final String? userProfilePic;
  final String? userName;
  Ticket({
     this.id,
     this.isPaid,
     this.date,
     this.startTime,
     this.endTime,
     this.location,
     this.eventName,
     this.description,
     this.photoURL,
     this.private,
     this.commentDisable,
    this.isEventFavourite,
    this.adultPrice,
    this.childPrice,
    this.familyPrice,
    this.userProfilePic,
    this.userName,
  });

  // Convert Ticket to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isPaid': isPaid,
      'date': date,
      'startTime': '${startTime?.hour}:${startTime?.minute}',
      'endTime': '${endTime?.hour}:${endTime?.minute}',
      'location': location,
      'eventName': eventName,
      'description': description,
      'photoURL': photoURL ?? '',
      'private' : private,
      'commentDisable' : commentDisable,
      'isEventFavourite' : isEventFavourite,
      'childPrice' : childPrice,
      'adultPrice' : adultPrice,
      'familyPrice' : familyPrice,
      'userName' : userName,
      'userProfilePic' : userProfilePic,
    };
  }
}


