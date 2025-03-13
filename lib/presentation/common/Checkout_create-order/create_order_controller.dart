import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Core/Utils/snackbar.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_modal.dart';

import '../../Pharmacy/Pages/Pharmacy_cart/prescription/prescription_controller.dart';

class CreateOrderController extends GetxController {

  @override
  void onInit() {
    walletSelected.value = false;
    isSelectable.value = false;
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onClose() {
    walletSelected.value = false;
    isSelectable.value = false;
    // TODO: implement onClose
    super.onClose();
  }
  @override
  void dispose() {
    walletSelected.value = false;
    isSelectable.value = false;
    // TODO: implement dispose
    super.dispose();
  }
  final api = Repository();
  final rxRequestStatus = Status.COMPLETED.obs;
  final createOrderData = CreateOrder().obs;
  RxInt selectedIndex = 0.obs;
  RxString error = ''.obs;
  var payAfterWallet = (0.0).obs;
  var walletDiscount = (0.0).obs;
  RxBool walletSelected = false.obs;
  var isSelectable = false.obs;
  UserModel userModel = UserModel();
  var pref = UserPreference();
  var userToken = "";

  Future<void> initializeUser() async {
    userModel = await pref.getUser();
    userToken = userModel.token!;
    print("initializeUser: Bearer ${userToken}");
  }

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void setCreateOrderData(CreateOrder value) => createOrderData.value = value;

  placeOrderApi({
    required String paymentMethod,
    required String addressId,
    required String couponId,
    required String vendorId,
    required String total,
    required String cartId,
    required String cartType,
    required List<File?> imageFiles,
  }) async {
    await initializeUser();
    setRxRequestStatus(Status.LOADING);
    String url = AppUrls.createOrder;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer $userToken';
    print("Authorization Header: Bearer ${userToken}");
    request.fields['wallet_used'] = walletSelected.value.toString();
    request.fields['wallet_amount'] = walletDiscount.value.toStringAsFixed(2);
    request.fields['payment_method'] = paymentMethod;
    request.fields['payment_amount'] = payAfterWallet.value.toStringAsFixed(2);
    request.fields['address_id'] = addressId;
    request.fields['coupon_id'] = couponId.isNotEmpty ? couponId : "";
    request.fields['vendor_id'] = vendorId;
    request.fields['total'] = total;
    request.fields['cart_id'] = cartId;
    request.fields['type'] = cartType;

    for (var imageFile in imageFiles) {
      if (imageFile?.path != null && imageFile?.path != "") {
        var pic =
            await http.MultipartFile.fromPath("drslip[]", imageFile!.path);
        print("Adding image with path: ${imageFile.path}");
        request.files.add(pic);
      }
    }

    print(request.fields);
    print(request.files);
    try {
      var response = await request.send();

      final responseData = await http.Response.fromStream(response);
      print("statusCode ${response.statusCode}");

      if (response.statusCode == 200) {
        var responseBody = responseData.body;
        var decodedData = json.decode(responseBody);
        CreateOrder data = CreateOrder.fromJson(decodedData);
        setCreateOrderData(data);

        if (createOrderData.value.status == true) {
          setRxRequestStatus(Status.COMPLETED);
          PrescriptionController prescriptionController = Get.put(PrescriptionController());
          prescriptionController.imageList = RxList<Rx<File?>>([Rx<File?>(null)]);
          Get.toNamed(AppRoutes.oderConfirm, arguments: {'type': cartType});

        } else {
          Utils.showToast(createOrderData.value.message.toString());
          print("Error: ${responseBody}");
          setRxRequestStatus(Status.COMPLETED);
        }
      } else {
        Utils.showToast("Error: ${responseData.body}");
        print("Error: ${responseData.body}");
        setRxRequestStatus(Status.COMPLETED);
      }
    } catch (e) {
      print("Error1: $e");
      setError(e.toString());
      setRxRequestStatus(Status.ERROR);
    }
  }

  void setError(String value) => error.value = value;
}
