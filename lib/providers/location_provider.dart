import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geocoder2/geocoder2.dart';

class UserLocation {
  final GeoPoint? location;
  final String? city;
  final String? country;
  final String? street;
  final String? postalCode;
  final String? state;
  final String? address;

  UserLocation(
      {this.location,
      this.city,
      this.country,
      this.street,
      this.postalCode,
      this.state,
      this.address});

  Map<String, dynamic> toJson() {
    return {
      'location': GeoPoint(location?.latitude ?? 0, location?.longitude ?? 0),
      'city': city,
      'country': country,
      'street': street,
      'state': state,
      'postalCode': postalCode,
      'address': address,
    };
  }

  factory UserLocation.fromJson(dynamic json) {
    return UserLocation(
      location: json['location'],
      city: json['city'],
      country: json['country'],
      state: json['state'],
      street: json['street'],
      postalCode: json['postalCode'],
      address: json['address'],
    );
  }
}

class LocationProvider with ChangeNotifier {
  double? _longitude;
  double? _latitude;
  double? get longitude => _longitude;
  double? get latitude => _latitude;
  LocationData? _locationData;
  LocationData? get locationData {
    return _locationData;
  }

  UserLocation? _userLocation;
  UserLocation? get userLocation {
    return _userLocation;
  }

  List<Map<String, dynamic>> _addressList = [];
  Future<void> getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();

      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // user location:getting current user location

    _locationData = await location.getLocation();

    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: _locationData!.latitude!,
        longitude: _locationData!.longitude!,
        googleMapApiKey: "AIzaSyDh5qpjkMtAYq7z2ehE2ynLg73BxPjesKA");

    _userLocation = UserLocation(
      city: data.city,
      country: data.country,
      street: data.streetNumber,
      postalCode: data.postalCode,
      address: data.address,
      state: data.state,
      location: GeoPoint(_locationData!.latitude!, _locationData!.longitude!),
    );
    notifyListeners();
  }

  List preferredUserLocations({Map<String, dynamic>? locations}) {
    final currentLocation = {
      'title': 'Current Location',
      'address': userLocation!.address,
    };
    if (locations != null) {
      _addressList.add(locations);
    }
    return [
      currentLocation,
      _addressList,
    ];
  }

  Future<UserLocation> getLocationDetails(LatLng loc) async {
    GeoData data = await Geocoder2.getDataFromCoordinates(
        latitude: loc.latitude,
        longitude: loc.longitude,
        googleMapApiKey: "AIzaSyDh5qpjkMtAYq7z2ehE2ynLg73BxPjesKA");

    return UserLocation(
        city: data.city,
        country: data.country,
        postalCode: data.postalCode,
        address: data.address,
        state: data.state,
        location:
            GeoPoint(_locationData!.latitude!, _locationData!.longitude!));
  }
}
