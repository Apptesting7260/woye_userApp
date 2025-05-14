import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/ordes_list_modal/orders_list_modal.dart';

class OrderScreenController extends GetxController {
  int pageIndex = 0;
  String screenType = "";
  @override
  void onInit() {
    var arguments = Get.arguments ?? {};
    if (arguments['pageIndex'] != null && arguments['pageIndex'] is int) {
      pageIndex = arguments['pageIndex'] as int;
    }
    screenType = arguments['screenType'] ?? "";
    print("screenType : $screenType");

    // TODO: implement onInit
    super.onInit();
  }
  final ScrollController scrollController = ScrollController();
  // final List<GlobalKey> tabKeys = List.generate(4, (index) => GlobalKey());

  void getIndex(int index) {
    pageIndex = index;
    update();
    // scrollToIndex(index);
  }

  void scrollToIndex(int index) {
    double itemWidth = 120.0;
    double offset = itemWidth * index;
    if (scrollController.hasClients) {
      double maxExtent = scrollController.position.maxScrollExtent;
      if (offset > maxExtent) offset = maxExtent;
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
