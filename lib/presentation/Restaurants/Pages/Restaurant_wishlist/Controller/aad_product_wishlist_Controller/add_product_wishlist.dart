import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/Modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/restaurant_wishlist_controller.dart';

import '../../../Restaurant_home/Sub_screens/More_Products/controller/more_products_controller.dart';
import '../../../Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';

class AddProductWishlistController extends GetxController {
  final RestaurantCategoriesDetailsController
      restaurantCategoriesDetailsController =
      Get.put(RestaurantCategoriesDetailsController());

  final RestaurantWishlistController restaurantWishlistController =
      Get.put(RestaurantWishlistController());

  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final add_Wishlist = restaurant_add_product_wishlist_modal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(restaurant_add_product_wishlist_modal value) =>
      add_Wishlist.value = value;

  void setError(String value) => error.value = value;
  final RestaurantDetailsController restaurantDetailsController = Get.put(RestaurantDetailsController());
  final seeAll_Product_Controller seeAllProductController =Get.put(seeAll_Product_Controller());
  final specific_Product_Controller specificProductController = Get.put(specific_Product_Controller());

  Future<void> restaurant_add_product_wishlist({
    required String categoryId,
    required String product_id,
    String? restaurantId,
    String? productIdAllProducts,
    bool? isRefresh,
    String? cuisineType,
     String? priceSort,
    var quickFilter,
    String? priceRange,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {"product_id": product_id};

    await api.add_Product_Wishlist(data).then((value) {
      categories_Set(value);
      setRxRequestStatus(Status.COMPLETED);
      if (add_Wishlist.value.status == true) {
        print("1234 $restaurantId");
        print("1234 ${restaurantId.runtimeType}");
        if (categoryId == "") {
          restaurantWishlistController.restaurant_product_wishlist_api();
        }
        // if (restaurantId != null && restaurantId.toString().trim().isNotEmpty) {
        //   restaurantDetailsController.refresh_restaurant_Details_Api(id: restaurantDetailsController.restaurant_Data.value.restaurant?.id.toString() ?? restaurantId);
        // }
        if(categoryId != "") {
          if ((cuisineType != null && cuisineType != '') || priceSort != null || quickFilter != null || priceRange != null) {
            restaurantCategoriesDetailsController.restaurant_Categories_Details_filter_Api(
              id: categoryId.toString(),
              cuisine_type: cuisineType,
              price_sort: priceSort,
              quick_filter: quickFilter,
              price_range: priceRange,
            );
          }else{
            restaurantCategoriesDetailsController.refresh_Restaurant_Categories_Details_Api(id: categoryId);
          }
        }
        restaurantDetailsController.refresh_restaurant_Details_Api(id: restaurantDetailsController.restaurant_Data.value.restaurant?.id.toString() ?? restaurantId ?? "");
        if(restaurantId != null && categoryId != ''){
          seeAllProductController.refresh_seeAll_Product_Api(category_id: categoryId, restaurant_id: restaurantId);
        }
        if(categoryId != "" && productIdAllProducts != "" && isRefresh == true){
          specificProductController.refreshSpecificProductApi(
            productId: productIdAllProducts.toString(),
            categoryId:categoryId.toString(),
          );
        }
        restaurantWishlistController.restaurantProductWishlistRefreshApi();

        Utils.showToast(add_Wishlist.value.message.toString());
      } else {
        Utils.showToast(add_Wishlist.value.message.toString());
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
