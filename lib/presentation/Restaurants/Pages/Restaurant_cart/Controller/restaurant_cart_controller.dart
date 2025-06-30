import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
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
    couponCodeController.value.clear();
    setRxRequestStatusSingleCart(Status.LOADING);
    api.restaurantCartGetDataApi(data).then((value) {
      singleCartSet(value);
      setRxRequestStatusSingleCart(Status.COMPLETED);
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
    // setRxRequestStatus(Status.LOADING);
    couponCodeController.value.clear();
    readOnly.value = true;
    api.restaurantCartGetDataApi(data).then((value) {
      singleCartSet(value);
      setRxRequestStatusSingleCart(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      setRxRequestStatusSingleCart(Status.ERROR);
    });
  }


  //----- home screen
  final rxRequestStatusAllCartData = Status.LOADING.obs;
  final allResCartData = RestaurantAllCartDataModel().obs;
  void setRxRequestStatusAllCartData(Status value) => rxRequestStatusAllCartData.value = value;
  void allCartSet(RestaurantAllCartDataModel value) => allResCartData.value = value;

  getAllCartData()async{
    setRxRequestStatusAllCartData(Status.LOADING);
    api.rAllCartsRestaurant().then((value) {
      allCartSet(value);
      if(value.status == true){
        setRxRequestStatusAllCartData(Status.COMPLETED);
      }else if(value.status == false){
        setRxRequestStatusAllCartData(Status.COMPLETED);
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
    api.getRestaurantCheckOutApi().then((value) {
      allCheckoutDataSet(value);
      if(value.status == true){
        setRxRequestStatusCheckout(Status.COMPLETED);
        // cartCheckoutData.value.cart!.buckets![index].isDelivery.value = cartCheckoutData.value.cart!.buckets![index].orderType == "self" ? false : true;
      }else if(value.status == false){
        setRxRequestStatusCheckout(Status.COMPLETED);
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

  refreshGetAllCheckoutDataRes()async{
    // setRxRequestStatusCheckout(Status.LOADING);
    api.getRestaurantCheckOutApi().then((value) {
      allCheckoutDataSet(value);
      if(value.status == true){
        setRxRequestStatusCheckout(Status.COMPLETED);
      }else if(value.status == false){
        setRxRequestStatusCheckout(Status.COMPLETED);
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

  Future<void> restaurantOrderTypeApi({required int index,required String cartId,required String type, Rx<bool>? isDelivery})async{
    if(type == "self"){
      isDelivery?.value = false;
    }else if(type == 'delivery'){
      isDelivery?.value = true;
    }

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
        if(type == "self"){
          isDelivery?.value = false;
        }else if(type == 'delivery'){
          isDelivery?.value = true;
        }
        refreshGetAllCheckoutDataRes();
        setRxRequestStatusOrderType(Status.COMPLETED);
        Utils.showToast(apiDataOrderType.value.message.toString().capitalize.toString());
        loadingIndex.value = -1;
        loadingType.value = '';
      }else if(apiDataOrderType.value.status == false){
        if(type == "self"){
          isDelivery?.value = true;
        }else if(type == 'delivery'){
          isDelivery?.value = false;
        }
        setRxRequestStatusOrderType(Status.COMPLETED);
        loadingIndex.value = -1;
        loadingType.value = '';
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
