import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/My_wallet/wallet_modal/transaction_history_model.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/My_wallet/wallet_modal/wallet_modal.dart';

class UserWalletController extends GetxController {
  @override
  void onInit() {
    getUserWalletApi();
    getUserTransactionApi(isRefresh: false);
    super.onInit();
  }

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final userWalletData = UserTransactionDetails().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setUserWalletData(UserTransactionDetails value) {
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


  final userTransactionHistoryModel = UserTransactionHistoryModel().obs;
  void setTransaction(UserTransactionHistoryModel value) => userTransactionHistoryModel.value = value;

  final rxRequestStatusTransaction = Status.LOADING.obs;
  void setRxRequestStatusTransaction(Status value) => rxRequestStatusTransaction.value = value;

  getUserTransactionApi({bool? isRefresh}) async {
    if(isRefresh != true){
    setRxRequestStatusTransaction(Status.LOADING);
    }
    api.userTransactionApi().then((value) {
      setTransaction(value);
      setRxRequestStatusTransaction(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('Error fetching user wallet');
      setRxRequestStatusTransaction(Status.ERROR);
    });
  }

}
