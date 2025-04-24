import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_cart_modal/PharmaCartModal.dart';

import '../pharma_cart_modal/pharmacy_all_product_model.dart';

class PharmacyCartController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final cartData = PharmaCartModal().obs;

  final Rx<TextEditingController> couponCodeController =
      TextEditingController().obs;

  var readOnly = true.obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(PharmaCartModal value) {
    cartData.value = value;
  }
  // void cartSetAll(PharmacyAllCartProductModel value) {
  //   cartDataAll.value = value;
  // }

  void setError(String value) => error.value = value;

  getPharmacyCartApi({String? cartId}) async {
    readOnly.value = true;
    couponCodeController.value.clear();
    setRxRequestStatus(Status.LOADING);
    api.pharmacyCartGetDataApi({'cart_id': cartId ?? "341"}).then((value) {
      cartSet(value);
      // cartSetAll(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshApi() async {
    setRxRequestStatus(Status.LOADING);
    couponCodeController.value.clear();
    readOnly.value = true;
    api.pharmacyCartGetDataApi({'cart_id':"341"}).then((value) {
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  //-----------------Get all pharmacy cart data api implementation

  final cartDataAll = PharmacyAllCartProductModel().obs;
  void setCartData(PharmacyAllCartProductModel value){
    cartDataAll.value = value;
  }

  final rxGetAllPCartData = Status.LOADING.obs;
  void rxSetGetAllPCartData(Status value) => rxGetAllPCartData.value = value;

    getAllPharmacyCartData() async {
      rxSetGetAllPCartData(Status.LOADING);
      api.getAllPharmacyCartDataApi().then((value) {
        setCartData(value);
        if(cartDataAll.value.status == true){
          rxSetGetAllPCartData(Status.COMPLETED);
        }
      },).onError((error, stackError) {
        setError(error.toString());
        print(stackError);
        print('errrrrrrrrrrrr SetGetAllPCartData : ${error.toString()}');
        rxSetGetAllPCartData(Status.ERROR);
      });
    }
}