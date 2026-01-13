import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/main.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/RestaurantCartModal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/grocery_order_type_model.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/restaurant_all_cart_data_model.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/restaurant_single_cart_model.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class RestaurantCartController extends GetxController {
  final api = Repository();
  final rxRequestStatusSingleCart = Status.LOADING.obs;
  final rxRequestStatus = Status.LOADING.obs;
  final cartData = RestaurantCartModal().obs;
  final singleCartData = RestaurantSingleCartModel().obs;

  final storage = GetStorage();

  // var cartCount = 0.obs;

  final Rx<TextEditingController> couponCodeController = TextEditingController().obs;

  // RxBool isCartScreen = false.obs;

  var readOnly = true.obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(RestaurantCartModal value) => cartData.value = value;

  @override
  void onInit() {
    // getRestaurantCartApi(cartId: "");
    super.onInit();
  }

  Future<void> deleteTips()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('saved_tip_restaurant') ?? '';
   var removed =  await prefs.remove('saved_tip_restaurant');
    pt("tips removed>>>>>>>>>>>>>>>>>>>>>>>>>> getAllCartData $removed");
  }

  void setError(String value) => error.value = value;
  // final CartController cartController = Get.put(CartController());

  ////////-----------------Single cart api restaurant
  void singleCartSet(RestaurantSingleCartModel value) => singleCartData.value = value;
  void setRxRequestStatusSingleCart(Status value) => rxRequestStatusSingleCart.value = value;

  getRestaurantSingleCartApi({required String cartId}) async {
    var data = {
      "cart_id" : cartId,
    };
    readOnly.value = true;
    print("./././././././././././.${cartId}");
    couponCodeController.value.clear();
    setRxRequestStatusSingleCart(Status.LOADING);
    api.restaurantCartGetDataApi(data).then((value) {
      singleCartSet(value);
      setRxRequestStatusSingleCart(Status.COMPLETED);
      if(singleCartDataBtn.value.cart?.cartId == null || (singleCartDataBtn.value.cart?.cartId?.isEmpty ?? false)){
        deleteTips();
      }
    }).onError((error, stackError) {
      setError(error.toString());
      pt(stackError);
      pt(error);
      pt('errrrrrrrrrrrr get single cart api');
      setRxRequestStatusSingleCart(Status.ERROR);
    });
  }

  refreshRestaurantSingleCartApi({required String cartId}) async {
    var data = {
      "cart_id" : cartId,
    };
    print("hccccccccccccc");
    // setRxRequestStatus(Status.LOADING);
    couponCodeController.value.clear();
    readOnly.value = true;
    api.restaurantCartGetDataApi(data).then((value) {
      singleCartSet(value);
      setRxRequestStatusSingleCart(Status.COMPLETED);
      if(singleCartDataBtn.value.cart?.cartId == null || (singleCartDataBtn.value.cart?.cartId?.isEmpty ?? false)){
        deleteTips();
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      setRxRequestStatusSingleCart(Status.ERROR);
    });
  }
//-----------------Btn api checkout
  final singleCartDataBtn = RestaurantSingleCartModel().obs;
  final rxRequestStatusSingleCartBtn = Status.COMPLETED.obs;
  void singleCartSetBtn(RestaurantSingleCartModel value) => singleCartDataBtn.value = value;
  void setRxRequestStatusSingleCartBtn(Status value) => rxRequestStatusSingleCartBtn.value = value;

  checkoutBtnApiSingleCart(context,{required String cartId}) async {
    var data = {
      "cart_id" : cartId,
    };
    Map<String, dynamic> params = {
        "key" : "checkout",
    };
    setRxRequestStatusSingleCartBtn(Status.LOADING);
    api.restaurantCartGetDataApi(data,params: params).then((value) {
      singleCartSetBtn(value);
      if(singleCartDataBtn.value.status == true) {
        setRxRequestStatusSingleCartBtn(Status.COMPLETED);
          var selectedItems = singleCartDataBtn.value.cart!.raw?.decodedAttribute!.bucket
              ?.where((item) => item.checked == "true")
              .map((item) => {
            'name': item.productName,
            'price': "\$${item.totalPrice.toString()}"
          })
              .toList();

          if (selectedItems!.isNotEmpty) {
            for (var item in selectedItems) {
              print(
                  "Selected Product: ${item['name']}, Price: ${item['price']}");
              Get.toNamed(AppRoutes.checkoutScreen, arguments: {
                'address_id': singleCartDataBtn.value.address?.id.toString(),
                'total': singleCartDataBtn.value.cart?.finalTotal.toString(),
                'coupon_id':singleCartDataBtn.value.cart?.raw?.couponId ??"",
                'regular_price': singleCartDataBtn.value.cart?.raw?.regularPrice.toString(),
                'coupon_discount': singleCartDataBtn.value.cart?.couponDiscount.toString(),
                'save_amount': singleCartDataBtn.value.cart?.raw?.saveAmount.toString(),
                'delivery_charge': singleCartDataBtn.value.cart?.deliveryCharge.toString(),
                'cart_id': singleCartDataBtn.value.cart?.raw?.id,
                'vendor_id': singleCartDataBtn.value.cart?.raw?.decodedAttribute?.vendorId,
                'cart_total': singleCartDataBtn.value.cart?.raw?.totalPrice,
                'cart_delivery': singleCartDataBtn.value.cart?.deliveryCharge,
                'wallet':singleCartDataBtn.value.wallet.toString(),
                'grandtotal_price' : singleCartDataBtn.value.cart?.finalTotal.toString(),
                'coupon_discount_payment_details': singleCartDataBtn.value.cart?.couponDiscount.toString(),
                'cartType': "restaurant",
              });
            }
          } else {
            Utils.showToast(
                "Please select product to proceed to checkout");
          }
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
                  family: AppFontFamily.gilroyMedium,
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
                      family: AppFontFamily.gilroyMedium,
                    ),
                  ),
                ),
                hBox(20.h),
              ],
            );
          },
        );
      }
      else{
        setRxRequestStatusSingleCartBtn(Status.COMPLETED);
      }
    },
    ).onError((error, stackError) {
      setError(error.toString());
      pt(stackError);
      pt(error);
      pt('errrrrrrrrrrrr get single cart api');
      setRxRequestStatusSingleCartBtn(Status.ERROR);
    });
  }



  //----- home screen
  final rxRequestStatusAllCartData = Status.LOADING.obs;
  final allResCartData = RestaurantAllCartDataModel().obs;
  void setRxRequestStatusAllCartData(Status value) => rxRequestStatusAllCartData.value = value;
  void allCartSet(RestaurantAllCartDataModel value) => allResCartData.value = value;

  getAllCartData()async{
    setRxRequestStatusAllCartData(Status.LOADING);
    api.rAllCartsRestaurant().then((value) async{
      allCartSet(value);
      if(value.status == true){
        setRxRequestStatusAllCartData(Status.COMPLETED);
        if(allResCartData.value.carts?.isEmpty ?? false){
          deleteTips();
        }
      }else if(value.status == false){
        setRxRequestStatusAllCartData(Status.COMPLETED);
        if(allResCartData.value.carts?.isEmpty ?? false){
          deleteTips();
        }
      }else{
        setRxRequestStatusAllCartData(Status.ERROR);
      }
    },).onError((error, stackError) {
      setError(error.toString());
      pt('error all res cart api >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ');
      pt(error);
      pt(stackError);
      setRxRequestStatusAllCartData(Status.ERROR);
    });

  }

  //----- Checkout all api
  final rxGetCheckoutDataStatus = Status.LOADING.obs;
  final cartCheckoutData = RestaurantCartModal().obs;
  void setRxRequestStatusCheckout(Status value) => rxGetCheckoutDataStatus.value = value;
  void allCheckoutDataSet(RestaurantCartModal value) => cartCheckoutData.value = value;

  getAllCheckoutDataRes()async{
    setRxRequestStatusCheckout(Status.LOADING);
    api.getRestaurantCheckOutApi().then((value)async {
      allCheckoutDataSet(value);
      if(value.status == true){
        setRxRequestStatusCheckout(Status.COMPLETED);
        if(cartCheckoutData.value.cart?.buckets?.isEmpty ?? false){
          deleteTips();
        }
        // cartCheckoutData.value.cart!.buckets![index].isDelivery.value = cartCheckoutData.value.cart!.buckets![index].orderType == "self" ? false : true;
      }
      else if(value.status == false){
        setRxRequestStatusCheckout(Status.COMPLETED);
        if(cartCheckoutData.value.cart?.buckets?.isEmpty ?? false){
          deleteTips();
        }
      }
      else{
        setRxRequestStatusCheckout(Status.ERROR);
      }
    },
    ).onError((error, stackError) {
      setError(error.toString());
      pt('error restaurant checkout api >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ');
      pt(error);
      pt(stackError);
      setRxRequestStatusCheckout(Status.ERROR);
    });

  }

  //checkout btn api call
  final rxGetCheckoutBtnDataStatus = Status.COMPLETED.obs;
  void setRxRequestStatusCheckoutBtn(Status value) => rxGetCheckoutBtnDataStatus.value = value;

  final cartCheckoutBtnData = RestaurantCartModal().obs;
  void allCheckoutBtnDataSet(RestaurantCartModal value) => cartCheckoutBtnData.value = value;

  Future checkoutBtnApiWithParams(context)async{
    setRxRequestStatusCheckoutBtn(Status.LOADING);
    var params = {
      "key" : "checkout",
    };
    api.getRestaurantCheckOutApi(params:params).then((value) {
      allCheckoutBtnDataSet(value);
      if(value.status == true){
        setRxRequestStatusCheckoutBtn(Status.COMPLETED);
          final vendorId = cartCheckoutBtnData.value.cart?.buckets?.map((data) => data.vendorId).toList();
          final cartId = cartCheckoutBtnData.value.cart?.buckets?.map((data) => data.cartId).toList();
          final specificTotalPrice = cartCheckoutBtnData.value.cart?.buckets?.map((data) => data.specificTotalPrice).toList();
          final specificDeliveryCharge = cartCheckoutBtnData.value.cart?.buckets?.map((data) => data.specificDeliveryCharge).toList();
          final grandTotalPrice = cartCheckoutBtnData.value.cart?.buckets?.map((data) => data.grandtotalPrice).toList();
          final couponDiscount = cartCheckoutBtnData.value.cart?.buckets?.map((data) => data.couponDiscount).toList();

          Get.toNamed(
            AppRoutes.checkoutScreen,
            arguments: {
              'address_id':cartCheckoutBtnData.value.address!.id.toString(),
              'total': cartCheckoutBtnData.value.cart!.grandTotalPrice.toString(),
              'coupon_id': cartCheckoutBtnData.value.appliedCoupon?.id.toString(),
              'regular_price': cartCheckoutBtnData.value.cart!.regularPrice.toString(),
              'coupon_discount': couponDiscount,
              'coupon_discount_payment_details': cartCheckoutBtnData.value.cart!.couponDiscount.toString(),
              'save_amount': cartCheckoutBtnData.value.cart!.saveAmount.toString(),
              'delivery_charge': cartCheckoutBtnData.value.cart!.deliveryCharge.toString(),
              'cart_id': cartId,
              'vendor_id': vendorId,
              'cart_total': specificTotalPrice,
              'cart_delivery': specificDeliveryCharge,
              'wallet': cartCheckoutBtnData.value.wallet.toString(),
              'grandtotal_price' : grandTotalPrice,
              'cartType': "restaurant",
            },
          );
      }else if(value.status == false){
        setRxRequestStatusCheckoutBtn(Status.COMPLETED);
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
                cartCheckoutBtnData.value.message?.toString() ?? "Something went wrong.",
                maxLines: 5,
                textAlign: TextAlign.center,
                style: AppFontStyle.text_16_500(
                  AppColors.darkText,
                  family: AppFontFamily.gilroyMedium,
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
                      family: AppFontFamily.gilroyMedium,
                    ),
                  ),
                ),
                hBox(20.h),
              ],
            );
          },
        );
      }else{
        setRxRequestStatusCheckoutBtn(Status.ERROR);
      }
    },).onError((error, stackError) {
      setError(error.toString());
      pt('error restaurant checkout api >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ');
      pt(error);
      pt(stackError);
      setRxRequestStatusCheckoutBtn(Status.ERROR);
    });

  }

  refreshGetAllCheckoutDataRes()async{
    // setRxRequestStatusCheckout(Status.LOADING);
    api.getRestaurantCheckOutApi().then((value)async {
      allCheckoutDataSet(value);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(value.status == true){
        setRxRequestStatusCheckout(Status.COMPLETED);
          if(cartCheckoutData.value.cart?.buckets?.isEmpty ?? false){
            deleteTips();
          }
      }else if(value.status == false){
        setRxRequestStatusCheckout(Status.COMPLETED);
        if(cartCheckoutData.value.cart?.buckets?.isEmpty ?? false){
          deleteTips();
        }
      }else{
        setRxRequestStatusCheckout(Status.ERROR);
      }
    },).onError((error, stackError) {
      setError(error.toString());
      pt('error restaurant checkout api >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> ');
      pt(error);
      pt(stackError);
      setRxRequestStatusCheckout(Status.ERROR);
    });

  }

  //----------------------Restaurant OrderType Api--------------------------------
  final rxRequestStatusOrderType = Status.COMPLETED.obs;
  void setRxRequestStatusOrderType(Status value)=>rxRequestStatusOrderType.value = value;

  final apiDataOrderType = OrderTypeModel().obs;
  void setOrderDataOrderType(OrderTypeModel value){
    apiDataOrderType.value = value;
  }
  RxInt loadingIndex = (-1).obs;
  RxString loadingType = ''.obs;

  Future<void> restaurantOrderTypeApi({required int index,required String cartId,required String type, Rx<bool>? isDelivery,bool? isSingleCartScreen})async{
    var data = {
      "cart_id": cartId,
      "type": type,
    };
    loadingIndex.value = index;
    loadingType.value = type;

    setRxRequestStatusOrderType(Status.LOADING);
    api.restaurantOrderTypeApi(data).then((value) {
      setOrderDataOrderType(value);
      if(apiDataOrderType.value.status == true){
        isSingleCartScreen == true? refreshRestaurantSingleCartApi(cartId: cartId) : refreshGetAllCheckoutDataRes();
        setRxRequestStatusOrderType(Status.COMPLETED);
        Utils.showToast(apiDataOrderType.value.message.toString().capitalize.toString());
        // loadingIndex.value = -1;
        // loadingType.value = '';
        // if(type == "self"){
        //   isDelivery?.value = false;
        // }else if(type == 'delivery'){
        //   isDelivery?.value = true;
        // }
      }else if(apiDataOrderType.value.status == false){
        setRxRequestStatusOrderType(Status.COMPLETED);
        // if(type == "self"){
        //   isDelivery?.value = true;
        // }else if(type == 'delivery'){
        //   isDelivery?.value = false;
        // }
        // loadingIndex.value = -1;
        // loadingType.value = '';
        Utils.showToast(apiDataOrderType.value.message.toString().capitalize.toString());
      }
    },).onError((error, stackTrace) {
      print("error order type Res>>>>>>>>>$error");
      print("error order type Res>>>>>>>>>$stackTrace");
      setRxRequestStatusOrderType(Status.ERROR);
      loadingIndex.value = -1;
      loadingType.value = '';
    },);
  }



}
