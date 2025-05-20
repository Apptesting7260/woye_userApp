import 'dart:developer';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/modal/pharamacy_home_modal.dart';

class PharmacyHomeController extends GetxController {
  @override
  void onInit() {
    homeApi(1);
    // TODO: implement onInit
    super.onInit();
  }
  RxBool isLoadingPharmacy = false.obs;
  RxBool noMoreDataPharmacyLoading = false.obs;

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
  final homeData = PharamacyHomeModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void homeSet(PharamacyHomeModal value) => homeData.value = value;

  RxList<PharmaShops> shopsList = <PharmaShops>[].obs;
  RxList<PharmaShops> freeDeliveryShopsList = <PharmaShops>[].obs;

  // void pharmaShopSet(PharamacyHomeModal value) {
  //   if (value.pharmaShops?.data != null) {
  //     shopsList.addAll(value.pharmaShops?.data ?? []);
  //   }
  //   if (shopsList.length == value.pharmaShops!.total) {
  //     noMoreDataPharmacyLoading.value = true;
  //   }
  // }

  void setError(String value) => error.value = value;

  homeApi(int page) async {
    api.pharmacyHomeApi(page: page, perPage: 10).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      isLoadingPharmacy.value = false;
      isLoadingPopular.value = false;
      isLoadingNearby.value = false;
      isLoadingFree.value = false;
      // isLoading.value = false;
      homeSet(value);

      if(homeData.value.pharmaShops!.data!.isNotEmpty){
        shopsList.addAll(homeData.value.pharmaShops?.data ?? []);
        if (shopsList.length >= (value.pharmaShops?.total ?? 0)) {
          noMoreDataPopularLoading.value = true;
        }
      }

      if(homeData.value.pharmaShops!.data!.isNotEmpty){
        freeDeliveryShopsList.addAll(homeData.value.pharmaShops?.data ?? []);
        if (freeDeliveryShopsList.length >= (value.pharmaShops?.total ?? 0)) {
          noMoreDataFreeLoading.value = true;
        }
      }

      // pharmaShopSet(value);
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
    isLoadingPharmacy.value = false;
    noMoreDataPharmacyLoading.value = false;

    isLoadingPopular.value = false;
    noMoreDataPopularLoading.value = false;
    isLoadingFree.value = false;
    noMoreDataFreeLoading.value = false;
    isLoadingNearby.value = false;
    noMoreDataNearbyLoading.value = false;
    setRxRequestStatus(Status.LOADING);
    // homeApi(1);
    api.pharmacyHomeApi(page: 1, perPage: 10).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      // isLoading.value = false;
      isLoadingPharmacy.value = false;
      isLoadingPopular.value = false;
      isLoadingNearby.value = false;
      isLoadingFree.value = false;
      homeSet(value);
      // pharmaShopSet(value);
      if(homeData.value.pharmaShops!.data!.isNotEmpty){
        shopsList.addAll(homeData.value.pharmaShops?.data ?? []);
        if (shopsList.length >= (value.pharmaShops?.total ?? 0)) {
          noMoreDataPopularLoading.value = true;
        }
      }

      if(homeData.value.pharmaShops!.data!.isNotEmpty){
        freeDeliveryShopsList.addAll(homeData.value.pharmaShops?.data ?? []);
        if (freeDeliveryShopsList.length >= (value.pharmaShops?.total ?? 0)) {
          noMoreDataFreeLoading.value = true;
        }
      }

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
