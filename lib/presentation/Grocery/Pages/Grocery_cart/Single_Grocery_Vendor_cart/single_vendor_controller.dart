import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Single_Grocery_Vendor_cart/single_vendor_grocery_cart_model.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/show_all_grocery_carts/grocery_allCart_controller.dart';

class SingleGroceryCartController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final cartData = SingleVendorGroceryCart().obs;

  final Rx<TextEditingController> couponCodeController =
      TextEditingController().obs;



  var readOnly = true.obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(SingleVendorGroceryCart value) {
    cartData.value = value;
  }

  void setError(String value) => error.value = value;


  final GroceryShowAllCartController groceryShowAllCartController = Get.put(GroceryShowAllCartController());

  getGrocerySingleVendorCartApi(var cartId) async {
    setRxRequestStatus(Status.LOADING);
    readOnly.value = true;
    couponCodeController.value.clear();
    Map data = {"cart_id": cartId};
    api.grocerySingleVendorCartApi(data).then((value) {
      cartSet(value);
      if(cartData.value.cart == null){
        Get.back();
      }
      if(cartData.value.status == false){
        Utils.showToast(cartData.value.message.toString());
      }
      groceryShowAllCartController.getGroceryAllShowApi();
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }


//-----------checkout btn api

  final singleCartDataBtn = SingleVendorGroceryCart().obs;
  final rxRequestStatusSingleCartBtn = Status.COMPLETED.obs;
  void singleCartSetBtn(SingleVendorGroceryCart value) => singleCartDataBtn.value = value;
  void setRxRequestStatusSingleCartBtn(Status value) => rxRequestStatusSingleCartBtn.value = value;

  checkoutBtnApi(var cartId,context) async {
    var data = {
      "cart_id" : cartId,
    };
    Map<String, dynamic> params = {
      "key" : "checkout",
    };
    setRxRequestStatusSingleCartBtn(Status.LOADING);
    api.grocerySingleVendorCartApi(data,params: params).then((value) {
      singleCartSetBtn(value);
      if(singleCartDataBtn.value.status == true){
        setRxRequestStatusSingleCartBtn(Status.COMPLETED);
        Get.toNamed(AppRoutes.checkoutScreen, arguments: {
          'address_id': singleCartDataBtn.value.address?.id.toString(),
          'total': singleCartDataBtn.value.cart?.finalTotal.toString(),
          'coupon_id':singleCartDataBtn.value.cart?.raw?.couponId ??"",
          'regular_price': singleCartDataBtn.value.cart?.raw?.regularPrice.toString(),
          // 'coupon_discount': controller
          //     .cartData.value.cart?.couponDiscount
          //     .toString(),
          'save_amount': singleCartDataBtn.value.cart?.raw?.saveAmount.toString(),
          'delivery_charge': singleCartDataBtn.value.cart?.deliveryCharge.toString(),
          'cart_id': singleCartDataBtn.value.cart?.cartId,
          'vendor_id': singleCartDataBtn.value.cart?.raw?.decodedAttribute?.vendorId,
          'cart_total':singleCartDataBtn.value.cart?.raw?.totalPrice,
          'cart_delivery': singleCartDataBtn.value.cart?.deliveryCharge,
          'wallet':singleCartDataBtn.value.wallet.toString(),
          'cartType': "grocery",
          'grandtotal_price' : singleCartDataBtn.value.cart?.finalTotal.toString(),
          'coupon_discount': singleCartDataBtn.value.cart?.couponDiscount.toString(),
          'coupon_discount_payment_details': singleCartDataBtn.value.cart?.couponDiscount.toString(),
          // 'cartType': "grocerySingleOrder",
        });
      }
      else if(singleCartDataBtn.value.status == false){
        setRxRequestStatusSingleCartBtn(Status.COMPLETED);
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              backgroundColor: Colors.white,
              titlePadding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 8.h),
              contentPadding: REdgeInsets.symmetric(horizontal: 22,vertical: 15),
              actionsPadding: REdgeInsets.symmetric(horizontal: 25),
              insetPadding:REdgeInsets.symmetric(horizontal: 22),
              title:Icon(Icons.error_outline, color: AppColors.red, size: 24.r),
              content: Text(
                singleCartDataBtn.value.message?.toString() ?? "Something went wrong.",
                maxLines: 5,
                textAlign: TextAlign.center,
                style: AppFontStyle.text_16_500(
                  AppColors.darkText,
                  family: AppFontFamily.onestMedium,
                ),
              ),
              actions: <Widget>[
                CustomElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                  },
                  child: Text(
                    'OK',
                    style: AppFontStyle.text_15_600(
                      AppColors.white,
                      family: AppFontFamily.onestMedium,
                    ),
                  ),
                ),
                hBox(20.h),
              ],
            );
          },
        );
      }
      setRxRequestStatusSingleCartBtn(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      if(error == 'InternetExceptionWidget'){
        Utils.showToast("No Internet");
      }
      setRxRequestStatusSingleCartBtn(Status.ERROR);
    });
  }

  refreshApi(var cartId) async {
    // setRxRequestStatus(Status.LOADING);
    couponCodeController.value.clear();
    readOnly.value = true;
    Map data = {"cart_id": cartId};
    api.grocerySingleVendorCartApi(data).then((value) {
      cartSet(value);
      if(cartData.value.cart == null){
        Get.back();
      }
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr${error.toString()}');
      setRxRequestStatus(Status.ERROR);
    });
  }
}