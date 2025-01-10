import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/ordes_list_modal/orders_list_modal.dart';

class OrderScreenController extends GetxController {
  int pageIndex = 0;

  @override
  void onInit() {
    getOrdersListApi();
    // TODO: implement onInit
    super.onInit();
  }

  void getIndex(index) {
    pageIndex = index;
    update();
  }

  final api = Repository();
  final rxRequestStatus = Status.LOADING.obs;
  final ordersData = OrdersList().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setOrders(OrdersList value) {
    ordersData.value = value;
  }

  void setError(String value) => error.value = value;

  getOrdersListApi() async {
    api.getOrderListApi().then((value) {
      setOrders(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('Error fetching orders list');
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshOrdersListApi() async {
    setRxRequestStatus(Status.LOADING);
    api.getOrderListApi().then((value) {
      setOrders(value);
      setRxRequestStatus(Status.COMPLETED);
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('Error refreshing orders list');
      setRxRequestStatus(Status.ERROR);
    });
  }
}
