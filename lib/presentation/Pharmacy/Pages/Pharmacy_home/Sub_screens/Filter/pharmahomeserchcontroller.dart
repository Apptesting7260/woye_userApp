import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Filter/pharma_home_search_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/search/modal/homesearchmodal.dart';

class PharmaHomeSerchController extends GetxController {
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
  final searchData = PharmaHomeSearchModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setSearchData(PharmaHomeSearchModal value) => searchData.value = value;

  void setError(String value) => error.value = value;

  restaurantHomeSearchApi({
    required String search,
  }) async {
    setRxRequestStatus(Status.LOADING);
    Map data = {"searchString": search};
    api.pharmaHomeSearchApi(data).then((value) {
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
