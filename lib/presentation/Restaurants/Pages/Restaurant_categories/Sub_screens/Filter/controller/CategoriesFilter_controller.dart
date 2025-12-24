import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/modal/CategoriesFilter_modal.dart';

class Categories_FilterController extends GetxController {
  @override
  void onInit() {
    // restaurant_get_CategoriesFilter_Api();
    selectedQuickFilters.clear();
    selectedCuisines.clear();
    priceRadioValue.value = 0;
    selectedAttributes.clear();
    selectedAddons.clear();
    selectedOptions.clear();
    super.onInit();
  }

  RxList<String> selectedCuisines = <String>[].obs;
  RxList selectedQuickFilters = [].obs;
  RxList<String> selectedAttributes = <String>[].obs;
  RxList<String> selectedAddons = <String>[].obs;
  RxList<String> selectedOptions = <String>[].obs;

  final RxDouble lowerValue = 1.0.obs;
  final RxDouble upperValue = 10.0.obs;
  RxInt priceRadioValue = 0.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final getFilterData = CategoriesFilter_modal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void get_CategoriesFilter_Set(CategoriesFilter_modal value) => getFilterData.value = value;

  void setError(String value) => error.value = value;

  restaurant_get_CategoriesFilter_Api(String categoryId) async {
    api.get_CategoriesFilter_Api(categoryId).then((value) {
      get_CategoriesFilter_Set(value);
      lowerValue.value = getFilterData.value.minPrice!.toDouble();
      upperValue.value = getFilterData.value.maxPrice!.toDouble();
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  Refresh_Api(String categoryId) async {
    setRxRequestStatus(Status.LOADING);
    api.get_CategoriesFilter_Api(categoryId).then((value) {
      get_CategoriesFilter_Set(value);
      lowerValue.value = getFilterData.value.minPrice!.toDouble();
      upperValue.value = getFilterData.value.maxPrice!.toDouble();
      selectedQuickFilters.clear();
      selectedCuisines.clear();
      priceRadioValue.value = 0;
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

  void resetFilters() {
    selectedCuisines.clear();
    selectedCuisines.refresh();
    selectedQuickFilters.clear();
    selectedQuickFilters.refresh();
    selectedAttributes.clear();
    selectedAttributes.refresh();
    selectedAddons.clear();
    selectedAddons.refresh();
    selectedOptions.clear();
    selectedOptions.refresh();
    if(getFilterData.value.minPrice != null){
      lowerValue.value = getFilterData.value.minPrice!.toDouble();
    }
    if(getFilterData.value.maxPrice != null){
      upperValue.value = getFilterData.value.maxPrice!.toDouble();
    }
    for (var cuisine in (getFilterData.value.cuisineId??[])) {
      cuisine.isSelected.value = false;
    }
    for (var option in (getFilterData.value.options??[])) {
      option.isSelected.value = false;
    }
    for (var attribute in (getFilterData.value.attributeIds??[])) {
      attribute.isSelected.value = false;
    }
    for (var addon in (getFilterData.value.addons??[])) {
      addon.isSelected.value = false;
    }
    priceRadioValue.value = 0;
    update();
  }
}
