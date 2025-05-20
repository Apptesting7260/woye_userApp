import 'dart:developer';

import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/modal/grocery_home_modal.dart';

class GroceryHomeController extends GetxController {
  @override
  void onInit() {
    homeApi(1);
    // TODO: implement onInit
    super.onInit();
  }
  RxBool isLoadingGrocery = false.obs;
  RxBool noMoreDataGroceryLoading = false.obs;

  RxBool isLoadingPopular = false.obs;
  RxBool noMoreDataPopularLoading = false.obs;

  RxBool isLoadingNearby = false.obs;
  RxBool noMoreDataNearbyLoading = false.obs;

  RxBool isLoadingFree = false.obs;
  RxBool noMoreDataFreeLoading = false.obs;

  RxInt currentPage = 1.obs;
  // RxBool noLoading = false.obs;
  // RxBool isLoading = false.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final homeData = GroceryHomeModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void homeSet(GroceryHomeModal value) => homeData.value = value;

  RxList<GroceryShops> shopsList = <GroceryShops>[].obs;
  RxList<GroceryShops> freeDeliveryShopsList = <GroceryShops>[].obs;

  // void pharmaShopSet(GroceryHomeModal value) {
  //   if (value.groceryShops?.data != null) {
  //     shopsList.addAll(value.groceryShops?.data ?? []);
  //   }
  //   if (shopsList.length == value.groceryShops!.total) {
  //     noMoreDataPopularLoading.value = true;
  //   }
  // }

  void setError(String value) => error.value = value;

  homeApi(int page) async {
    api.groceryHomeApi(page: page, perPage: 10).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      isLoadingGrocery.value = false;
      isLoadingPopular.value = false;
      isLoadingNearby.value = false;
      isLoadingFree.value = false;
      // isLoading.value = false;
      homeSet(value);
      // pharmaShopSet(value);
      if(homeData.value.groceryShops?.data?.isNotEmpty ?? false){
        shopsList.addAll(homeData.value.groceryShops?.data ?? []);
        if (shopsList.length >= (value.groceryShops?.total ?? 0)) {
          noMoreDataPopularLoading.value = true;
        }
      }
      if(homeData.value.groceryShops?.data?.isNotEmpty ?? false){
        freeDeliveryShopsList.addAll(homeData.value.groceryShops?.data ?? []);
        if (freeDeliveryShopsList.length >= (value.groceryShops?.total ?? 0)) {
          noMoreDataFreeLoading.value = true;
        }
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

  homeApiRefresh(int page) async {
    shopsList.clear();
    freeDeliveryShopsList.clear();
    currentPage.value = 1;
    isLoadingGrocery.value = false;
    noMoreDataGroceryLoading.value = false;

    isLoadingPopular.value = false;
    noMoreDataPopularLoading.value = false;

    isLoadingFree.value = false;
    noMoreDataFreeLoading.value = false;

    isLoadingNearby.value = false;
    noMoreDataNearbyLoading.value = false;
    // noLoading.value = false;
    setRxRequestStatus(Status.LOADING);
    homeApi(1);
    // api.groceryHomeApi(page: page, perPage: 10).then((value) {
    //   setRxRequestStatus(Status.COMPLETED);
    //   // isLoading.value = false;
    //
    //   isLoadingGrocery.value = false;
    //   isLoadingPopular.value = false;
    //   isLoadingNearby.value = false;
    //   isLoadingFree.value = false;
    //
    //   homeSet(value);
    //   // pharmaShopSet(value);
    //
    //   if (homeData.value.status == true) {
    //     log('home data ==>>${homeData.value.status}');
    //   }
    // }).onError((error, stackError) {
    //   setError(error.toString());
    //   print(stackError);
    //   print('errrrrrrrrrrrr');
    //   // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
    //   print(error);
    //   setRxRequestStatus(Status.ERROR);
    // });
  }
}
