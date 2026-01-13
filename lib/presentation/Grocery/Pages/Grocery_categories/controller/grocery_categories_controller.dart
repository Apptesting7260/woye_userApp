import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Modal/pharmacy_categories_modal.dart';

class GroceryCategoriesController extends GetxController {
  TextEditingController searchController = TextEditingController();

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final categoriesData = PharmacyCategoriesModal().obs;

  RxString error = ''.obs;

  RxList<Allcategory> filteredWishlistData = RxList<Allcategory>();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void categoriesSet(PharmacyCategoriesModal value) {
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

  pharmacyCategoriesApi() async {
    searchController.clear();
    // setRxRequestStatus(Status.LOADING);
    api.groceryCategoriesApi().then((value) {
      categoriesSet(value);
      filterCategories(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr   ${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  pharmacyCategoriesApiRefresh() async {
    searchController.clear();
    setRxRequestStatus(Status.LOADING);
    api.groceryCategoriesApi().then((value) {
      categoriesSet(value);
      filterCategories(searchController.text);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr   ${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }
}
