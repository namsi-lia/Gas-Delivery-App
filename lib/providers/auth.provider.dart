import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gas_delivery_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:gas_delivery_app/providers/location_provider.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    await FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'pushToken': token});
    }).catchError((err) {});
    await getCurrentUser();
    notifyListeners();
  }

  Future<void> signup(UserModel userModel) async {
    final UserCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userModel.email!, password: userModel.password!);
    userModel.userId = UserCredential.user!.uid;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(UserCredential.user!.uid)
        .set(userModel.toJson());

    await FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'pushToken': token});
    }).catchError((err) {});

    await getCurrentUser();
    notifyListeners();
  }

  Future<void> getCurrentUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
      return UserModel.fromJson(value);
    });
    final locs = await getUserLocations();
    userData.locations = locs;
    _user = userData;
    notifyListeners();
  }

  Future<List<UserLocation>> getUserLocations() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final locations = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('locations')
        .get();

    return locations.docs.map((e) => UserLocation.fromJson(e)).toList();
  }

  Future<UserLocation> getLocationDetails(LatLng loc) async {
    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: loc.latitude,
        longitude: loc.longitude,
        googleMapApiKey: "AIzaSyDh5qpjkMtAYq7z2ehE2ynLg73BxPjesKA");

    return UserLocation(
      city: data.city,
      country: data.country,
      street: data.streetNumber,
      postalCode: data.postalCode,
      address: data.address,
      state: data.state,
      location: GeoPoint(loc.latitude, loc.longitude),
    );
  }

  Future<void> updateProfile(UserModel userData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userData.userId)
        .update(userData.toJson());
    getCurrentUser();
    notifyListeners();
  }

  Future<void> updateProfilePic(File profile) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final upload = await FirebaseStorage.instance
        .ref('profile_pics/$uid')
        .putFile(profile);
    final url = await upload.ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'profilePic': url});
    setProfilePic(url);
    notifyListeners();
  }

  void setTransitId(String? id) {
    if (id == null) {
      _user!.transitId = null;
    } else {
      _user!.transitId = id;
    }
    notifyListeners();
  }

  void setProfilePic(String url) {
    _user!.profilePic = url;
    notifyListeners();
  }
}
