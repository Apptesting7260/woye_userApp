import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/Sub_screens/Filter/grocery_Categories_Filter_modal.dart';

class GroceryCategoriesFilterController extends GetxController {
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
  final getFilterData = GroceryCategoriesFilterModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void get_CategoriesFilter_Set(GroceryCategoriesFilterModal value) =>
      getFilterData.value = value;

  void setError(String value) => error.value = value;

  groceryGetCategoriesFilterApi() async {
    api.getGroceryCategoriesFilterApi().then((value) {
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

  refreshApi() async {
    setRxRequestStatus(Status.LOADING);
    api.getGroceryCategoriesFilterApi().then((value) {
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
}
