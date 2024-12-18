import 'dart:ffi';

import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/Modal/RestaurantCategoryDetailsModal.dart';
import '../../../../../../../Data/Model/usermodel.dart';
import '../../../../../../../Data/userPrefrenceController.dart';

class RestaurantCategoriesDetailsController extends GetxController {
  // @override
  // void onInit() {
  //   restaurant_Categories_Details_Api();
  //   // TODO: implement onInit
  //   super.onInit();
  // }
  // RxBool isFavorite = true.obs;
  TextEditingController searchController = TextEditingController();

  void filterProducts(String searchText) {
    print("Categories Length: ${categoriesDetailsData.value.filterProduct?.length}");
    if (categoriesDetailsData.value.filterProduct != null &&
        categoriesDetailsData.value.filterProduct!.isNotEmpty) {
      if (searchText.isEmpty) {
        print("Showing all products");
        categoriesDetailsData.value.filterProduct = categoriesDetailsData.value.categoryProduct!;
      } else {
        // Filter the products based on title
        categoriesDetailsData.value.filterProduct = categoriesDetailsData.value.categoryProduct!
            .where((product) =>
            product.title!.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      }
      print("Filtered Products Length: ${categoriesDetailsData.value.filterProduct?.length}");
    } else {
      print("No products available to filter.");
    }
  }


  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final categoriesDetailsData = RestaurantCategoryDetailsModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(RestaurantCategoryDetailsModal value) =>
      categoriesDetailsData.value = value;

  void setError(String value) => error.value = value;

  restaurant_Categories_Details_Api({
    required String id,
  }) async {
    setRxRequestStatus(Status.LOADING);

    Map data = {"category_id": id};

    api.Restaurant_Category_Details_Api(data).then((value) {
      categories_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      print("categoriesData.value.status${categoriesDetailsData.value.status}");
      // if (categoriesDetailsData.value.status == true) {
      //   Get.toNamed(AppRoutes.restaurantCategoriesDetails, arguments: title);
      // }
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  restaurant_Categories_Details_filter_Api({
    required String id,
    required String cuisine_type,
    required String price_sort,
    required var quick_filter,
    required String price_range,
  }) async {
    // String quickFilterString = quick_filter.join(', ');
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
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  restaurant_Categories_Details_Api2({
    required String id,
  }) async {
    // setRxRequestStatus(Status.LOADING);
    UserModel userModel = UserModel();
    var pref = UserPreference();
    userModel = await pref.getUser();
    Map data = {"category_id": id};

    api.Restaurant_Category_Details_Api(data).then((value) {
      categories_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      print("categoriesData.value.status${categoriesDetailsData.value.status}");
      // if (categoriesDetailsData.value.status == true) {
      //   Get.toNamed(AppRoutes.restaurantCategoriesDetails, arguments: title);
      // }
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
