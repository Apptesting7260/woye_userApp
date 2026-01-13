import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/modal/pharamacy_home_modal.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class PharmacyHomeController extends GetxController {
  @override
  void onInit() {
    getLatLong();
    homeApi();
    super.onInit();
  }

  var storage = GetStorage();
  getLatLong(){
    latitude.value = storage.read('latitude').toString();
    longitude.value =storage.read('longitude').toString();
    pt("lat long pharma>> ${latitude.value} ::: ${longitude.value}");
  }
  // RxBool isLoadingPharmacy = false.obs;
  // RxBool noMoreDataPharmacyLoading = false.obs;
  //
  // RxBool isLoadingPopular = false.obs;
  // RxBool noMoreDataPopularLoading = false.obs;
  //
  // RxBool isLoadingNearby = false.obs;
  // RxBool noMoreDataNearbyLoading = false.obs;
  //
  // RxBool isLoadingFree = false.obs;
  // RxBool noMoreDataFreeLoading = false.obs;
  //
  // RxInt currentPage = 1.obs;
  // // RxBool noLoading = false.obs;
  // // RxBool isLoading = false.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final rxRequestStatusFilter = Status.COMPLETED.obs;
  final homeData = PharamacyHomeModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setRxRequestStatusFilter(Status value) => rxRequestStatusFilter.value = value;

  void homeSet(PharamacyHomeModal value) => homeData.value = value;
  void setError(String value) => error.value = value;

  RxString rating = "".obs;
  RxString deliveryFee = "".obs;
  RxString openNow = "".obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;

    homeApi() async {
    Map<String,dynamic> params = {
      // 'page':"1",
      // "per_page":"10",
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
    api.pharmacyHomeApi(params).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      setRxRequestStatusFilter(Status.COMPLETED);
      homeSet(value);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr Home pharma');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
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
      // 'page':"1",
      // "per_page":"10",
      // "lat":"28.6139",
      // "lng":"77.2090",
      "lat": latitude.value,
      // if(longitude.value.isNotEmpty)
      "lng": longitude.value,
    };
    setRxRequestStatus(Status.LOADING);
    // homeApi(1);
    api.pharmacyHomeApi(params).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      homeSet(value);
      // pharmaShopSet(value);
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


// RxList<Data> allPharmaShopsList = <Data>[].obs;
  // RxList<Data> freeDeliveryShopsList = <Data>[].obs;
  // RxList<Data> nearByShopsList = <Data>[].obs;
  // RxList<Data> popularShopsList = <Data>[].obs;

  // void pharmaShopSet(PharamacyHomeModal value) {
  //   if (value.pharmaShops?.data != null) {
  //     shopsList.addAll(value.pharmaShops?.data ?? []);
  //   }
  //   if (shopsList.length == value.pharmaShops!.total) {
  //     noMoreDataPharmacyLoading.value = true;
  //   }
  // }


  // homeApi(int page) async {
  //   api.pharmacyHomeApi(page: page, perPage: 10).then((value) {
  //     setRxRequestStatus(Status.COMPLETED);
  //     isLoadingPharmacy.value = false;
  //     isLoadingPopular.value = false;
  //     isLoadingNearby.value = false;
  //     isLoadingFree.value = false;
  //     // isLoading.value = false;
  //     homeSet(value);
  //
  //     if(homeData.value.pharmaShops!.data!.isNotEmpty){
  //       allPharmaShopsList.addAll(homeData.value.pharmaShops?.data ?? []);
  //       if (allPharmaShopsList.length >= (int.parse(value.pharmaShops?.total ?? 0) )) {
  //         noMoreDataPharmacyLoading.value = true;
  //       }
  //     }
  //
  //     if(homeData.value.freedelPharma!.data!.isNotEmpty){
  //       freeDeliveryShopsList.addAll(homeData.value.freedelPharma?.data ?? []);
  //       if (freeDeliveryShopsList.length >= (int.parse(value.freedelPharma?.total ?? 0))) {
  //         noMoreDataFreeLoading.value = true;
  //       }
  //     }
  //
  //     if(homeData.value.popularPharma!.data!.isNotEmpty){
  //       popularShopsList.addAll(homeData.value.popularPharma?.data ?? []);
  //       if (popularShopsList.length >= (int.parse(value.popularPharma?.total ?? 0))) {
  //         noMoreDataPopularLoading.value = true;
  //       }
  //     }
  //
  //     if(homeData.value.nearbyPharma!.data!.isNotEmpty){
  //       nearByShopsList.addAll(homeData.value.nearbyPharma?.data ?? []);
  //       if (nearByShopsList.length >= (int.parse(value.nearbyPharma?.total ?? 0))) {
  //         noMoreDataNearbyLoading.value = true;
  //       }
  //     }
  //
  //     // pharmaShopSet(value);
  //   }).onError((error, stackError) {
  //     setError(error.toString());
  //     print(stackError);
  //     print('errrrrrrrrrrrr Home pharma');
  //     // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
  //     print(error);
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
  //
  // homeApiRefresh(int page) async {
  //   allPharmaShopsList.clear();
  //   freeDeliveryShopsList.clear();
  //   nearByShopsList.clear();
  //   popularShopsList.clear();
  //   currentPage.value = 1;
  //   isLoadingPharmacy.value = false;
  //   noMoreDataPharmacyLoading.value = false;
  //
  //   isLoadingPopular.value = false;
  //   noMoreDataPopularLoading.value = false;
  //   isLoadingFree.value = false;
  //   noMoreDataFreeLoading.value = false;
  //   isLoadingNearby.value = false;
  //   noMoreDataNearbyLoading.value = false;
  //   setRxRequestStatus(Status.LOADING);
  //   // homeApi(1);
  //   api.pharmacyHomeApi(page: 1, perPage: 10).then((value) {
  //     setRxRequestStatus(Status.COMPLETED);
  //     // isLoading.value = false;
  //     isLoadingPharmacy.value = false;
  //     isLoadingPopular.value = false;
  //     isLoadingNearby.value = false;
  //     isLoadingFree.value = false;
  //     homeSet(value);
  //     // pharmaShopSet(value);
  //     if(homeData.value.pharmaShops!.data!.isNotEmpty){
  //       allPharmaShopsList.addAll(homeData.value.pharmaShops?.data ?? []);
  //       if (allPharmaShopsList.length >= (int.parse(value.pharmaShops?.total ?? 0) )) {
  //         noMoreDataPharmacyLoading.value = true;
  //       }
  //     }
  //
  //     if(homeData.value.freedelPharma!.data!.isNotEmpty){
  //       freeDeliveryShopsList.addAll(homeData.value.freedelPharma?.data ?? []);
  //       if (freeDeliveryShopsList.length >= (int.parse(value.freedelPharma?.total ?? 0))) {
  //         noMoreDataFreeLoading.value = true;
  //       }
  //     }
  //
  //     if(homeData.value.popularPharma!.data!.isNotEmpty){
  //       popularShopsList.addAll(homeData.value.popularPharma?.data ?? []);
  //       if (popularShopsList.length >= (int.parse(value.popularPharma?.total ?? 0))) {
  //         noMoreDataPopularLoading.value = true;
  //       }
  //     }
  //
  //     if(homeData.value.nearbyPharma!.data!.isNotEmpty){
  //       nearByShopsList.addAll(homeData.value.nearbyPharma?.data ?? []);
  //       if (nearByShopsList.length >= (int.parse(value.nearbyPharma?.total ?? 0))) {
  //         noMoreDataNearbyLoading.value = true;
  //       }
  //     }
  //
  //     if (homeData.value.status == true) {
  //       log('home data ==>>${homeData.value.status}');
  //     }
  //   }).onError((error, stackError) {
  //     setError(error.toString());
  //     print(stackError);
  //     print('errrrrrrrrrrrr');
  //     // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
  //     print(error);
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
}
