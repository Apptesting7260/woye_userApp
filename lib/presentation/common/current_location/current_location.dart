import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
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

  int hasPermissionForSettings = 0;

  Future<void> getCurrentPosition({bool back = false}) async {
    hasPermissionForSettings++;
    print("hasPermissionForSettings $hasPermissionForSettings");
    final hasPermission = await _handleLocationPermission();
    print("objectobjectobjectobjectobjectobject12345${back}");
    if (hasPermissionForSettings > 1 && !hasPermission) {
      print("objectobjectobjectobjectobjectobject${back}");
      print("hasPermissionForSettingsagain $hasPermissionForSettings");
      Get.back();
      _showPermissionDialog();
      return;
    }
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      _currentPosition = position;
      print("position ${_currentPosition}");
      _getAddressFromLatLng(_currentPosition!, back);
      _getLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  void _showPermissionDialog() {
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          title: const Text("Permission Denied"),
          content: const Text(
              "Location permission is required to continue. Please go to settings and enable location access."),
          actions: <Widget>[
            TextButton(
              child: const Text("Open Settings"),
              onPressed: () {
                Get.back();
                openAppSettings();
              },
            ),
          ],
        ),
      ),
    );
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
      // currentAddress.value =
      //     '$houseNumber $street, $subLocality, $locality, $subAdministrativeArea, $postalCode';
      // Create a list of address components
      List<String> addressComponents = [];

      if (houseNumber.isNotEmpty) addressComponents.add(houseNumber);
      if (street.isNotEmpty) addressComponents.add(street);
      if (subLocality.isNotEmpty) addressComponents.add(subLocality);
      if (locality.isNotEmpty) addressComponents.add(locality);
      if (subAdministrativeArea.isNotEmpty) {
        addressComponents.add(subAdministrativeArea);
      }
      if (postalCode.isNotEmpty) addressComponents.add(postalCode);
      currentAddress.value = addressComponents.join(', ');
      location.value = "";
      location.value = currentAddress.value.toString();
      print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
      storage.write('location', location.value);
      storage.write('latitude', position.latitude);
      storage.write('longitude', position.longitude);
      print("Updated Location: ${location.value}");
      print("objectobjectobjectobjectobjectobject${back}");
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
      lat.value = position.latitude;
      long.value = position.longitude;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
