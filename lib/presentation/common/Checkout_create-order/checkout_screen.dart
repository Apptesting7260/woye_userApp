import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/main.dart';
import 'package:woye_user/pay_stack/payment_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/grocery_cart_controller.dart';
import 'package:woye_user/presentation/common/Checkout_create-order/create_order_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Payment_method/View/payment_method_screen.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';
import '../../../shared/widgets/format_price.dart';
import '../../Pharmacy/Pages/Pharmacy_cart/Controller/pharma_cart_controller.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // static DeliveryAddressScreen deliveryAddressScreen = DeliveryAddressScreen();
  final CreateOrderController controller = Get.put(CreateOrderController());

  final GroceryCartController groceryCartController = Get.put(GroceryCartController());

  final PharmacyCartController pharmacyCartController = Get.put(PharmacyCartController());

  final PayStackController payStackController = Get.put(PayStackController());

  final GetUserDataController getUserDataController = Get.put(GetUserDataController());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments ?? {};
    print("arguments:: $arguments");
    controller.addressId.value = arguments['address_id'] ?? '';
    controller.couponId = arguments['coupon_id'] ?? '';
    controller.vendorId = arguments['vendor_id'] ?? '';
    controller.couponDiscountPaymentDetails.value = arguments['coupon_discount_payment_details'] ?? ''; // for ui
    controller.grandTotalPrice = arguments['grandtotal_price'] ?? '';
    // var totalPrice = arguments['total'] ?? '';
    // print("Total price : ${arguments['total']}");
    // var formattedTotal = arguments['total'] ?? "0.00";
    // print("tota; procellknb $formattedTotal");
    // var total = double.tryParse(formattedTotal)?.toStringAsFixed(2) ?? "0.00";
    // print("tota; procellknb $total");
    controller.formattedTotal.value = arguments['total'] ?? "0.00";
   controller.formattedTotal.value = controller.formattedTotal.value.replaceAll(',', '');
    print("Total after removing commas: ${controller.formattedTotal}");
    controller.total.value = double.tryParse(controller.formattedTotal.value)?.toStringAsFixed(2) ?? "0.00";
    print("Total price: ${controller.total.value}");
    controller.cartId = arguments['cart_id'] ?? "";
    controller.regularPrice.value = arguments['regular_price'] ?? "";
    controller.saveAmount.value = arguments['save_amount'] ?? "";
    controller.deliveryCharge.value = arguments['delivery_charge'] ?? "";
    controller.couponDiscount = arguments['coupon_discount'] ?? "";
    controller.cartType.value = arguments['cartType'] ?? "";
    controller.walletBalance.value = arguments['wallet'] ?? "";
    controller.prescription = arguments['prescription'] ?? [];
    controller.cartTotal = arguments['cart_total'] ?? [];
    controller.cartDelivery = arguments['cart_delivery'] ?? [];
    // var imagePath = arguments['imagePath'] ?? "";
    // File? imageFile;
    List<String> imagePaths = List<String>.from(arguments['imagePath'] ?? []);


    // Convert the paths to File objects
    List<File?> imageFiles = imagePaths.map((path) => File(path)).toList();

    // Optionally, if you want to use a reactive list of Rx<File?>:
    RxList<Rx<File?>> reactiveImageFiles = RxList<Rx<File?>>(
      imageFiles.map((file) => Rx<File?>(file)).toList(),
    );

    // if (imagePath is String && imagePath.isNotEmpty) {
    //   imageFile = File(imagePath); // Convert file path string to File
    // } else if (imagePath is File) {
    //   imageFile = imagePath; // If it's already a File object
    // }
    //
    // if (imageFile != null) {
    //   // Now you can use `imageFile` in your multipart request for image upload
    //   print("Image file path: ${imageFile.path}");
    // } else {
    //   print("No image provided");
    // }
    // grocery arguments


    print("Address ID: ${controller.addressId.value}");
    print("Coupon ID: ${controller.couponId}");
    print("Vendor Id: ${controller.vendorId}");
    print("Total: ${controller.total.value}");
    print("Cart ID: ${controller.cartId}");
    print("Regular Price: ${controller.regularPrice.value}");
    print("Save Amount: ${controller.saveAmount.value}");
    print("Delivery Charge: ${controller.deliveryCharge.value}");
    print("Coupon Discount: ${controller.couponDiscount}");
    print("Coupon Discount Payment Details: ${controller.couponDiscountPaymentDetails.value}");
    print("wallet: ${controller.walletBalance.value}");
    print("Image Paths: $imagePaths");
    print("cartTotal: ${controller.cartTotal}");
    print("cartDelivery: ${controller.cartDelivery}");
    print("cartType: ${controller.cartType.value}");
    print("prescription: ${controller.prescription}");
    print("grandTotalPrice: ${controller.grandTotalPrice}");

// Optionally, print the list of image files (paths converted to File objects)
    for (var imageFile in imageFiles) {
      print("Image File: ${imageFile?.path ?? 'No file found'}");
    }

    print("Reactive Image Files: $reactiveImageFiles");

    WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.payAfterWallet.value = double.parse(controller.total.value.toString());

    if(controller.walletBalance.value != '' && controller.total.value != '' ){
    controller.walletSelected.value = double.parse(controller.walletBalance.value.replaceAll(",","")) < double.parse(controller.total.value.replaceAll(",","")) ?  false : true;
    controller.isSelectable.value = double.parse(controller.walletBalance.value.replaceAll(",","")) < double.parse(controller.total.value.replaceAll(",","")) ? false : true;
    }
    controller.selectedIndex.value = -1;
    print("Updated payAfterWallet 1: ${controller.payAfterWallet.value.toStringAsFixed(2)}");
    print("Updated payAfterWallet 1: ${controller.selectedIndex.value}");
    controller.tipsController.value.clear();
    controller.enteredTips.value = "0";
    controller.selectedTipsIndexValue.value = -1;
    controller.updateBalanceAfterTips(totalPrice: controller.total.value,walletBalance: controller.walletBalance.value,loadFromPrefs: true);
    controller.tipsController.value.clear();
    controller.deliveryNotesController.value.clear();
    controller.isDeliveryAsSoonAsPossible.value = false;
    controller.isDeliveryNotes.value = false;
    controller.isDeliveryAsSoonAsPossiblePopUp.value = false;
    controller.isDeliveryAsSoonAsPossible.value = false;
    controller.scheduleDeliveryController.value.clear();
    controller.pickedTimeVal.value = "";
    controller.formattedTime.value = "";
    },);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          isLeading: true,
          title: Text(
            "Checkout",
            style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
          ),
        ),
        body: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              paymentMethod(walletBalance: controller.walletBalance.value, totalPrice: controller.total.value),
              hBox(15.h),
              deliveryNotes(context),
              hBox(15.h),
              deliveryAsSoonAsPossible(context),
              hBox(33.h),
              tips(controller.total.value,controller.walletBalance.value),
              hBox(30.h),
              paymentDetails(
                deliveryCharge: controller.deliveryCharge.value,
                regularPrice: controller.regularPrice.value,
                saveAmount: controller.saveAmount.value,
                couponDiscount: controller.couponDiscountPaymentDetails.value,
                totalPrice: controller.total.value,
                walletBalance: controller.walletBalance.value,
              ),
              hBox(30.h),
              Obx(
                () => CustomElevatedButton(
                fontFamily: AppFontFamily.gilroyMedium,
                  isLoading: (
                        controller.rxRequestStatus.value == Status.LOADING)
                    || groceryCartController.rxCreateOrderRequestStatus.value == Status.LOADING
                    || pharmacyCartController.rxRequestStatusCreateOrder.value == Status.LOADING
                   /* || controller.rxGetCheckoutBtnDataStatus.value == Status.LOADING*/,
                  onPressed: () {
                    print("controller.selectedIndex.value : ${controller.selectedIndex.value}");
                    if(!controller.isSelectable.value &&  controller.selectedIndex.value == 0 ||
                        !controller.isSelectable.value &&  controller.selectedIndex.value == -1 ||
                        controller.isSelectable.value && controller.totalPriceIncludingTips.value >
                            double.parse(controller.walletBalance.value.toString().replaceAll(',', ''))
                    // controller.totalPriceIncludingTips.value > double.parse(walletBalance.toString())
                    ) {
                      Utils.showToast("Payment method not available");
                    }
                    else{
                      // if (cartType == 'restaurant') {
                      //   controller.placeOrderApi(
                      //       addressId: addressId,
                      //       cartId: cartId,
                      //       vendorId: vendorId,
                      //       couponId: couponId,
                      //       paymentMethod: controller.isSelectable.value == true
                      //           ? "wallet"
                      //           : controller.selectedIndex.value == 1
                      //           ? "credit_card"
                      //           :controller.selectedIndex.value == 2
                      //           ? "cash_on_delivery"
                      //           : "",
                      //       total: total,
                      //       cartType: cartType,
                      //       imageFiles: imageFiles,
                      //   );
                      // }

//-------------------------------------------restaurant------------------------------------------

                      if (controller.cartType.value == 'restaurant') {

                            List<Map<String, dynamic>> carts = [];

                            print("vendorId type :: ${controller.vendorId.runtimeType}");
                            if (controller.vendorId.runtimeType != String) {
                              for (int i = 0; i < controller.vendorId.length; i++) {
                                carts.add({
                                  "vendor_id": arguments['vendor_id'][i],
                                  "cart_id": arguments['cart_id'][i],
                                  "cart_total": arguments['cart_total'][i],
                                  "cart_delivery": arguments['cart_delivery'][i],
                                  "coupon_discount": arguments['coupon_discount'][i],
                                  "grandtotal_price": arguments['grandtotal_price'][i],
                                },
                                );
                              }
                            } else {
                              carts.add({
                                "vendor_id": arguments['vendor_id'].toString(),
                                "cart_id": arguments['cart_id'].toString(),
                                "cart_total": arguments['cart_total']
                                    .toString(),
                                "cart_delivery": arguments['cart_delivery']
                                    .toString(),
                                "coupon_discount": arguments['coupon_discount']
                                    .toString(),
                                "grandtotal_price": arguments['grandtotal_price']
                                    .toString(),
                              },
                              );
                            }


                            List<String> cartIDs = [];
                            if (controller.vendorId.runtimeType != String) {
                              for (int i = 0; i < controller.cartId.length; i++) {
                                cartIDs.add(arguments['cart_id'][i].toString());
                              }
                            } else {
                              cartIDs.add(arguments['cart_id'].toString());
                            }
                            if (controller.selectedIndex.value == 1) {
                              payStackController.makePayment(context: context,
                                email: getUserDataController.userData.value.user?.email ?? "",
                                addressId: controller.addressId.value,couponId: controller.couponId,
                                total: controller.newTotalIncludingTips.value.toString(),cartIds: cartIDs,
                                cartType: controller.cartType.value,carts: carts,);
                              debugPrint("controller.selectedIndex.value  ${controller.selectedIndex.value }");
                            }
                            else {
                              final String paymentAmount = controller.walletSelected.value
                                  ? controller.newPayAfterWallet.value.toStringAsFixed(2)
                                  : controller.newTotalIncludingTips.value.toStringAsFixed(2);

                              controller.createOrderRestaurant(
                                walletUsed: controller.walletSelected.value,
                                walletAmount: controller.walletDiscount.value
                                    .toStringAsFixed(2),
                                paymentMethod: controller.isSelectable.value ==
                                    true
                                    ? "wallet" : controller.selectedIndex
                                    .value == 1 ? "credit_card" : controller
                                    .selectedIndex.value == 2
                                    ? "cash_on_delivery" : "",
                                // paymentAmount: controller.payAfterWallet.value.toStringAsFixed(2),
                                paymentAmount: controller.walletSelected.value
                                    ? paymentAmount
                                    : controller.newTotalIncludingTips.value.toString(),
                                // paymentAmount: controller.walletSelected.value ? controller.newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total,
                                addressId: controller.addressId.value,
                                couponId: controller.couponId,
                                total: controller.newTotalIncludingTips.value.toString()/* controller.total.value*/,
                                cartIds: cartIDs,
                                type: controller.cartType.value,
                                carts: carts,
                                deliveryNotes: controller
                                    .deliveryNotesController.value.text,
                                deliverySoon: controller.isDeliveryAsSoonAsPossible.value == true &&
                                    controller.isDeliveryAsSoonAsPossiblePopUp.value == true ? "as soon as possible"
                                    : controller.isDeliveryAsSoonAsPossible.value == true &&controller.pickedTimeVal.value != ''
                                    ? controller.pickedTimeVal.value: "",
                                courierTip: controller.selectedTipsIndexValue.value == 0 ? "5" :
                                controller.selectedTipsIndexValue.value == 1 ? "10":
                                controller.selectedTipsIndexValue.value == 2 ? "15":
                                controller.selectedTipsIndexValue.value == 3? controller.tipsController.value.text: "",
                              );
                              debugPrint("controller.selectedIndex.value  ${controller.selectedIndex.value }");
                            }

                      }

//-------------------------------------------grocery------------------------------------------
                      if (controller.cartType.value == 'grocery') {
                        List<Map<String, dynamic>> carts = [];

                        print("vendorId type :: ${controller.vendorId.runtimeType}");
                        if (controller.vendorId.runtimeType != String) {
                          for (int i = 0; i < controller.vendorId.length; i++) {
                            carts.add({
                              "vendor_id": arguments['vendor_id'][i],
                              "cart_id": arguments['cart_id'][i],
                              "cart_total": arguments['cart_total'][i],
                              "cart_delivery": arguments['cart_delivery'][i],
                              "coupon_discount": arguments['coupon_discount'][i],
                              "grandtotal_price": arguments['grandtotal_price'][i],
                            },
                            );
                          }
                        } else {
                          carts.add({
                            "vendor_id": arguments['vendor_id'].toString(),
                            "cart_id": arguments['cart_id'].toString(),
                            "cart_total": arguments['cart_total'].toString(),
                            "cart_delivery": arguments['cart_delivery'].toString(),
                            "coupon_discount": arguments['coupon_discount'].toString(),
                            "grandtotal_price": arguments['grandtotal_price'].toString(),
                          },
                          );
                        }


                        List<String> cartIDs = [];
                        if (controller.vendorId.runtimeType != String) {
                          for (int i = 0; i < controller.cartId.length; i++) {
                            cartIDs.add(arguments['cart_id'][i].toString());
                          }
                        } else {
                          cartIDs.add(arguments['cart_id'].toString());
                        }

                        if(controller.selectedIndex.value == 1){
                          final String paymentAmount = controller.walletSelected.value
                              ? controller.newPayAfterWallet.value.toStringAsFixed(2) // 💵 after wallet
                              : controller.newTotalIncludingTips.value.toStringAsFixed(2);
                         payStackController.makePayment(context: context,email:  getUserDataController.userData.value.user?.email ?? "", addressId: controller.addressId.value,
                            couponId: controller.couponId, total: paymentAmount/* controller.newTotalIncludingTips.value.toString()*/, cartIds: cartIDs, cartType: controller.cartType.value, carts: carts,);
                          debugPrint("controller.selectedIndex.value  ${controller.selectedIndex.value }");
                        }
                        else{
                          final String paymentAmount = controller.walletSelected.value
                              ? controller.newPayAfterWallet.value.toStringAsFixed(2)
                              : controller.newTotalIncludingTips.value.toStringAsFixed(2);
                          groceryCartController.createOrderGrocery(
                            walletUsed: controller.walletSelected.value,
                            walletAmount: controller.walletDiscount.value.toStringAsFixed(2),
                            paymentMethod: controller.isSelectable.value == true
                                ? "wallet" : controller.selectedIndex.value == 1 ?
                            "credit_card" : controller.selectedIndex.value == 2
                                ? "cash_on_delivery" : "",
                            // paymentAmount: controller.payAfterWallet.value.toStringAsFixed(2),
                            paymentAmount: controller.walletSelected.value ?paymentAmount : controller.total.value,
                            // paymentAmount: controller.walletSelected.value ? controller.newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total,
                            addressId: controller.addressId.value,
                            couponId: controller.couponId,
                            total: controller.newTotalIncludingTips.value.toString()/* controller.total.value*/,
                            cartIds: cartIDs,
                            type: controller.cartType.value,
                            carts: carts,
                            deliveryNotes: controller.deliveryNotesController.value.text,
                            deliverySoon:  controller.isDeliveryAsSoonAsPossible.value == true && controller.isDeliveryAsSoonAsPossiblePopUp.value == true ? "as soon as possible"
                                : controller.isDeliveryAsSoonAsPossible.value == true && controller.pickedTimeVal.value != '' ? controller.pickedTimeVal.value : "",
                            courierTip: controller.selectedTipsIndexValue.value == 0 ? "5" :
                            controller.selectedTipsIndexValue.value == 1 ? "10" :
                            controller.selectedTipsIndexValue.value == 2 ? "15" :
                            controller.selectedTipsIndexValue.value == 3 ? controller.tipsController.value.text : "",
                          );
                          debugPrint("controller.selectedIndex.value  ${controller.selectedIndex.value }");
                        }

                      }

//-------------------------------------------pharmacy------------------------------------------
/*                      if (cartType == 'pharmacy') {
                        List<String> cartIDs = [];
                        if (vendorId.runtimeType != String) {
                          for (int i = 0; i < cartId.length; i++) {
                            cartIDs.add(arguments['cart_id'][i].toString());
                          }
                        } else {
                          cartIDs.add(arguments['cart_id'].toString());
                        }

                        List<Map<String, dynamic>> carts = [];

                        print("vendorId type :: ${vendorId.runtimeType}");
                        if (vendorId.runtimeType != String) {
                          for (int i = 0; i < vendorId.length; i++) {
                            carts.add({
                              "vendor_id": arguments['vendor_id'][i],
                              "cart_id": arguments['cart_id'][i],
                              "cart_total": arguments['cart_total'][i],
                              "cart_delivery": arguments['cart_delivery'][i],
                              "coupon_discount": arguments['coupon_discount'][i],
                              "grandtotal_price": arguments['grandtotal_price'][i],
                            },
                            );
                          }
                        } else {
                          carts.add({
                            "vendor_id": arguments['vendor_id'].toString(),
                            "cart_id": arguments['cart_id'].toString(),
                            "cart_total": arguments['cart_total'].toString(),
                            "cart_delivery": arguments['cart_delivery'].toString(),
                            "coupon_discount": arguments['coupon_discount'].toString(),
                            "grandtotal_price": arguments['grandtotal_price'].toString(),
                          },
                          );
                        }

                        if(controller.selectedIndex.value == 1){
                          final String paymentAmount = controller.walletSelected.value
                              ? controller.newPayAfterWallet.value.toStringAsFixed(2) // 💵 after wallet
                              : controller.newTotalIncludingTips.value.toStringAsFixed(2);
                          pt("object>>>>>>>>>>> ${controller.newTotalIncludingTips.value}");
                          payStackController.makePayment(context: context,email:  getUserDataController.userData.value.user?.email ?? "", addressId: addressId,
                            couponId: couponId, total: paymentAmount, cartIds: cartIDs, cartType: cartType, carts: carts,);
                          debugPrint("controller.selectedIndex.value  ${controller.selectedIndex.value }");
                        }
                        else{
                          pt("object>>>>>>>>>>> ${controller.newTotalIncludingTips.value}");
                          final String paymentAmount = controller.walletSelected.value
                              ? controller.newPayAfterWallet.value.toStringAsFixed(2) // 💵 after wallet
                              : controller.newTotalIncludingTips.value.toStringAsFixed(2); // 💵 full amount

                          pharmacyCartController.pharmacyCreateOrder(
                            isWalletUsed: controller.walletSelected.value,
                            walletAmount: controller.walletDiscount.value
                                .toStringAsFixed(2),
                            paymentMethod: controller.isSelectable.value == true
                                ? "wallet"
                                : controller.selectedIndex.value == 1 ?
                            "credit_card" : controller.selectedIndex.value == 2
                                ? "cash_on_delivery"
                                : "",
                            paymentAmount: controller.walletSelected.value ?paymentAmount : total,
                            // paymentAmount: controller.walletSelected.value ? controller.newTotalWithoutIncludingTips.value.toStringAsFixed(2) : total,
                            // paymentAmount: controller.payAfterWallet.value.toStringAsFixed(2),
                            addressId: addressId.toString(),
                            couponId: couponId.toString(),
                            totalAmount: total.toString(),
                            cartIds: cartIDs,
                            carts: carts,
                            prescription: prescription,
                            deliveryNotes: controller.deliveryNotesController.value.text,
                            deliverySoon:  controller.isDeliveryAsSoonAsPossible.value == true && controller.isDeliveryAsSoonAsPossiblePopUp.value == true ? "as soon as possible"
                                : controller.isDeliveryAsSoonAsPossible.value == true && controller.pickedTimeVal.value != '' ? controller.pickedTimeVal.value : "",
                            courierTip: controller.selectedTipsIndexValue.value == 0 ? "5" :
                            controller.selectedTipsIndexValue.value == 1 ? "10" :
                            controller.selectedTipsIndexValue.value == 2 ? "15" :
                            controller.selectedTipsIndexValue.value == 3 ? controller.tipsController.value.text : "",
                          );
                          debugPrint("controller.selectedIndex.value  ${controller.selectedIndex.value }");
                        }


                      }*/

                      if (controller.cartType.value == 'pharmacy') {
                        List<String> cartIDs = [];

                        final cartIdList = arguments['cart_id'];
                        final vendorIdList = arguments['vendor_id'];
                        final cartTotalList = arguments['cart_total'];
                        final cartDeliveryList = arguments['cart_delivery'];
                        final couponDiscountList = arguments['coupon_discount'];
                        final grandTotalList = arguments['grandtotal_price'];

                        // Prepare cart IDs
                        if (cartIdList != null && cartIdList is List) {
                          for (int i = 0; i < cartIdList.length; i++) {
                            cartIDs.add(cartIdList[i]?.toString() ?? '');
                          }
                        } else if (arguments['cart_id'] != null) {
                          cartIDs.add(arguments['cart_id'].toString());
                        }

                        List<Map<String, dynamic>> carts = [];

                        print("vendorId type :: ${controller.vendorId.runtimeType}");

                        if (vendorIdList != null &&
                            vendorIdList is List &&
                            cartIdList is List &&
                            cartTotalList is List &&
                            cartDeliveryList is List &&
                            couponDiscountList is List &&
                            grandTotalList is List) {
                          for (int i = 0; i < vendorIdList.length; i++) {
                            carts.add({
                              "vendor_id": vendorIdList[i]?.toString() ?? "",
                              "cart_id": cartIdList.length > i ? cartIdList[i]?.toString() ?? "" : "",
                              "cart_total": cartTotalList.length > i ? cartTotalList[i]?.toString() ?? "" : "",
                              "cart_delivery": cartDeliveryList.length > i ? cartDeliveryList[i]?.toString() ?? "" : "",
                              "coupon_discount": couponDiscountList.length > i ? couponDiscountList[i]?.toString() ?? "" : "",
                              "grandtotal_price": grandTotalList.length > i ? grandTotalList[i]?.toString() ?? "" : "",
                            });
                          }
                        } else {
                          carts.add({
                            "vendor_id": arguments['vendor_id']?.toString() ?? "",
                            "cart_id": arguments['cart_id']?.toString() ?? "",
                            "cart_total": arguments['cart_total']?.toString() ?? "",
                            "cart_delivery": arguments['cart_delivery']?.toString() ?? "",
                            "coupon_discount": arguments['coupon_discount']?.toString() ?? "",
                            "grandtotal_price": arguments['grandtotal_price']?.toString() ?? "",
                          });
                        }

                        final String paymentAmount = controller.walletSelected.value
                            ? controller.newPayAfterWallet.value.toStringAsFixed(2)
                            : controller.newTotalIncludingTips.value.toStringAsFixed(2);

                        if (controller.selectedIndex.value == 1) {
                          payStackController.makePayment(
                            context: context,
                            email: getUserDataController.userData.value.user?.email ?? "",
                            addressId: controller.addressId.value,
                            couponId: controller.couponId,
                            total: paymentAmount,
                            cartIds: cartIDs,
                            cartType: controller.cartType.value,
                            carts: carts,
                          );
                          debugPrint("controller.selectedIndex.value  ${controller.selectedIndex.value}");
                        } else {
                          final String paymentAmount = controller.walletSelected.value
                              ? controller.newPayAfterWallet.value.toStringAsFixed(2)
                              : controller.newTotalIncludingTips.value.toStringAsFixed(2);
                          pharmacyCartController.pharmacyCreateOrder(
                            isWalletUsed: controller.walletSelected.value,
                            walletAmount: controller.walletDiscount.value.toStringAsFixed(2),
                            paymentMethod: controller.isSelectable.value == true
                                ? "wallet"
                                : controller.selectedIndex.value == 1
                                ? "credit_card"
                                : controller.selectedIndex.value == 2
                                ? "cash_on_delivery"
                                : "",
                            // paymentAmount: controller.walletSelected.value
                            //     ? paymentAmount
                            //     : controller.total.value,
                            paymentAmount: paymentAmount,
                            addressId: controller.addressId.value.toString(),
                            couponId: controller.couponId.toString(),
                            totalAmount: controller.newTotalIncludingTips.value.toString() /*controller.total.value.toString()*/,
                            cartIds: cartIDs,
                            carts: carts,
                            prescription: controller.prescription,
                            deliveryNotes: controller.deliveryNotesController.value.text,
                            deliverySoon: controller.isDeliveryAsSoonAsPossible.value == true &&
                                controller.isDeliveryAsSoonAsPossiblePopUp.value == true
                                ? "as soon as possible"
                                : controller.isDeliveryAsSoonAsPossible.value == true &&
                                controller.pickedTimeVal.value != ''
                                ? controller.pickedTimeVal.value
                                : "",
                            courierTip: controller.selectedTipsIndexValue.value == 0
                                ? "5"
                                : controller.selectedTipsIndexValue.value == 1
                                ? "10"
                                : controller.selectedTipsIndexValue.value == 2
                                ? "15"
                                : controller.tipsController.value.text,
                          );
                          debugPrint("controller.selectedIndex.value  ${controller.selectedIndex.value}");
                        }
                      }
                    }
                  },
                  text: controller.isSelectable.value == true
                      ? "Place Order"
                      : controller.selectedIndex.value == 2
                          ? controller.walletSelected.value == false
                              ? "\$${formatPrice(controller.newTotalIncludingTips.value.toStringAsFixed(2))} Order with COD"
                              // ? "\$${formatPrice(controller.totalPriceIncludingTips.value.toString())} Order with COD"
                              // ? "\$${formatPrice(total)} Order with COD"
                              : "\$${controller.newPayAfterWallet.value.toStringAsFixed(2)} Order with COD"
                          : controller.selectedIndex.value == 1
                              ? controller.walletSelected.value == false
                                  ? "\$${formatPrice(controller.newTotalIncludingTips.value.toStringAsFixed(2))} Pay with Card"
                                  // ? "\$${formatPrice(total)} Pay with Card"
                                  : "\$${controller.newPayAfterWallet.value.toStringAsFixed(2)} Pay with Card"
                              : "Place Order",
                ),
              ),
              hBox(50.h)
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentDetails({
    regularPrice,
    saveAmount,
    deliveryCharge,
    couponDiscount,
    totalPrice,
    walletBalance,
  }) {
    return Obx(
          () {return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Details",
            style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
          ),
          hBox(20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Regular Price",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              ),
              Text(
                regularPrice != ""
                    ? "\$$regularPrice"
                    : "\$0.00",
                style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ],
          ),
          hBox(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Save Amount",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              ),
              Text(
                saveAmount != ""
                    ? "\$$saveAmount"
                    : "\$0.00",
                style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ],
          ),
          hBox(couponDiscount != "0.00" && couponDiscount.toString().trim() != "" ? 10.h : 0.h),
          couponDiscount != "0.00" && couponDiscount.toString().trim() != ""
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Coupon Discount",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              ),
              Text(
                couponDiscount != ""
                    ? "-\$$couponDiscount"
                    : "-\$0.00",
                style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ],
          )
              : SizedBox(
            height: 0.h,
          ),
          hBox(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Charge",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              ),
              Text(
                "\$${deliveryCharge ?? '0.00'}" ,
                style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ],
          ),
          hBox(10.h),
          if(controller.selectedTipsIndexValue.value >= 0)...[
            Obx(
                  ()=> Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Courier Tips",
                    style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                  ),
                  Text(
                    controller.selectedTipsIndexValue.value == 0 ? "\$5" :
                    controller.selectedTipsIndexValue.value == 1 ? "\$10" :
                    controller.selectedTipsIndexValue.value == 2 ? "\$15" :
                    controller.selectedTipsIndexValue.value == 3 ? "\$${controller.tipsController.value.text}": "",
                    style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                  ),
                ],
              ),
            ),
            hBox(10.h),
          ],
          hBox(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Price",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              Text(
                formatPrice(controller.newTotalIncludingTips.value.toString()),
                // formatPrice(controller.newPayAfterWallet.value.toString()),
                // formatPrice(controller.totalPriceIncludingTips.value.toString()),
                // formatPrice(totalPrice.toString()),
                style: AppFontStyle.text_20_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
              ),
            ],
          ),
        ],
      );
      },
    );
  }

  Widget wallet({required String walletBalance, required String totalPrice}) {
    return Obx(() {
      final double walletBalanceDouble = double.tryParse(walletBalance.replaceAll(",", "")) ?? 0.0;
      final double totalWithTips = controller.totalPriceIncludingTips.value;

      final bool isWalletSelected = controller.walletSelected.value;

      return IgnorePointer(
        ignoring: walletBalanceDouble <= 0.0,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (walletBalanceDouble > 0.0) {
              // Toggle wallet selection
              controller.walletSelected.value = !isWalletSelected;

              final bool nowSelected = controller.walletSelected.value;

              if (nowSelected) {
                if (walletBalanceDouble >= totalWithTips) {
                  // ✅ Wallet fully covers → select wallet only
                  controller.selectedIndex.value = 0;
                  controller.isSelectable.value = true;
                } else {
                  // ✅ Wallet partially covers → do NOT touch selectedIndex
                  controller.isSelectable.value = false;
                }
              } else {
                // ❌ Wallet turned off
                controller.isSelectable.value = false;

                // ✅ Remove wallet-only selection if it was previously selected
                if (controller.selectedIndex.value == 0) {
                  controller.selectedIndex.value = -1; // No method selected
                }
              }

              // Recalculate after wallet toggle
              controller.updateBalanceAfterTips(
                totalPrice: totalPrice,
                walletBalance: walletBalance,
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(
                color: controller.walletSelected.value
                    ? AppColors.primary
                    : AppColors.lightPrimary,
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset("assets/svg/wallet.svg"),
                wBox(10),
                Text(
                  "My Wallet (\$$walletBalance)",
                  style: AppFontStyle.text_16_400(AppColors.darkText,
                      family: AppFontFamily.gilroyMedium),
                ),
                const Spacer(),
                Container(
                  margin: EdgeInsets.only(top: 5.r),
                  height: 20.h,
                  width: 20.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: controller.selectedIndex.value == 0 || controller.walletSelected.value
                      ? SvgPicture.asset("assets/svg/green-check-circle.svg")
                      : null,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget methodList({required String walletBalance, required String totalPrice}) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              bool isSelected = controller.selectedIndex.value == index;

              if (index == 0) return const SizedBox.shrink();

              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  final double walletBalanceDouble =
                      double.tryParse(walletBalance.replaceAll(",", "")) ?? 0.0;
                  final double totalWithTips = controller.totalPriceIncludingTips.value;

                  // ✅ If wallet is selected and covers total, unselect it
                  if (controller.walletSelected.value &&
                      walletBalanceDouble >= totalWithTips) {
                    controller.walletSelected.value = false;
                    controller.isSelectable.value = false;
                  }

                  // ✅ Update selected method (card or cod)
                  controller.selectedIndex.value = index;
                  controller.update();

                  // 🔁 Update balance display
                  controller.updateBalanceAfterTips(
                    totalPrice: totalPrice,
                    walletBalance: walletBalance,
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.r,
                      vertical: index == 1 ? 17.r : 20.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.lightPrimary,
                    ),
                  ),
                  child: Row(
                    children: [
                      if (index == 1) ...[
                        SvgPicture.asset("assets/svg/payment_card.svg"),
                        wBox(10.h),
                        Text(
                          "Pay With Card",
                          style: AppFontStyle.text_16_400(
                            AppColors.darkText,
                            height: 1.h,
                            family: AppFontFamily.gilroyMedium,
                          ),
                        ),
                      ] else if (index == 2) ...[
                        Text(
                          "Cash On Delivery",
                          style: AppFontStyle.text_16_400(
                            AppColors.darkText,
                            family: AppFontFamily.gilroyMedium,
                          ),
                        ),
                      ],
                      const Spacer(),
                      Container(
                        margin: index == 1 ? EdgeInsets.only(top: 5.r) : null,
                        height: 20.h,
                        width: 20.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: isSelected
                            ? SvgPicture.asset("assets/svg/green-check-circle.svg")
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (c, i) => hBox(15.h),
        );
      },
    );
  }

  Widget paymentMethod({required String walletBalance, required String totalPrice}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.initializeWallet(walletBalance, totalPrice);
      controller.updateBalanceAfterTips(totalPrice: totalPrice,walletBalance: walletBalance);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Method",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(15.h),
        wallet(walletBalance: walletBalance, totalPrice: totalPrice),
        hBox(15.h),
        methodList(walletBalance: walletBalance, totalPrice: totalPrice),
        hBox(15.h),
        // addNewCard(),
      ],
    );
  }

  Widget addNewCard() {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Get.toNamed(AppRoutes.addCard);
      },
      child: Container(
        padding: REdgeInsetsDirectional.all(15),
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.primary)),
        child: Row(
          children: [
            SvgPicture.asset("assets/svg/payment_card.svg"),
            wBox(10),
            Text(
              "Add New Card",
              style: AppFontStyle.text_16_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
            ),
            const Spacer(),
             Icon(Icons.arrow_forward_ios_sharp,color: AppColors.darkText,size: 21,)
          ],
        ),
      ),
    );

    // Container(
    //   padding: REdgeInsetsDirectional.all(15),
    //   height: 60.h,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20.r),
    //       border: Border.all(color: AppColors.primary)),
    //   child: Row(
    //     children: [
    //       SvgPicture.asset("assets/svg/pin_location.svg"),
    //       wBox(10),
    //       Text(
    //         "Add Address",
    //         style: AppFontStyle.text_16_400(AppColors.primary),
    //       ),
    //       Spacer(),
    //       Icon(
    //         Icons.arrow_forward_ios_sharp,
    //         size: 20.h,
    //       )
    //     ],
    //   ),
    // );
  }

  Widget deliveryNotes(context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        showDialog(context: context,
          barrierDismissible: false,
          builder: (context) {
            return PopScope(
              canPop: false,
              child: Stack(
                children: [
                  AlertDialog(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      contentPadding: EdgeInsets.zero,
                      backgroundColor: AppColors.white,
                      content: Stack(children: [
                        deliveryNotesTextFields(context,),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: IconButton(
                              onPressed: () {
                            Get.back();
                            controller.deliveryNotesController.value.clear();
                            controller.isDeliveryNotes.value = false;
                          },
                          icon: Icon(Icons.cancel,
                            color: AppColors.primary,
                            size: 26,),
                          ),
                        ),
                      ])
                  ),

                ],
              ),
            );
          },);
        },
      child: Obx(
        ()=> Container(
          padding: REdgeInsetsDirectional.all(15),
          height: 60.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: controller.isDeliveryNotes.value ? AppColors.primary : AppColors.ultraLightPrimary)),
          child: Row(
            children: [
              SvgPicture.asset(ImageConstants.deliveryNotes),
              wBox(10),
              Text(
                controller.isDeliveryNotes.value ? "Delivery notes added" :  "Add Delivery Notes",
                style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
              ),
              const Spacer(),
              Icon(Icons.add,color: AppColors.darkText,size: 23,)
            ],
          ),
        ),
      ),
    );
  }

  Widget deliveryAsSoonAsPossible(context) {
    return Obx(
      ()=> InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          // controller.isDeliveryAsSoonAsPossible.value = !controller.isDeliveryAsSoonAsPossible.value;
          showDialog(context: context,
            barrierDismissible: false,
            builder: (context) {
              return PopScope(
                canPop: false,
                child: Stack(
                  children: [
                    AlertDialog(
                        insetPadding: const EdgeInsets.symmetric(horizontal: 22),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: AppColors.white,
                        content: Stack(children: [
                          deliveryAsSoonAsPossiblePopUp(context,),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: IconButton(
                              onPressed: () {
                                Get.back();
                                controller.pickedTimeVal.value = "";
                                controller.scheduleDeliveryController.value.text = "";
                                controller.isDeliveryAsSoonAsPossible.value = false;
                              },
                              icon: Icon(Icons.cancel,
                                color: AppColors.primary,
                                size: 26,),
                            ),
                          ),
                        ])
                    ),
                  ],
                ),
              );
            },);
        },
        child: Container(
          padding: REdgeInsetsDirectional.all(15),
          height: 60.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: controller.isDeliveryAsSoonAsPossible.value || controller.pickedTimeVal.isNotEmpty ? AppColors.primary : AppColors.ultraLightPrimary)),
          child: Row(
            children: [
              SvgPicture.asset(ImageConstants.clockIcon,height: 26,colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),),
              wBox(10),
              Text(
                "Delivery as soon as possible",
                style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios_sharp,color: AppColors.darkText,size: 21,)
              // Container(
              //   margin: EdgeInsets.only(top: 5.r),
              //   height: 20.h,
              //   width: 20.h,
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       border: Border.all(color: AppColors.primary)),
              //   child: controller.isDeliveryAsSoonAsPossible.value
              //       ? SvgPicture.asset("assets/svg/green-check-circle.svg")
              //       : null,
              // ),
            ],
          ),
        ),
      ),
    );

    // Container(
    //   padding: REdgeInsetsDirectional.all(15),
    //   height: 60.h,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(20.r),
    //       border: Border.all(color: AppColors.primary)),
    //   child: Row(
    //     children: [
    //       SvgPicture.asset("assets/svg/pin_location.svg"),
    //       wBox(10),
    //       Text(
    //         "Add Address",
    //         style: AppFontStyle.text_16_400(AppColors.primary),
    //       ),
    //       Spacer(),
    //       Icon(
    //         Icons.arrow_forward_ios_sharp,
    //         size: 20.h,
    //       )
    //     ],
    //   ),
    // );
  }

  /*
  Widget methodList({required String walletBalance, required String totalPrice}) {
    return GetBuilder(
      init: controller,
      builder: (controller) {
        return Obx(
          () => IgnorePointer(
            ignoring: controller.isSelectable.value ? true : false,
            child: Opacity(
              opacity: controller.isSelectable.value ? 0.6 : 1,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  bool isSelected = controller.selectedIndex.value == index;
                  if(index ==0 ){return const SizedBox.shrink();}
                  else if (index == 1) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        controller.selectedIndex.value = index;
                        controller.update();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal:  16.r ,vertical: 17.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.lightPrimary)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/svg/payment_card.svg"),
                                  // SvgPicture.asset("assets/svg/master-card.svg"),
                                  wBox(10.h),
                                 Text(
                                    "Pay With Card",
                                    style: AppFontStyle.text_16_400(
                                        AppColors.darkText,
                                        height: 1.h,family: AppFontFamily.gilroyMedium),
                                  ),
                                  // Text(
                                  //   "•••• •••• ••••",
                                  //   style: AppFontStyle.text_16_400(
                                  //       AppColors.darkText,
                                  //       height: 1.h,family: AppFontFamily.gilroyMedium),
                                  // ),
                                  // Text(
                                  //   "8888",
                                  //   style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                  //
                                  // ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            // wBox(6.h),
                            Container(
                              margin: EdgeInsets.only(top: 5.r),
                              height: 20.h,
                              width: 20.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: AppColors.primary)),
                              child: isSelected
                                  ? SvgPicture.asset(
                                      "assets/svg/green-check-circle.svg")
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if(index == 2){
                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                          controller.selectedIndex.value = index;
                          controller.update();
                        },
                   child: Container(
                        padding: EdgeInsets.symmetric(horizontal:  16.r ,vertical: 18.r),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.lightPrimary)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 9,
                              child: Row(
                                children: [
                                  // SvgPicture.asset("assets/svg/cod-icon.svg"),
                                  Text(
                                    "Cash On Delivery",
                                    style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            wBox(6),
                            Container(
                              // margin: EdgeInsets.only(top: 5.r),
                              height: 20.h,
                              width: 20.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: AppColors.primary)),
                              child: isSelected
                                  ? SvgPicture.asset(
                                      "assets/svg/green-check-circle.svg")
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return null;
                },
                separatorBuilder: (c, i) => hBox(15.h),
              ),
            ),
          ),
        );
      },
    );
  }
*/
  Widget tips(total, walletBalance) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Tip for the courier",
          style: AppFontStyle.text_20_600(
            AppColors.darkText,
            family: AppFontFamily.gilroyRegular,
          ),
        ),
        Text(
          "It's optional but a tip can brighten courier's day.",
          maxLines: 2,
          style: AppFontStyle.text_15_400(
            AppColors.mediumText,
            family: AppFontFamily.gilroyRegular,
          ),
        ),
        hBox(8.h),
        SizedBox(
          height: 52.h,
          child: Padding(
            padding: REdgeInsets.symmetric(vertical: 5),
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.priceList.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 89.w,
                  height: 40.h,
                  child: Obx(() {
                    return CustomOutlinedButton(
                      backgroundColor: controller.selectedTipsIndexValue.value == index
                          ? AppColors.primary
                          : AppColors.white,
                      borderColor: controller.selectedTipsIndexValue.value == index
                          ? AppColors.primary
                          : AppColors.darkText,
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();

                        // If tapped same index again
                        if (controller.selectedTipsIndexValue.value == index) {
                          if (index == 3) {
                            final removed = await prefs.remove('saved_tip_${controller.cartType.value}');
                            pt("Custom tip tapped again. Tip removed: $removed");

                            controller.enteredTips.value = "0";
                            controller.tipsController.value.clear();
                            controller.selectedTipsIndexValue.value = -1;

                            controller.updateBalanceAfterTips(
                              totalPrice: total,
                              walletBalance: walletBalance,
                              loadFromPrefs: true,
                            );

                            // if (context.mounted) {
                            //   showDialog(
                            //     context: context,
                            //     barrierDismissible: false,
                            //     builder: (context) {
                            //       return PopScope(
                            //         canPop: false,
                            //         child: Stack(
                            //           children: [
                            //             AlertDialog(
                            //               insetPadding: const EdgeInsets.symmetric(horizontal: 22),
                            //               shape: RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.circular(15),
                            //               ),
                            //               contentPadding: EdgeInsets.zero,
                            //               backgroundColor: AppColors.white,
                            //               content: Stack(
                            //                 children: [
                            //                   addTips(context, total, walletBalance),
                            //                   Positioned(
                            //                     right: 0,
                            //                     top: 0,
                            //                     child: IconButton(
                            //                       onPressed: () {
                            //                         controller.selectedTipsIndexValue.value = -1;
                            //                         controller.enteredTips.value = "0";
                            //                         controller.tipsController.value.clear();
                            //                         Get.back();
                            //                         controller.updateBalanceAfterTips(
                            //                           totalPrice: total,
                            //                           walletBalance: walletBalance,
                            //                         );
                            //                       },
                            //                       icon: Icon(
                            //                         Icons.cancel,
                            //                         color: AppColors.primary,
                            //                         size: 26,
                            //                       ),
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   );
                            // }
                          } else {
                            controller.selectedTipsIndexValue.value = -1;
                            controller.enteredTips.value = "0";
                            controller.tipsController.value.clear();
                            await prefs.remove('saved_tip_${controller.cartType.value}');
                            controller.updateBalanceAfterTips(
                              totalPrice: total,
                              walletBalance: walletBalance,
                            );
                          }
                        } else {
                          controller.selectedTipsIndexValue.value = index;

                          if (index == 0 || index == 1 || index == 2) {
                            String selectedTip = controller.priceList[index];
                            await prefs.setString('saved_tip_${controller.cartType.value}', selectedTip);

                            pt("Saved predefined tip: $selectedTip");

                            controller.enteredTips.value = selectedTip;
                            controller.tipsController.value.clear();
                          }

                          controller.updateBalanceAfterTips(
                            totalPrice: total,
                            walletBalance: walletBalance,
                          );

                          if (index == 3) {
                            controller.tipsController.value.clear();
                            controller.selectedTipsIndexValue.value = -1;
                            controller.enteredTips.value = "0";
                            if (context.mounted) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return PopScope(
                                    canPop: false,
                                    child: Stack(
                                      children: [
                                        AlertDialog(
                                          insetPadding: const EdgeInsets.symmetric(horizontal: 22),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          contentPadding: EdgeInsets.zero,
                                          backgroundColor: AppColors.white,
                                          content: Stack(
                                            children: [
                                              addTips(context, total, walletBalance),
                                              Positioned(
                                                right: 0,
                                                top: 0,
                                                child: IconButton(
                                                  onPressed: () {
                                                    controller.selectedTipsIndexValue.value = -1;
                                                    controller.enteredTips.value = "0";
                                                    controller.tipsController.value.clear();
                                                    Get.back();
                                                    controller.updateBalanceAfterTips(
                                                      totalPrice: total,
                                                      walletBalance: walletBalance,
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel,
                                                    color: AppColors.primary,
                                                    size: 26,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        }
                      },
                      child: Obx(() => Text(
                        index == 3
                            ? controller.priceList[index]
                            : "\$${controller.priceList[index]}",
                        style: AppFontStyle.text_17_400(
                          controller.selectedTipsIndexValue.value == index
                              ? AppColors.white
                              : AppColors.darkText,
                          family: AppFontFamily.gilroyMedium,
                        ),
                      )),
                    );
                  }),
                );
              },
              separatorBuilder: (context, index) => wBox(8.w),
            ),
          ),
        ),
      ],
    );
  }

  addTips(BuildContext context,total,walletBalance) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Obx(() =>
              Form(
                key: controller.tipsKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    hBox(30.h),
                    Center(child: Text( "Tips for the courier",style:  AppFontStyle.text_22_600(AppColors.black, family: AppFontFamily.gilroyRegular,),)),
                    hBox(20.h),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 25.0),
                      child: CustomTextFormField(
                        controller: controller.tipsController.value,
                        inputFormatters :[
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                          LengthLimitingTextInputFormatter(10),
                        ],
                        onChanged: (value) {
                          controller.enteredTips.value = value;
                          controller.updateBalanceAfterTips(
                            totalPrice: total,
                            walletBalance: walletBalance,
                          );
                        },

                        textInputType: TextInputType.number,
                        hintText: 'Enter tips for the courier',
                        hintStyle: AppFontStyle.text_15_400(AppColors.hintText,family: AppFontFamily.gilroyRegular),
                        // errorTextClr: restaurantAddOnController.isRedClr.value ? AppColors.red : AppColors.darkText,
                        onTapOutside: (value){
                          // restaurantAddOnController.isRedClr.value =false;
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onTap: (){
                          // restaurantAddOnController.isRedClr.value =false;
                        },
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Please enter courier tips";
                          }else if(double.parse(value) <= 0){
                            return "Courier must be greater then \$0";
                          }
                          return null;
                        },
                      ),
                    ),
                    hBox(13.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomElevatedButton(
                        fontFamily: AppFontFamily.gilroyMedium,
                        width: 145.w,
                        height: 50.h,
                          onPressed: () async {
                            if (controller.tipsKey.currentState?.validate() ?? false) {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString('saved_tip_${controller.cartType.value}', controller.tipsController.value.text);
                              controller.updateBalanceAfterTips(totalPrice: total,walletBalance: walletBalance,loadFromPrefs: true);
                              Get.back();

                              pt("Entered tip value saved locally >>>> ${controller.tipsController.value.text}");
                            } else {
                              controller.tipsKey.currentState?.validate();
                            }

                          // onPressed: () {
                          // if (controller.tipsKey.currentState?.validate() ?? false) {
                          //   // controller.initializeWallet(walletBalance, total); // no need for preserveSelectedIndex
                          //   controller.updateBalanceAfterTips(totalPrice: total, walletBalance: walletBalance);
                          //   Get.back();
                          //   pt("entered tips value  >>>> ${controller.tipsController.value.text}");
                          // } else {
                          //   controller.tipsKey.currentState?.validate();
                          // }
                        },

                        text: "Submit" ,
                        color: AppColors.primary,
                      ),
                    ),
                    hBox(30.h),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  deliveryNotesTextFields(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Obx(() =>
              Form(
                key: controller.deliveryNotesKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    hBox(30.h),
                    Center(child: Text( "Delivery Notes",style:  AppFontStyle.text_22_600(AppColors.black, family: AppFontFamily.gilroyRegular,),)),
                    hBox(20.h),
                    Padding(
                      padding: REdgeInsets.symmetric(horizontal: 25.0),
                      child: CustomTextFormField(
                        minLines: 3,
                        maxLines: 8,
                        textInputAction: TextInputAction.newline,
                        textInputType: TextInputType.multiline,
                        controller: controller.deliveryNotesController.value,
                        // controller: TextEditingController(text: controller.deliveryNotesController.value.text),
                        onChanged: (value){},
                        hintText: 'Enter delivery notes',
                        hintStyle: AppFontStyle.text_15_400(AppColors.hintText,family: AppFontFamily.gilroyRegular),
                        // errorTextClr: restaurantAddOnController.isRedClr.value ? AppColors.red : AppColors.darkText,
                        onTapOutside: (value){
                          // restaurantAddOnController.isRedClr.value =false;
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        onTap: (){
                          // restaurantAddOnController.isRedClr.value =false;
                        },
                        validator: (value) {
                          if(value == null || value.isEmpty){
                            return "Please enter delivery notes";
                          }
                          return null;
                        },
                      ),
                    ),
                    hBox(13.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomElevatedButton(
                        fontFamily: AppFontFamily.gilroyMedium,
                        width: 145.w,
                        height: 50.h,
                        onPressed: () {
                          if(controller.deliveryNotesKey.currentState?.validate() ?? false) {
                            controller.isDeliveryNotes.value = true;
                            if (controller.isDeliveryNotes.value) {
                              Get.back();
                            }
                          }else{
                            controller.deliveryNotesKey.currentState?.validate();
                          }
                        },
                        text: "Submit" ,
                        color: AppColors.primary,
                      ),
                    ),
                    hBox(30.h),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }

  deliveryAsSoonAsPossiblePopUp(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: PopScope(
        canPop: false,
        child: Stack(
          children: [
            Obx(() =>
                Form(
                  key: controller.deliveryTimeFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      hBox(30.h),
                      Center(child: Text( "Delivery time",style:  AppFontStyle.text_22_600(AppColors.black, family: AppFontFamily.gilroyRegular,),)),
                      hBox(20.h),
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 12.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            controller.isDeliveryAsSoonAsPossiblePopUp.value = !controller.isDeliveryAsSoonAsPossiblePopUp.value;
                            if(controller.pickedTimeVal.value.isNotEmpty){
                              controller.pickedTimeVal.value = '';
                              controller.scheduleDeliveryController.value.text = '';
                            }
                          },
                          child: Container(
                            padding: REdgeInsetsDirectional.all(15),
                            height: 60.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(color: controller.isDeliveryAsSoonAsPossiblePopUp.value ? AppColors.primary : AppColors.ultraLightPrimary)),
                            child: Row(
                              children: [
                                SvgPicture.asset(ImageConstants.clockIcon,height: 26,colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),),
                                wBox(10),
                                Text(
                                  "Delivery as soon as possible",
                                  style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                ),
                                const Spacer(),
                                Container(
                                  margin: EdgeInsets.only(top: 5.r),
                                  height: 20.h,
                                  width: 20.h,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.primary)),
                                  child: controller.isDeliveryAsSoonAsPossiblePopUp.value
                                      ? SvgPicture.asset("assets/svg/green-check-circle.svg")
                                      : null,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      hBox(20.h),
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 12.0),
                        child: SizedBox(
                          child: Obx(
                            ()=> CustomTextFormField(
                              contentPadding: const EdgeInsets.symmetric(vertical: 17,horizontal: 12),
                              // enabled: false,
                              readOnly: true,
                              controller: controller.scheduleDeliveryController.value,
                              onTap: () {
                                controller.selectTime(context);
                                controller.isDeliveryAsSoonAsPossiblePopUp.value = false;
                              },
                              onChanged: (value){
                                if(value.isEmpty){
                                  controller.pickedTimeVal.value = "";
                                }
                              },
                              hintText: ' Schedule Delivery',
                              hintStyle: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                              textStyle: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                              // hintStyle: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                              onTapOutside: (value){
                                FocusManager.instance.primaryFocus?.unfocus();
                              },
                              prefix: Padding(
                                padding: REdgeInsets.only(left: 16.0,right: 8),
                                child: SvgPicture.asset(ImageConstants.clockIcon,height: 26,colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),),
                              ),
                              borderDecoration: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide: BorderSide(color:controller.pickedTimeVal.value.isNotEmpty ? AppColors.primary : AppColors.ultraLightPrimary),
                              ),
                              validator: (value) {
                                  // if (value == null || value.isEmpty) {
                                  //   return "Please enter delivery time";
                                  // }
                                 final now = DateTime.now();
                                  final minAllowedTime = now.add(const Duration(minutes: 30));
                                  if (controller.parseTime1.value.isBefore(minAllowedTime) && (value?.isNotEmpty ?? false)) {
                                    return "Delivery time must be at least 30 minutes from now";
                                  }

                                  return null;
                                },
                              suffix: controller.pickedTimeVal.value.isEmpty ? const SizedBox.shrink() :
                                      IconButton(onPressed: () {
                                        // controller.isTextFieldClear.value = true;
                                        controller.pickedTimeVal.value = '';
                                        controller.scheduleDeliveryController.value.text = '';
                                      }, icon: const Icon(Icons.cancel_outlined,size: 22,),),
                            ),
                          ),
                        ),
                      ),
                      hBox(13.h),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomElevatedButton(
                          fontFamily: AppFontFamily.gilroyMedium,
                          width: 145.w,
                          height: 50.h,
                          onPressed: () {
                            final isAsap = controller.isDeliveryAsSoonAsPossiblePopUp.value;
                            final isScheduled = controller.pickedTimeVal.value.isNotEmpty;

                            if (isAsap || isScheduled) {
                              if (controller.deliveryTimeFormKey.currentState!.validate()) {
                                controller.isDeliveryAsSoonAsPossible.value = true;
                                Get.back();
                              }
                            } else {
                              controller.isDeliveryAsSoonAsPossible.value = false;
                              Get.back();
                            }
                          },
                          text: "Submit" ,
                          color: AppColors.primary,
                        ),
                      ),
                      hBox(30.h),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
