import 'dart:developer';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/modal/pharamacy_home_modal.dart';

class PharmacyHomeController extends GetxController {
  // @override
  // void onInit() {
  //   homeApi(1);
  //   // TODO: implement onInit
  //   super.onInit();
  // }

  RxInt currentPage = 1.obs;
  RxBool noLoading = false.obs;
  RxBool isLoading = false.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final homeData = PharamacyHomeModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void homeSet(PharamacyHomeModal value) => homeData.value = value;

  // RxList<Restaurant> restaurantList = <Restaurant>[].obs;

  // void restaurantSet(PharamacyHomeModal value) {
  //   if (value.pharmaShops != null) {
  //     restaurantList.addAll(value.pharmaShops ?? []);
  //   }
  //   if (restaurantList.length == value.pharmaShops!.total) {
  //     noLoading.value = true;
  //   }
  // }

  void setError(String value) => error.value = value;

  homeApi(int page) async {
    api.pharmacyHomeApi(page: page, perPage: 1).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      isLoading.value = false;
      homeSet(value);
      // restaurantSet(value);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  homeApiRefresh(int page) async {
    // restaurantList.clear();
    currentPage.value = 1;
    noLoading.value = false;
    setRxRequestStatus(Status.LOADING);
    api.pharmacyHomeApi(page: 1, perPage: 1).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      isLoading.value = false;
      homeSet(value);
      // restaurantSet(value);

      if (homeData.value.status == true) {
        log('home data ==>>${homeData.value.status}');
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
