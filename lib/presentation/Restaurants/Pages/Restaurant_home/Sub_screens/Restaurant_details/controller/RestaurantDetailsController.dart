import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/modal/singal_restaurant_modal.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class RestaurantDetailsController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final restaurant_Data = SpecificRestaurantModal().obs;
  var location = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  RxInt categoriesIndex = 0.obs;
  RxString error = ''.obs;

  var distance = 0.0.obs;
  var travelTime = 0.0.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void restaurant_Set(SpecificRestaurantModal value) =>
      restaurant_Data.value = value;

  void setError(String value) => error.value = value;

  Future restaurant_Details_Api({
    required String id,
  }) async {
    categoriesIndex.value = 0;
    loadLocationData();
    setRxRequestStatus(Status.LOADING);
    Map data = {"restaurant_id": id};
   await api.specific_Restaurant_Api(data).then((value) {
      restaurant_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      double? apiLatitude = restaurant_Data.value.restaurant?.latitude != null
          ? double.tryParse(restaurant_Data.value.restaurant!.latitude!)
          : null;
      double? apiLongitude = restaurant_Data.value.restaurant?.longitude != null
          ? double.tryParse(restaurant_Data.value.restaurant!.longitude!)
          : null;
      if (apiLatitude != null && apiLongitude != null) {
        distance.value = calculateDistance(
          latitude.value,
          longitude.value,
          apiLatitude,
          apiLongitude,
        );
      }

      print(
          "Location from api ${restaurant_Data.value.restaurant?.shopAddress}");
      print("latitude from api ${restaurant_Data.value.restaurant?.latitude}");
      print(
          "longitude from api ${restaurant_Data.value.restaurant?.longitude}");
      print("Calculated Distance: ${distance.value} km");

      double travelTimeInMinutes = calculateTravelTime(distance.value, 15);

      travelTime.value = travelTimeInMinutes;

      print(
          "Estimated Travel Time: ${travelTime.value.toStringAsFixed(2)} minutes");
      update();
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  Future refresh_restaurant_Details_Api({
    required String id,
  }) async {
    loadLocationData();
    // setRxRequestStatus(Status.LOADING);
    Map data = {"restaurant_id": id};
    print("objectdata $data");
   await api.specific_Restaurant_Api(data).then((value) {
      restaurant_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      double? apiLatitude = restaurant_Data.value.restaurant?.latitude != null
          ? double.tryParse(restaurant_Data.value.restaurant!.latitude!)
          : null;
      double? apiLongitude = restaurant_Data.value.restaurant?.longitude != null
          ? double.tryParse(restaurant_Data.value.restaurant!.longitude!)
          : null;
      if (apiLatitude != null && apiLongitude != null) {
        distance.value = calculateDistance(
          latitude.value,
          longitude.value,
          apiLatitude,
          apiLongitude,
        );
      }

      print(
          "Location from api ${restaurant_Data.value.restaurant?.shopAddress}");
      print("latitude from api ${restaurant_Data.value.restaurant?.latitude}");
      print(
          "longitude from api ${restaurant_Data.value.restaurant?.longitude}");
      print("Calculated Distance: ${distance.value} km");

      double travelTimeInMinutes = calculateTravelTime(distance.value, 15);

      travelTime.value = travelTimeInMinutes;

      print(
          "Estimated Travel Time: ${travelTime.value.toStringAsFixed(2)} minutes");
      update();
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr refresh_restaurant_Details_Api');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  void loadLocationData() async {
    var storage = GetStorage();
    location.value = storage.read('location') ?? '';
    latitude.value = storage.read('latitude') ?? 0.0;
    longitude.value = storage.read('longitude') ?? 0.0;
    print('Stored Location: ${location.value}');
    print('Stored Latitude: ${latitude.value}');
    print('Stored Longitude: ${longitude.value}');
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371.0;

    double lat1Rad = _toRadians(lat1);
    double lon1Rad = _toRadians(lon1);
    double lat2Rad = _toRadians(lat2);
    double lon2Rad = _toRadians(lon2);

    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180.0;
  }

  double calculateTravelTime(double distanceInKm, double speedInKmPerHour) {
    double timeInHours = distanceInKm / speedInKmPerHour;

    double timeInMinutes = timeInHours * 60;
    return timeInMinutes;
  }

  String formatDate(String? dateString) {
    if (dateString == null) {
      return "";
    }
    try {
      DateTime date = DateTime.parse(dateString);
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);
      print("Formatted Date: $formattedDate");
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e");
      return "";
    }
  }
}
