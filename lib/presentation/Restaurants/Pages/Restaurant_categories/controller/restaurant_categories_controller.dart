import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Modal/restaurant_categories_modal.dart';

class RestaurantCategoriesController extends GetxController {
  // @override
  // void onInit() {
  //   restaurant_Categories_Api();
  //   super.onInit();
  // }

  TextEditingController searchController = TextEditingController();

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final categoriesData = restaurant_Categories_Modal().obs;

  RxString error = ''.obs;

  RxList<Allcategory> filteredWishlistData = RxList<Allcategory>();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categories_Set(restaurant_Categories_Modal value) {
    categoriesData.value = value;
    filteredWishlistData.value = List.from(value.allcategory!);
  }

  void setError(String value) => error.value = value;

  void filterCategories(String query) {
    if (query.isEmpty) {
      filteredWishlistData.value = List.from(categoriesData.value.allcategory!);
    } else {
      filteredWishlistData.value = categoriesData.value.allcategory!
          .where((category) =>
              category.name!.toLowerCase().contains(query.toLowerCase()))
          .toList(); // Filter categories
    }
  }

  restaurant_Categories_Api() async {
    searchController.clear();
    // setRxRequestStatus(Status.LOADING);
    api.restaurant_Categories_Api().then((value) {
      categories_Set(value);
      filterCategories(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      setRxRequestStatus(Status.ERROR);
    });
  }
}
