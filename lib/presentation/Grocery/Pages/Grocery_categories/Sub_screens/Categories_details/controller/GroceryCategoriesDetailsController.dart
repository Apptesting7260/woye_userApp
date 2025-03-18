import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/Sub_screens/Categories_details/modal/grocery_categories_details_modal.dart';

class Grocerycategoriesdetailscontroller extends GetxController {
  TextEditingController searchController = TextEditingController();

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final categoriesDetailsData = GroceryCategoriesDetailsModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(GroceryCategoriesDetailsModal value) =>
      categoriesDetailsData.value = value;

  void setError(String value) => error.value = value;

  RxList<CategoryProduct> searchData = RxList<CategoryProduct>();

  void searchDataFun(String query) {
    if (query.isEmpty) {
      searchData.value = categoriesDetailsData.value.categoryProduct ?? [];
    } else {
      searchData.value = categoriesDetailsData.value.categoryProduct
              ?.where((product) =>
                  product.title!.toLowerCase().contains(query.toLowerCase()))
              .toList() ??
          [];
    }
  }

  groceryCategoriesDetailsApi({
    required String id,
  }) async {
    searchController.clear();
    filterProductSearchData.clear();
    searchData.clear();
    setRxRequestStatus(Status.LOADING);
    Map data = {"category_id": id};
    api.groceryCategoriesDetailsApi(data).then((value) {
      categories_Set(value);
      searchDataFun(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  RxList<CategoryProduct> filterProductSearchData = RxList<CategoryProduct>();

  void filterSearchDataFun(String query) {
    if (query.isEmpty) {
      filterProductSearchData.value =
          categoriesDetailsData.value.filterProduct ?? [];
    } else {
      filterProductSearchData.value = categoriesDetailsData.value.filterProduct
              ?.where((product) =>
                  product.title!.toLowerCase().contains(query.toLowerCase()))
              .toList() ??
          [];
    }
  }

groceryCategoriesDetailsFilterApi({
  required String id,
  required String product_type,
  required String price_sort,
  required var quick_filter,
  required String price_range,
}) async {
  searchController.clear();
  searchData.clear();
  filterProductSearchData.clear();
  setRxRequestStatus(Status.LOADING);
  Map data = {
    "category_id": id,
    "brand_type": product_type,
    "price_sort": price_sort,
    "sort_by": quick_filter,
    "price_range": price_range,
  };
  api.groceryCategoriesDetailsApi(data).then((value) {
    categories_Set(value);
    filterSearchDataFun(searchController.text);
    setRxRequestStatus(Status.COMPLETED);
  }).onError((error, stackError) {
    setError(error.toString());
    print(stackError);
    print('errrrrrrrrrrrr');
    print(error);
    setRxRequestStatus(Status.ERROR);
  });
}
}
