import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/main.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/RestaurantCartModal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/modal/restaurant_all_cart_data_model.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class RestaurantCartController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final cartData = RestaurantCartModal().obs;

  final storage = GetStorage();

  // var cartCount = 0.obs;

  final Rx<TextEditingController> couponCodeController = TextEditingController().obs;

  // RxBool isCartScreen = false.obs;

  var readOnly = true.obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(RestaurantCartModal value) {
    cartData.value = value;
  }

  @override
  void onInit() {
    // getRestaurantCartApi(cartId: "");
    super.onInit();
  }

  void setError(String value) => error.value = value;
  // final CartController cartController = Get.put(CartController());

  getRestaurantCartApi({required String cartId}) async {
    var data = {
      "cart_id" : cartId,
    };
    readOnly.value = true;
    couponCodeController.value.clear();
    setRxRequestStatus(Status.LOADING);
    api.restaurantCartGetDataApi(data).then((value) {
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      pt(stackError);
      pt(error);
      pt('errrrrrrrrrrrr get single cart api');
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshApiSingleCart({required String cartId}) async {
    var data = {
      "cart_id" : cartId,
    };
    // setRxRequestStatus(Status.LOADING);
    couponCodeController.value.clear();
    readOnly.value = true;
    api.restaurantCartGetDataApi(data).then((value) {
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      setRxRequestStatus(Status.ERROR);
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

}
