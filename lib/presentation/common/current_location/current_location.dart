import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Presentation/Common/Home/home_controller.dart';

class CurrentLocationController extends GetxController {
  RxString location = "".obs;
  var lat = 0.0.obs;
  var long = 0.0.obs;
  final GetStorage storage = GetStorage();

// ================Loction start  =================

  RxString currentAddress = "".obs;
  Position? _currentPosition;
  final HomeController homeController = Get.put(HomeController());

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        const SnackBar(content: Text('Location permissions are denied'));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.'));
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition({bool back = false}) async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      print("position ${_currentPosition}");
      _getAddressFromLatLng(_currentPosition!, back);
      _getLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position, bool back) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      String houseNumber = place.subThoroughfare ?? '';
      String street = place.thoroughfare ?? '';
      String subLocality = place.subLocality ?? '';
      String locality = place.locality ?? '';
      String subAdministrativeArea = place.subAdministrativeArea ?? '';
      String postalCode = place.postalCode ?? '';
      currentAddress.value =
          '$houseNumber $street, $subLocality, $locality, $subAdministrativeArea, $postalCode';
      location.value = currentAddress.value.toString();
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      storage.write('location', location.value);
      storage.write('latitude', position.latitude);
      storage.write('longitude', position.longitude);
      print("jjjjkk ${currentAddress.value}");
      print("asdfg ${location.value}");
      if (back == true) {
        Get.back();
      }
      homeController.loadLocationData();
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<void> _getLatLng(Position position) async {
    try {
      // print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      lat.value = position.latitude;
      long.value = position.longitude;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
