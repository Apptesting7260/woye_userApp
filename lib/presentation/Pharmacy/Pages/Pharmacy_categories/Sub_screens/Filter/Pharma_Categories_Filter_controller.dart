import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Filter/pharma_Categories_Filter_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/modal/CategoriesFilter_modal.dart';

class PharmaCategoriesFilterController extends GetxController {
  @override
  void onInit() {
    selectedQuickFilters.clear();
    selectedCuisines.clear();
    priceRadioValue.value = 0;
    super.onInit();
  }

  RxList<String> selectedCuisines = <String>[].obs;
  RxList selectedQuickFilters = [].obs;

  final RxDouble lowerValue = 1.0.obs;
  final RxDouble upperValue = 10.0.obs;
  RxInt priceRadioValue = 0.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final getFilterData = PharmaCategoriesFilterModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void get_CategoriesFilter_Set(PharmaCategoriesFilterModal value) =>
      getFilterData.value = value;

  void setError(String value) => error.value = value;

  pharmacy_get_CategoriesFilter_Api() async {
    api.getPharmaCategoriesFilterApi().then((value) {
      get_CategoriesFilter_Set(value);
      lowerValue.value = getFilterData.value.minPrice!.toDouble();
      upperValue.value = getFilterData.value.maxPrice!.toDouble();
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

  Refresh_Api() async {
    setRxRequestStatus(Status.LOADING);
    api.getPharmaCategoriesFilterApi().then((value) {
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
    if(getFilterData.value.minPrice != null){
      lowerValue.value = getFilterData.value.minPrice!.toDouble();
    }
    if(getFilterData.value.maxPrice != null){
      upperValue.value = getFilterData.value.maxPrice!.toDouble();
    }
    for (var cuisine in (getFilterData.value.cuisineType ?? [])) {
      cuisine.isSelected.value = false;
    }
    priceRadioValue.value = 0;
    update();
  }

}
