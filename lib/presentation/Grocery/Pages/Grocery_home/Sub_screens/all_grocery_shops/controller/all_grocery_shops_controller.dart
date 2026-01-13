import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/all_grocery_shops/modal/all_Grocery_shops.dart';

class AllGroceryShopsController extends GetxController {
  @override
  void onInit() {
    seeAllPharmaShopsApi();
    super.onInit();
  }

  TextEditingController searchController = TextEditingController();

  RxList<Shops> filteredWishlistData = RxList<Shops>();

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final pharmaShopData = AllGroceryShopsModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void pharmaShop_Set(AllGroceryShopsModal value) {
    pharmaShopData.value = value;
    filteredWishlistData.value = List.from(value.shops!);
  }

  void setError(String value) => error.value = value;

  void filterCategories(String query) {
    if (query.isEmpty) {
      filteredWishlistData.value = List.from(pharmaShopData.value.shops!);
    } else {
      filteredWishlistData.value = pharmaShopData.value.shops!
          .where((shop) =>
          shop.shopName!.toLowerCase().contains(query.toLowerCase()))
          .toList(); // Filter categories
    }
  }

  seeAllPharmaShopsApi() async {
    api.allGroceryShopsApi().then((value) {
      pharmaShop_Set(value);
      filterCategories(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshApi() async {
    setRxRequestStatus(Status.LOADING);
    api.allGroceryShopsApi().then((value) {
      pharmaShop_Set(value);
      filterCategories(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
