import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/Modal/RestaurantCategoryDetailsModal.dart';

class RestaurantCategoriesDetailsController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final categoriesDetailsData = RestaurantCategoryDetailsModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(RestaurantCategoryDetailsModal value) =>
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

  restaurant_Categories_Details_Api({
    required String id,
  }) async {
    searchController.clear();
    filterProductSearchData.clear();
    searchData.clear();
    setRxRequestStatus(Status.LOADING);
    Map data = {"category_id": id};
    api.Restaurant_Category_Details_Api(data).then((value) {
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

  restaurant_Categories_Details_filter_Api({
    required String id,
    required String cuisine_type,
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
      "cuisine_type": cuisine_type,
      "price_sort": price_sort,
      "quick_filter[]": quick_filter,
      "price_range": price_range,
    };
    api.Restaurant_Category_Details_Api(data).then((value) {
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
