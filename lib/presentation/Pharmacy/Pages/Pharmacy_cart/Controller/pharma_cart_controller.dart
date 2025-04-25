import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/pharma_cart_modal/PharmaCartModal.dart';

import '../pharma_cart_modal/pharmacyCheckoutAllModel.dart';
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

  getPharmacyCartApi({required String cartId}) async {
    readOnly.value = true;
    couponCodeController.value.clear();
    setRxRequestStatus(Status.LOADING);
    api.pharmacyCartGetDataApi({'cart_id': cartId}).then((value) {
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

  refreshApi({required String cartId}) async {
    setRxRequestStatus(Status.LOADING);
    couponCodeController.value.clear();
    readOnly.value = true;
    api.pharmacyCartGetDataApi({'cart_id': cartId}).then((value) {
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }

  //-----------------Get all pharmacy cart data api (Home screen)

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


//-----------------Get all pharmacy cart data api (My cart screen)


  final cartCheckoutData = PharmacyCheckOutAllModel().obs;
  void setCartCheckoutData(PharmacyCheckOutAllModel value){
    cartCheckoutData.value = value;
  }

  final rxGetCheckoutDataStatus = Status.LOADING.obs;
  void rxSetGetCheckoutData(Status value) => rxGetCheckoutDataStatus.value = value;

  getAllCartProductsForCheckout() async {
    rxSetGetCheckoutData(Status.LOADING);
    api.getPharmacyCheckOutAllApi().then((value) {
      setCartCheckoutData(value);
      if(value.status == true){
        rxSetGetCheckoutData(Status.COMPLETED);
      }
    },).onError((error, stackTrace) {
      setError(error.toString());
      print(stackTrace);
      print('errrrrrrrrrrrr getPharmacyCheckOutAllApi : ${error.toString()}');
      rxSetGetCheckoutData(Status.ERROR);
    },);
  }

}