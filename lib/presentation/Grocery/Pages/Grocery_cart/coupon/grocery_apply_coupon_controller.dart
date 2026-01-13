
import 'package:get/get.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/grocery_cart_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Single_Grocery_Vendor_cart/single_vendor_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/coupon_apply/apply_coupon_modal.dart';

class ApplyCouponGroceryController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final applyCouponData = ApplyCouponModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(ApplyCouponModal value) => applyCouponData.value = value;
  final GroceryCartController groceryCartController = Get.put(GroceryCartController());
  final SingleGroceryCartController singleGroceryCartController = Get.put(SingleGroceryCartController());


  applyCouponApi({
    bool? isSingleCartScreen,
    required List<Map<String,String>> carts,
    required String couponCode,
    String? cartId,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "carts": jsonEncode(carts),
      "coupon_code": couponCode,
    };
    api.applyCouponsApiGrocery(body).then((value) {
      setData(value);
      if (applyCouponData.value.status == true) {
        if(isSingleCartScreen != true){
        groceryCartController.refreshGetGroceryAllCartApi().then((value) async {
          setRxRequestStatus(Status.COMPLETED);
          await Future.delayed(const Duration(milliseconds: 500));
          if(groceryCartController.couponCodeController.value.text.isNotEmpty) {
            groceryCartController.couponCodeController.value.clear();
          }
          Utils.showToast(applyCouponData.value.message.toString());
        });
        }else{
          singleGroceryCartController.refreshApi(cartId).then((value) async {
            setRxRequestStatus(Status.COMPLETED);
            await Future.delayed(const Duration(milliseconds: 500));
            if(groceryCartController.couponCodeController.value.text.isNotEmpty) {
              groceryCartController.couponCodeController.value.clear();
            }
            Utils.showToast(applyCouponData.value.message.toString());
          });
        }
      } else {
        Utils.showToast(applyCouponData.value.message.toString());
        setRxRequestStatus(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }

  void setError(String value) => error.value = value;
}
