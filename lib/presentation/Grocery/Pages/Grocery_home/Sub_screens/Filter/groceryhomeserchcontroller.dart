import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Filter/grocery_home_search_modal.dart';

class GroceryHomeSearchController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    searchData.value.pharmaShop = [];
    searchData.value.products = [];
  }

  TextEditingController homeSearchController = TextEditingController();

  var showLottie = false.obs;
  var stopLottie = false.obs;

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final searchData = GroceryHomeSearchModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setSearchData(GroceryHomeSearchModal value) => searchData.value = value;

  void setError(String value) => error.value = value;


  restaurantHomeSearchApi({
    required String search,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {"searchString": search};
    api.groceryHomeSearchApi(data).then((value) {
      setSearchData(value);
      showLottie.value = false;
      stopLottie.value = true;
      print("RRRRRRRRRRRRRRRRR${searchData.value.pharmaShop?.length}");
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
