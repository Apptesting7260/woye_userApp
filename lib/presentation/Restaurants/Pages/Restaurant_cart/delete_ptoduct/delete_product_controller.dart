import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/delete_ptoduct/delete_product_modal.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class DeleteProductController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final deleteProductData = DeleteProductModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(DeleteProductModal value) => deleteProductData.value = value;
  void setError(String value) => error.value = value;

  final RestaurantCartController restaurantCartController = Get.put(RestaurantCartController());

  deleteProductApi({
    required String productId,
    required String countId,
    required String cartId,
    required bool isSingleCartScreen,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "product_id": productId,
      "count_id": countId,
      "cart_id": cartId,
    };
    api.deleteProductApi(body).then((value) {
      setData(value);
      if (deleteProductData.value.status == true) {
        if( isSingleCartScreen == true){
        restaurantCartController.refreshApiSingleCart(cartId:cartId).then((value) async {
          await Future.delayed(const Duration( milliseconds: 500));
          setRxRequestStatus(Status.COMPLETED);
          Utils.showToast(deleteProductData.value.message.toString());
          Get.back();
          restaurantCartController.getAllCartData();
        });
        } else if(isSingleCartScreen == false){
          restaurantCartController.refreshGetAllCheckoutDataRes().then((value) async {
            setRxRequestStatus(Status.COMPLETED);
            Utils.showToast(deleteProductData.value.message.toString());
            Get.back();
            restaurantCartController.getAllCartData();
          });
        }
      }
      /* else {
        Utils.showToast(deleteProductData.value.message.toString());
        setRxRequestStatus(Status.COMPLETED);
      }*/
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }



  //----- Delete vendor api
  final rxDeleteVendorStatus = Status.LOADING.obs;
  void setRxRequestStatusDeleteVendor(Status value) => rxDeleteVendorStatus.value = value;
   deleteVendorRestaurantApi({required String cartId,required bool isSingleCartScreen})async{
     var data = {
       "cart_id" : cartId,
     };
    setRxRequestStatusDeleteVendor(Status.LOADING);
    api.deleteVendorRestaurantApi(data).then((value) {
      setData(value);
      if(value.status == true){
        setRxRequestStatusDeleteVendor(Status.COMPLETED);
        if(isSingleCartScreen ==  true){

        }else{
          Get.back();
          Utils.showToast(value.message.toString());
          restaurantCartController.refreshGetAllCheckoutDataRes();
        }
      }else if(value.status == false){
        setRxRequestStatusDeleteVendor(Status.COMPLETED);
      }else{
        setRxRequestStatusDeleteVendor(Status.ERROR);
      }
    },).onError((error, stackError) {
      setError(error.toString());
      pt('error restaurant delete vendor api >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ');
      pt(error);
      pt(stackError);
      setRxRequestStatusDeleteVendor(Status.ERROR);
    });

  }

}
