import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/delete_vendor_phar/delete_vendor_phar_model.dart';

import '../../Pharmacy_home/controller/pharmacy_home_controller.dart';
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

  PharmacyHomeController pharmacyHomeController = Get.put(PharmacyHomeController());

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
      }
    },).onError((error, _) {
      debugPrint("Error delete vendor $error");
      setError(error.toString());
      setRxDeleteVendorStatus(Status.ERROR);
    },);
  }


}