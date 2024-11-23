import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Presentation/Common/Otp/model/register_model.dart';
import 'package:woye_user/Routes/app_routes.dart';

class GuestController extends GetxController {
  final rxRequestStatus = Status.COMPLETED.obs;
  final guestData = RegisterModel().obs;
  RxString error = ''.obs;
  final api = Repository();
  UserModel userModel = UserModel();
  var pref = UserPreference();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void guestSet(RegisterModel value) => guestData.value = value;

  void setError(String value) => error.value = value;

  guestUserApi() async {
    String? tokenFCM = await FirebaseMessaging.instance.getToken();

    final data = {
      "fcm_token": tokenFCM.toString(),
    };

    log(data.toString());

    setRxRequestStatus(Status.LOADING);

    api.guestUserApi(data, "").then((value) {
      Get.offAllNamed(AppRoutes.restaurantNavbar);
      setRxRequestStatus(Status.COMPLETED);
      guestSet(value);

      if (guestData.value.status == true) {
        userModel.step = guestData.value.step;
        log("Response Step: ${userModel.step}");
        userModel.token = guestData.value.token;
        log("Response token: ${userModel.token}");
        userModel.islogin = true;
        log("Response islogin: ${userModel.islogin}");
        userModel.loginType = guestData.value.loginType;
        log("Response loginType: ${userModel.loginType}");
        pref.saveUser(userModel);
        // Get.offAllNamed(AppRoutes.groceryNavbar);
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
