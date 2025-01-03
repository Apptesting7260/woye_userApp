import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/My_wallet/wallet_modal/wallet_modal.dart';

class UserWalletController extends GetxController {
  @override
  void onInit() {
    getUserWalletApi();
    super.onInit();
  }

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final userWalletData = WalletModal().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setUserWalletData(WalletModal value) {
    userWalletData.value = value;
  }

  void setError(String value) => error.value = value;

  getUserWalletApi() async {
    api.userWalletApi().then((value) {
      setUserWalletData(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('Error fetching user wallet');
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshUserWalletApi() async {
    setRxRequestStatus(Status.LOADING);
    api.userWalletApi().then((value) {
      setUserWalletData(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('Error refreshing user wallet');
      setRxRequestStatus(Status.ERROR);
    });
  }
}
