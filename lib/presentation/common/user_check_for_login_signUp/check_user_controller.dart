import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/delete_ptoduct/delete_product_modal.dart';
import 'package:woye_user/presentation/common/user_check_for_login_signUp/check_user.dart';

class CheckUserController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final checkUser = CheckUserModal().obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setData(CheckUserModal value) => checkUser.value = value;

  Future checkUserApi({
    required bool isLoginType,
    required String phone_code,
    required String mobile,
  }) async {
    setRxRequestStatus(Status.LOADING);
    var body = {
      "phone_code": phone_code,
      "mobile": mobile,
    };
    await api.checkUserApi(body).then((value) {
      setData(value);
      if (checkUser.value.status == true) {
        setRxRequestStatus(Status.COMPLETED);
      } else {
        if(isLoginType == false && checkUser.value.message.toString() == 'User not exists'){}
        else {
          Utils.showToast(checkUser.value.message.toString());
        }
        setRxRequestStatus(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      print("Error: $error");
      setError(error.toString());
      print(stackError);
      setRxRequestStatus(Status.ERROR);
    });
  }

  // Future<bool> checkUserApi({
  //   required String country_code,
  //   required String mobile,
  // }) async {
  //   setRxRequestStatus(Status.LOADING);
  //   var body = {
  //     "country_code": country_code,
  //     "mobile": mobile,
  //   };
  //  await api.checkUserApi(body).then((value) {
  //     setData(value);
  //     if (checkUser.value.status == true) {
  //       return true;
  //     } else {
  //       Utils.showToast(checkUser.value.message.toString());
  //       setRxRequestStatus(Status.COMPLETED);
  //       return false;
  //     }
  //   }).onError((error, stackError) {
  //     print("Error: $error");
  //     setError(error.toString());
  //     print(stackError);
  //     setRxRequestStatus(Status.ERROR);
  //     return false;
  //   });
  //   return false;
  // }

  void setError(String value) => error.value = value;
}
