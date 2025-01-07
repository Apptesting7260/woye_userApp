import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/get_user_data/user_data_modal.dart';

class GetUserDataController extends GetxController {
  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final userData = UserResponse().obs;

  var readOnly = true.obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void cartSet(UserResponse value) {
    userData.value = value;
  }

  void setError(String value) => error.value = value;

  getUserDataApi() async {
    api.getUserDataApi().then((value) {
      cartSet(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      setRxRequestStatus(Status.ERROR);
    });
  }
}
