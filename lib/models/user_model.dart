import 'dart:convert';

import '../providers/location_provider.dart';

class UserModel {
  final String? fullName;
  String? userId;
  final String? email;
  final String? password;
  final String? phone;
  final bool? isProvider;
  final bool? isDriver;
  final bool? isAdmin;
  String? profilePic;
  String? transitId;
  final String? plateNumber;
  List<UserLocation>? locations;

  UserModel(
      {this.fullName,
      this.email,
      this.password,
      this.phone,
      this.isProvider,
      this.isDriver = false,
      this.isAdmin = false,
      this.transitId,
      this.locations,
      this.plateNumber,
      this.profilePic,
      this.userId});

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'phone': phone,
      'isProvider': false,
      'isDriver': isDriver,
      'userId': userId,
      'profilePic': 'https://unsplash.com/photos/2LowviVHZ-E',
      'transitId': transitId,
      'plateNumber': plateNumber,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      isProvider: json['isProvider'],
      userId: json['userId'],
      profilePic: json['profilePic'],
      transitId: json['transitId'],
      plateNumber: json['plateNumber'],
      isAdmin: json['isAdmin'],
      isDriver: json['isDriver'],
    );
  }
}
