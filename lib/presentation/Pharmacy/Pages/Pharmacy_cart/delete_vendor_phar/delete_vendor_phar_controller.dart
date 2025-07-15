

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/snackbar.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Presentation/Pharmacy/Pages/Pharmacy_home/controller/pharmacy_home_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/delete_vendor_phar/delete_vendor_phar_model.dart';

import '../Controller/pharma_cart_controller.dart';

class DeleteVendorPharController extends GetxController{

  final api =  Repository();
  final RxString error = "".obs;
  final apiDataDeleteVendorData = VendorDeletePharModel().obs;
  final rxDeleteVendorReqStatus = Status.LOADING.obs;
  void setRxDeleteVendorStatus(Status value)=> rxDeleteVendorReqStatus.value = value;
  void setData(VendorDeletePharModel value) => apiDataDeleteVendorData.value = value;
  void setError(String value) => error.value = value;
  final PharmacyCartController pharmacyCartController = Get.put(PharmacyCartController());

  // PharmacyHomeController pharmacyHomeController = Get.put(PharmacyHomeController());

  deletePharVendorApi({required String cartId,required bool isSingleCartScreen})async{
    var data = {
      'cart_id' : cartId,
    };
    setRxDeleteVendorStatus(Status.LOADING);
    api.deleteVendorPharApi(data).then((value) {
      setData(value);
      if(apiDataDeleteVendorData.value.status == true){
        print("Cmpleted");
        setRxDeleteVendorStatus(Status.COMPLETED);
        isSingleCartScreen == false ?
        pharmacyCartController.refreshGetAllCartProductsForCheckout():
        pharmacyCartController.getPharmacyCartApiAfterInc(cartId: cartId);
        pharmacyCartController.getAllPharmacyCartData();
        if(!isSingleCartScreen){
          Get.back();
        }
      }else if(value.status == false){
        setRxDeleteVendorStatus(Status.ERROR);
        Utils.showToast(value.message.toString());
        Get.back();
      }
    },).onError((error, _) {
      debugPrint("Error delete vendor $error");
      setError(error.toString());
      setRxDeleteVendorStatus(Status.ERROR);
    },);
  }


}