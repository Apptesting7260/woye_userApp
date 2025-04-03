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

  RxInt currentPage = 1.obs;
  RxBool noLoading = false.obs;
  RxBool isLoading = false.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final homeData = GroceryHomeModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void homeSet(GroceryHomeModal value) => homeData.value = value;

  RxList<GroceryShops> shopsList = <GroceryShops>[].obs;

  void pharmaShopSet(GroceryHomeModal value) {
    if (value.groceryShops?.data != null) {
      shopsList.addAll(value.groceryShops?.data ?? []);
    }
    if (shopsList.length == value.groceryShops!.total) {
      noLoading.value = true;
    }
  }

  void setError(String value) => error.value = value;

  homeApi(int page) async {
    api.groceryHomeApi(page: page, perPage: 10).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      isLoading.value = false;
      homeSet(value);
      pharmaShopSet(value);
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
    currentPage.value = 1;
    noLoading.value = false;
    setRxRequestStatus(Status.LOADING);
    api.groceryHomeApi(page: page, perPage: 10).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      isLoading.value = false;
      homeSet(value);
      pharmaShopSet(value);

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
