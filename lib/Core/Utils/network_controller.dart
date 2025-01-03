import 'package:fluttertoast/fluttertoast.dart';
import 'package:woye_user/core/Utils/app_export.dart';

class NetworkController extends GetxController {
  bool isConnected = true;

  @override
  void onInit() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    var result = connectivityResult[0];

    if (result == ConnectivityResult.none) {
      isConnected = false;
    } else {
      isConnected = true;
    }
    isConnected != true
        ? Utils.showToast("Internet Not Connected",
            gravity: ToastGravity.TOP)
        : "";

    super.onInit();
  }
}
