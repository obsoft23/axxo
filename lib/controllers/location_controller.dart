// ignore_for_file: avoid_print, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vixo/constants.dart';

class LocationController extends GetxController {
  final Rx<dynamic> locationData = Rx<dynamic>(null);
  late Position _currentPosition;

  @override
  void onInit() async {
    // Get called when controller is created
    super.onInit();
    // Start listening for location changes
  }

  @override
  void onClose() {
    //Get called when controller is removed from memory
    super.onClose();
  }

  Future<bool> isLocationGranted() async {
    /* if (await Permission.location.request().isGranted) {
      print(
          "Either the permission was already granted before or the user just granted it.");
      PermissionStatus status = await Permission.location.status;
      return status.isGranted;
    }*/

    PermissionStatus status = await Permission.location.status;
    return status.isGranted;
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      status = await Permission.location.request();
    }

    if (status.isGranted) {
      print('Location permission granted');
    } else {
      print('Location permission denied');
    }
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    print("checking permission: $permission");
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      print(
          "ocation permissions are permanently denied, we cannot request permissions.");
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position? position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    locationData.value =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    // ignore: unnecessary_brace_in_string_interps
    print('location value : ${position}');
    _currentPosition = position;

    updateLocationInFirestore();
    Get.offAllNamed("notification_intro");
    return;
  }

  Future<void> updateLocationInFirestore() async {
    try {
      print("updating  user location in DB");
      await firestore
          .collection('user_locations')
          .doc(auth.currentUser!.uid)
          .set({
        'uid': auth.currentUser!.uid,
        'latitude': _currentPosition.latitude,
        'longitude': _currentPosition.longitude,
        'timestamp': Timestamp.now(),
      });
      locationData.value =
          'New position info is now Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}';

      return;
    } catch (error) {
      print('Error updating location: $error');
    }
  }
}
