import 'dart:developer';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Model/home_model.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class RestaurantHomeController extends GetxController {

  @override
  void onInit() {
    homeApi(1,);
    super.onInit();
  }

  RxInt currentPage = 1.obs;
  // RxBool noLoading = false.obs;
  // RxBool isLoading = false.obs;

  // Main Restaurant
  // RxInt currentPageRestaurant = 1.obs;
  RxBool isLoadingRestaurant = false.obs;
  RxBool noMoreDataRestaurant = false.obs;

// Popular
//   RxInt currentPagePopular = 1.obs;
  RxBool isLoadingPopular = false.obs;
  RxBool noMoreDataPopular = false.obs;

// Nearby
//   RxInt currentPageNearby = 1.obs;
  RxBool isLoadingNearby = false.obs;
  RxBool noMoreDataNearby = false.obs;

// Free Delivery
//   RxInt currentPageFree = 1.obs;
  RxBool isLoadingFree = false.obs;
  RxBool noMoreDataFree = false.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final homeData = HomeModel().obs;

  RxString error = ''.obs;
  void setError(String value) => error.value = value;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void homeSet(HomeModel value) => homeData.value = value;

  RxList<Restaurant> restaurantList = <Restaurant>[].obs;
  RxList<Restaurant> popularRestaurantList = <Restaurant>[].obs;
  RxList<Restaurant> freeDeliveryRestaurantList = <Restaurant>[].obs;
  RxList<Restaurant> freeDeliveryRestaurantList1 = <Restaurant>[].obs;
  RxList<Restaurant> nearByRestaurantList = <Restaurant>[].obs;


  // void restaurantSet(HomeModel value/*, String resType*/) {
  //   // /////////////////////////////////////////////////////////
  //   // if(resType == "refresh" || resType == 'init'){
  //   //   pt("resType>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $resType");
  //   //   if (value.restaurants?.data != null || (value.restaurants?.data?.isNotEmpty ?? false)) {
  //   //     restaurantList.addAll(value.restaurants?.data ?? []);
  //   //     if (restaurantList.length >= (value.restaurants?.total ?? 0)) {
  //   //       noMoreDataRestaurant.value = true;
  //   //     }
  //   //   }
  //
  //     // if (value.popularResto?.data != null || (value.popularResto?.data?.isNotEmpty ?? false)) {
  //     //   popularRestaurantList.addAll(value.popularResto?.data ?? []);
  //     //   if (popularRestaurantList.length >= (value.popularResto?.total ?? 0)) {
  //     //     noMoreDataPopular.value = true;
  //     //   }
  //     // }
  //
  //     // if (value.nearbyResto?.data != null|| (value.nearbyResto?.data?.isNotEmpty ?? false)) {
  //     //   nearByRestaurantList.addAll(value.nearbyResto?.data ?? []);
  //     //   if (nearByRestaurantList.length >= (value.nearbyResto?.total ?? 0)) {
  //     //     noMoreDataNearby.value = true;
  //     //   }
  //     // }
  //
  //     // if (value.freedelResto?.data != null|| (value.freedelResto?.data?.isNotEmpty ?? false)) {
  //     //   freeDeliveryRestaurantList.addAll(value.freedelResto?.data ?? []);
  //     //   if (freeDeliveryRestaurantList.length >= (value.freedelResto?.total ?? 0)) {
  //     //     noMoreDataFree.value = true;
  //     //   }
  //     // }
  //   // }
  // }


  homeApi(int page,/*String restaurantType*/) async {
      api.homeApi(page: page, perPage: 10).then((value) {
        setRxRequestStatus(Status.COMPLETED);
        // isLoading.value = false;
        isLoadingRestaurant.value = false;
        isLoadingPopular.value = false;
        isLoadingNearby.value = false;
        isLoadingFree.value = false;
        homeSet(value);
        // restaurantSet(value,/*restaurantType*/);
        if(homeData.value.freedelResto!.data!.isNotEmpty){
          freeDeliveryRestaurantList.addAll(homeData.value.freedelResto?.data ?? []);
          if (freeDeliveryRestaurantList.length >= (value.freedelResto?.total ?? 0)) {
            noMoreDataFree.value = true;
          }
        }
        if(homeData.value.popularResto!.data!.isNotEmpty){
          popularRestaurantList.addAll(homeData.value.popularResto?.data ?? []);
          if (popularRestaurantList.length >= (value.popularResto?.total ?? 0)) {
             noMoreDataPopular.value = true;
          }
        }
        if (homeData.value.nearbyResto!.data!.isNotEmpty) {
          nearByRestaurantList.addAll(homeData.value.nearbyResto?.data ?? []);
          if (nearByRestaurantList.length >= (value.nearbyResto?.total ?? 0)) {
            noMoreDataNearby.value = true;
          }
        }
        if (homeData.value.restaurants!.data!.isNotEmpty) {
          restaurantList.addAll(value.restaurants?.data ?? []);
          if (restaurantList.length >= (value.restaurants?.total ?? 0)) {
            noMoreDataRestaurant.value = true;
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
    // Clear all lists
    restaurantList.clear();
    popularRestaurantList.clear();
    freeDeliveryRestaurantList.clear();
    freeDeliveryRestaurantList1.clear();
    nearByRestaurantList.clear();
    currentPage.value =1;
    // Reset pagination and flags
    // currentPageRestaurant.value = 1;
    isLoadingRestaurant.value = false;
    noMoreDataRestaurant.value = false;

    // currentPagePopular.value = 1;
    isLoadingPopular.value = false;
    noMoreDataPopular.value = false;

    // currentPageFree.value = 1;
    isLoadingFree.value = false;
    noMoreDataFree.value = false;

    // currentPageNearby.value = 1;
    isLoadingNearby.value = false;
    noMoreDataNearby.value = false;

    setRxRequestStatus(Status.LOADING);
    homeApi(1,);
    // Reset global status (optional)
    // api.homeApi(page: 1, perPage: 10).then((value)async {
    //
    //   // setRxRequestStatus(Status.COMPLETED);
    //   // isLoading.value = false;
    //   homeSet(value);
    //   // await homeApi(1, "refresh");
    //   restaurantSet(value,'refresh');
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
