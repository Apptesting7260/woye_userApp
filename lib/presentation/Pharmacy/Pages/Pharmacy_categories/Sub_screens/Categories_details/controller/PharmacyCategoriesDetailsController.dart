import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Categories_details/modal/pharmacy_categories_details_modal.dart';

class PharmacyCategoriesDetailsController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final categoriesDetailsData = PharmacyCategoriesDetailsModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(PharmacyCategoriesDetailsModal value) =>
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

  pharmacy_Categories_Details_Api({
    required String id,
  }) async {
    searchController.clear();
    filterProductSearchData.clear();
    searchData.clear();
    setRxRequestStatus(Status.LOADING);
    Map data = {"category_id": id};
    api.pharmacyCategoriesDetailsApi(data).then((value) {
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

  refresh_pharmacy_Categories_Details_Api({
    required String id,
  }) async {
    // searchController.clear();
    // filterProductSearchData.clear();
    // searchData.clear();
    // setRxRequestStatus(Status.LOADING);
    Map data = {"category_id": id};
    api.pharmacyCategoriesDetailsApi(data).then((value) {
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

pharmacy_Categories_Details_filter_Api({
   String? id,
   String? product_type,
   String? price_sort,
   var quick_filter,
   String? price_range,
}) async {
  searchController.clear();
  searchData.clear();
  filterProductSearchData.clear();
  setRxRequestStatus(Status.LOADING);
  // Map data = {
  //   "category_id": id,
  //   "brand_type": product_type ?? "",
  //   "price_sort": price_sort ?? "",
  //   "sort_by": quick_filter ?? "",
  //   "price_range": price_range ?? "",
  // };
  Map data = {
    "category_id": id,
    if(product_type != null && product_type != '')
      "cuisine_type": product_type,
    if(price_sort != null)
      "price_sort": price_sort,
    if(quick_filter != null && quick_filter != "")
      "sort_by": quick_filter,
    if(price_range != null)
      "price_range": price_range,
  };
  print("Map data: $data");
  api.pharmacyCategoriesDetailsApi(data).then((value) {
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

refresh_pharmacy_Categories_Details_filter_Api({
   String? id,
   String? product_type,
   String? price_sort,
   var quick_filter,
   String? price_range,
}) async {
  // searchController.clear();
  // searchData.clear();
  // filterProductSearchData.clear();
  // setRxRequestStatus(Status.LOADING);
  Map data = {
    "category_id": id,
    if(product_type != null && product_type != '')
    "brand_type": product_type,

    if(price_sort != null && price_sort != "")
    "price_sort": price_sort,

    if (quick_filter != null && quick_filter.isNotEmpty && (price_sort == null || price_sort.isEmpty) && quick_filter != [])
    "sort_by": quick_filter ?? "",

    if(price_range != null&& price_sort == "")
    "price_range": price_range,
  };

  print("Map data: $data");
  api.pharmacyCategoriesDetailsApi(data).then((value) {
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
