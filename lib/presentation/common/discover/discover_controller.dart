import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Model/home_model.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../../Data/Repository/repository.dart';

class DiscoverRestaurentController extends GetxController{
  var storage = GetStorage();

  @override
  void onInit() {
    homeApi();
    getLatLong();
    super.onInit();
  }

  getLatLong(){
    latitude.value = storage.read('latitude').toString();
    longitude.value =storage.read('longitude').toString();
    pt("lat long >> ${latitude.value} ::: ${longitude.value}");
  }
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final homeData = HomeModel().obs;
  RxBool isLoadingFilter = false.obs;

  RxString error = ''.obs;
  void setError(String value) => error.value = value;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void homeSet(HomeModel value) => homeData.value = value;

  RxString rating = "".obs;
  RxString deliveryFee = "".obs;
  RxString openNow = "".obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;

  homeApi() async {
    Map<String,dynamic> params = {
      if(rating.value.isNotEmpty)
        "rating": rating.value.toLowerCase(),
      if(deliveryFee.value.isNotEmpty)
        "delivery_fee": deliveryFee.value.toLowerCase(),
      if(openNow.value.isNotEmpty)
        "open_now": openNow.value.toLowerCase(),
      if(latitude.value.isNotEmpty)
        "lat": latitude.value,
      if(longitude.value.isNotEmpty)
        "lng": longitude.value,
    };

    api.homeApi(params).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      homeSet(value);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  homeApiForFilter() async {
    isLoadingFilter.value = true;
    Map<String,dynamic> params = {
      if(rating.value.isNotEmpty)
        "rating": rating.value.toLowerCase(),
      if(deliveryFee.value.isNotEmpty)
        "delivery_fee": deliveryFee.value.toLowerCase(),
      if(openNow.value.isNotEmpty)
        "open_now": openNow.value.toLowerCase(),
      if(latitude.value.isNotEmpty)
        "lat": latitude.value,
      if(longitude.value.isNotEmpty)
        "lng": longitude.value,
    };
    api.homeApi(params).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      isLoadingFilter.value = false;
      homeSet(value);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  homeApiRefresh() async {
    rating.value = "";
    deliveryFee.value = "";
    openNow.value = "";
    latitude.value = storage.read('latitude').toString();
    longitude.value =storage.read('longitude').toString();
    Map<String,dynamic> params = {
      "lat": latitude.value,
      "lng": longitude.value,
    };

    setRxRequestStatus(Status.LOADING);
    api.homeApi(params).then((value)async {
      setRxRequestStatus(Status.COMPLETED);
      homeSet(value);
      if (homeData.value.status == true) {
        log('home data ==>>${homeData.value.status}');
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}