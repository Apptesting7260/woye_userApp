import 'dart:developer';

import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/modal/grocery_home_modal.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class GroceryHomeController extends GetxController {
  @override
  void onInit() {
    getLatLong();
    homeApi();
    // TODO: implement onInit
    super.onInit();
  }
  // RxBool isLoadingGrocery = false.obs;
  // RxBool noMoreDataGroceryLoading = false.obs;
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
  final homeData = GroceryHomeModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void homeSet(GroceryHomeModal value) => homeData.value = value;

  // RxList<GroceryShops> allShopsList = <GroceryShops>[].obs;
  // RxList<Data> freeDeliveryShopsList = <Data>[].obs;
  // RxList<GroceryShops> nearByShopsList = <GroceryShops>[].obs;
  // RxList<GroceryShops> popularShopsList = <GroceryShops>[].obs;

  // void pharmaShopSet(GroceryHomeModal value) {
  //   if (value.groceryShops?.data != null) {
  //     shopsList.addAll(value.groceryShops?.data ?? []);
  //   }
  //   if (shopsList.length == value.groceryShops!.total) {
  //     noMoreDataPopularLoading.value = true;
  //   }
  // }

  getLatLong(){
    latitude.value = storage.read('latitude').toString();
    longitude.value =storage.read('longitude').toString();
    pt("lat long grocery>> ${latitude.value} ::: ${longitude.value}");
  }

  void setError(String value) => error.value = value;
  var storage = GetStorage();

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
    api.groceryHomeApi(params).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      homeSet(value);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('error home api grocery');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  homeApiRefresh() async {
    rating.value = "";
    deliveryFee.value = "";
    openNow.value = "";
    getLatLong();
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
    api.groceryHomeApi(params).then((value) {
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

// homeApi(int page) async {
  //   api.groceryHomeApi(page: page, perPage: 10).then((value) {
  //     setRxRequestStatus(Status.COMPLETED);
  //     isLoadingGrocery.value = false;
  //     isLoadingPopular.value = false;
  //     isLoadingNearby.value = false;
  //     isLoadingFree.value = false;
  //     // isLoading.value = false;
  //     homeSet(value);
  //     // pharmaShopSet(value);
  //     if(homeData.value.popularGrocery?.data?.isNotEmpty ?? false){
  //       popularShopsList.addAll(homeData.value.popularGrocery?.data ?? []);
  //       if (popularShopsList.length >= (value.popularGrocery?.total ?? 0)) {
  //         noMoreDataPopularLoading.value = true;
  //       }
  //     }
  //
  //     if(homeData.value.freedelGrocery?.data?.isNotEmpty ?? false){
  //       freeDeliveryShopsList.addAll(homeData.value.freedelGrocery?.data ?? []);
  //       if (freeDeliveryShopsList.length >= (int.parse(value.freedelGrocery?.total  ?? 0))) {
  //         noMoreDataFreeLoading.value = true;
  //       }
  //     }
  //
  //     if(homeData.value.nearbyGrocery?.data?.isNotEmpty ?? false){
  //       nearByShopsList.addAll(homeData.value.nearbyGrocery?.data ?? []);
  //       if (nearByShopsList.length >= (value.nearbyGrocery?.total ?? 0)) {
  //         noMoreDataNearbyLoading.value = true;
  //       }
  //     }
  //
  //     if(homeData.value.groceryShops?.data?.isNotEmpty ?? false){
  //       allShopsList.addAll(homeData.value.groceryShops?.data ?? []);
  //       if (allShopsList.length >= (value.groceryShops?.total ?? 0)) {
  //         noMoreDataGroceryLoading.value = true;
  //       }
  //     }
  //
  //   }).onError((error, stackError) {
  //     setError(error.toString());
  //     print(stackError);
  //     print('errrrrrrrrrrrr');
  //     // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
  //     print(error);
  //     setRxRequestStatus(Status.ERROR);
  //   });
  // }
  //
  // homeApiRefresh(int page) async {
  //   allShopsList.clear();
  //   freeDeliveryShopsList.clear();
  //   nearByShopsList.clear();
  //   popularShopsList.clear();
  //   currentPage.value = 1;
  //   isLoadingGrocery.value = false;
  //   noMoreDataGroceryLoading.value = false;
  //
  //   isLoadingPopular.value = false;
  //   noMoreDataPopularLoading.value = false;
  //
  //   isLoadingFree.value = false;
  //   noMoreDataFreeLoading.value = false;
  //
  //   isLoadingNearby.value = false;
  //   noMoreDataNearbyLoading.value = false;
  //   // noLoading.value = false;
  //   setRxRequestStatus(Status.LOADING);
  //   homeApi(1);
  //   // api.groceryHomeApi(page: page, perPage: 10).then((value) {
  //   //   setRxRequestStatus(Status.COMPLETED);
  //   //   // isLoading.value = false;
  //   //
  //   //   isLoadingGrocery.value = false;
  //   //   isLoadingPopular.value = false;
  //   //   isLoadingNearby.value = false;
  //   //   isLoadingFree.value = false;
  //   //
  //   //   homeSet(value);
  //   //   // pharmaShopSet(value);
  //   //
  //   //   if (homeData.value.status == true) {
  //   //     log('home data ==>>${homeData.value.status}');
  //   //   }
  //   // }).onError((error, stackError) {
  //   //   setError(error.toString());
  //   //   print(stackError);
  //   //   print('errrrrrrrrrrrr');
  //   //   // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
  //   //   print(error);
  //   //   setRxRequestStatus(Status.ERROR);
  //   // });
  // }
}
