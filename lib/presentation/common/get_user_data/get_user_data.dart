import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/get_user_data/user_data_modal.dart';

class GetUserDataController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final userData = UserResponse().obs;

  var readOnly = true.obs;

  RxString error = ''.obs;

  // Initialize GetStorage
  final storage = GetStorage();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void dataSet(UserResponse value) {
    userData.value = value;
  }

  void setError(String value) => error.value = value;

  getUserDataApi() async {
    api.getUserDataApi().then((value) {
      dataSet(value);
      setRxRequestStatus(Status.COMPLETED);
      print("type ${userData.value.user!.type.toString()}");
      saveUserDataInStorage(value);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      setRxRequestStatus(Status.ERROR);
    });
  }

  void saveUserDataInStorage(UserResponse value) {
    Map<String, dynamic> userJson = value.toJson();

    storage.write('user_data', userJson);
    print('User data saved in GetStorage');
  }
}
// import 'package:woye_user/Core/Utils/app_export.dart';
// import 'package:woye_user/presentation/common/get_user_data/user_data_modal.dart';
//
// class GetUserDataController extends GetxController {
//   final api = Repository();
//   final rxRequestStatus = Status.LOADING.obs;
//   final userData = UserResponse().obs;
//
//   var readOnly = true.obs;
//
//   RxString error = ''.obs;
//
//   void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
//
//   void dataSet(UserResponse value) {
//     userData.value = value;
//   }
//
//   void setError(String value) => error.value = value;
//
//   getUserDataApi() async {
//     api.getUserDataApi().then((value) {
//       dataSet(value);
//       setRxRequestStatus(Status.COMPLETED);
//       print("type ${userData.value.user!.type.toString()}");
//
//     }).onError((error, stackError) {
//       setError(error.toString());
//       print(stackError);
//       print('errrrrrrrrrrrr');
//       setRxRequestStatus(Status.ERROR);
//     });
//   }
// }
