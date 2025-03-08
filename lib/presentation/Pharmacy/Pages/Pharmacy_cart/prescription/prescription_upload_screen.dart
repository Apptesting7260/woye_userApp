import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/prescription/prescription_controller.dart';

import '../../../../../Core/Utils/app_export.dart';

class PrescriptionUploadScreen extends StatelessWidget {
  PrescriptionUploadScreen({super.key});

  final PrescriptionController controller = Get.put(PrescriptionController());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments ?? {};
    var addressId = arguments['address_id'] ?? '';
    var couponId = arguments['coupon_id'] ?? '';
    var vendorId = arguments['vendor_id'] ?? '';
    var formattedTotal = arguments['total'] ?? "0.00";
    var total = double.tryParse(formattedTotal)?.toStringAsFixed(2) ?? "0.00";
    var cartId = arguments['cart_id'] ?? "";
    var regularPrice = arguments['regular_price'] ?? "";
    var saveAmount = arguments['save_amount'] ?? "";
    var deliveryCharge = arguments['delivery_charge'] ?? "";
    var couponDiscount = arguments['coupon_discount'] ?? "";
    var cartType = arguments['cartType'] ?? "";
    var walletBalance = arguments['wallet'] ?? "";
    var prescription = arguments['prescription'] ?? "";
    print("Address ID: $addressId");
    print("Coupon ID: $couponId");
    print("Vendor Id: $vendorId");
    print("Total: $total");
    print("Cart ID: $cartId");
    print("Regular Price: $regularPrice");
    print("Save Amount: $saveAmount");
    print("Delivery Charge: $deliveryCharge");
    print("Coupon Discount: $couponDiscount");
    print("cartType: $cartType");
    print("wallet: $walletBalance");
    print("prescription: $prescription");
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Prescription",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              dynamicImages(),
              hBox(30.h),
              // Obx(
              //     ()=> CustomElevatedButton(
              //     onPressed: () {
              //       if (prescription == "yes") {
              //         if (controller.profileImageGetUrl.value == "") {
              //           Utils.showToast("Prescription is required to upload for this medication.");
              //         } else {
              //           if (controller.imageList.last.value != null) {
              //             List<String> imagePaths = controller.imageList.map((fileRx) => fileRx.value?.path ?? "").toList();
              //             Get.toNamed(
              //               AppRoutes.checkoutScreen,
              //               arguments: {
              //                 'address_id': addressId,
              //                 'coupon_id': couponId,
              //                 'vendor_id': vendorId,
              //                 'total': total,
              //                 'regular_price': regularPrice,
              //                 'coupon_discount': couponDiscount,
              //                 'save_amount': saveAmount,
              //                 'delivery_charge': deliveryCharge,
              //                 'cart_id': cartId,
              //                 'wallet': walletBalance,
              //                 'cartType': cartType,
              //                 'imagePath': imagePaths,
              //               },
              //             );
              //           } else {
              //             Utils.showToast("Please select image");
              //           }
              //         }
              //       } else {
              //         List<String> imagePaths = controller.imageList.map((fileRx) => fileRx.value?.path ?? "").toList();
              //         Get.toNamed(
              //           AppRoutes.checkoutScreen,
              //           arguments: {
              //             'address_id': addressId,
              //             'coupon_id': couponId,
              //             'vendor_id': vendorId,
              //             'total': total,
              //             'regular_price': regularPrice,
              //             'coupon_discount': couponDiscount,
              //             'save_amount': saveAmount,
              //             'delivery_charge': deliveryCharge,
              //             'cart_id': cartId,
              //             'wallet': walletBalance,
              //             'cartType': cartType,
              //             'imagePath': imagePaths,
              //           },
              //         );
              //       }
              //     },
              //     text: prescription != "yes" && controller.imageList.first.value == null ? "Skip" : "Continue",
              //     height: 55.h,
              //     width: Get.width * .8,
              //   ),
              // ),
              Column(
                children: [
                  if (prescription == "yes")
                    CustomElevatedButton(
                      onPressed: () {
                        if (controller.profileImageGetUrl.value == "") {
                          Utils.showToast(
                              "Prescription is required to upload for this medication.");
                        } else {
                          if (controller.imageList.last.value != null) {
                            List<String> imagePaths = controller.imageList
                                .map((fileRx) => fileRx.value?.path ?? "")
                                .toList();
                            Get.toNamed(
                              AppRoutes.checkoutScreen,
                              arguments: {
                                'address_id': addressId,
                                'coupon_id': couponId,
                                'vendor_id': vendorId,
                                'total': total,
                                'regular_price': regularPrice,
                                'coupon_discount': couponDiscount,
                                'save_amount': saveAmount,
                                'delivery_charge': deliveryCharge,
                                'cart_id': cartId,
                                'wallet': walletBalance,
                                'cartType': cartType,
                                'imagePath': imagePaths,
                              },
                            );
                          } else {
                            Utils.showToast("Please select image");
                          }
                        }
                      },
                      text: "Continue",
                      height: 55.h,
                      width: Get.width * .8,
                    ),

                  if (prescription != "yes")
                    Obx(
                          () => CustomElevatedButton(
                        onPressed: () {
                          List<String> imagePaths = controller.imageList
                              .map((fileRx) => fileRx.value?.path ?? "")
                              .toList();
                          Get.toNamed(
                            AppRoutes.checkoutScreen,
                            arguments: {
                              'address_id': addressId,
                              'coupon_id': couponId,
                              'vendor_id': vendorId,
                              'total': total,
                              'regular_price': regularPrice,
                              'coupon_discount': couponDiscount,
                              'save_amount': saveAmount,
                              'delivery_charge': deliveryCharge,
                              'cart_id': cartId,
                              'wallet': walletBalance,
                              'cartType': cartType,
                              'imagePath': imagePaths,
                            },
                          );
                        },
                        text: controller.imageList.first.value == null
                            ? "Skip"
                            : "Continue with Prescription",
                        height: 55.h,
                        width: Get.width * .8,
                      ),
                    ),
                ],
              ),

              // Obx(() =>
              //   CustomElevatedButton(
              //     onPressed: () {
              //       if (prescription == "yes") {
              //         if (controller.profileImageGetUrl.value == "") {
              //           Utils.showToast("Prescription is required to upload for this medication.");
              //         } else {
              //           if(controller.imageList.last.value != null){
              //             List<String> imagePaths = controller.imageList.map((fileRx) => fileRx.value?.path ?? "").toList();
              //             Get.toNamed(
              //               AppRoutes.checkoutScreen,
              //               arguments: {
              //                 'address_id': addressId,
              //                 'coupon_id': couponId,
              //                 'vendor_id': vendorId,
              //                 'total': total,
              //                 'regular_price': regularPrice,
              //                 'coupon_discount': couponDiscount,
              //                 'save_amount': saveAmount,
              //                 'delivery_charge': deliveryCharge,
              //                 'cart_id': cartId,
              //                 'wallet': walletBalance,
              //                 'cartType': cartType,
              //                 'imagePath': imagePaths,
              //               },
              //             );
              //           } else{
              //             Utils.showToast("Please select image");
              //           }
              //         }
              //       } else{
              //         List<String> imagePaths = controller.imageList.map((fileRx) => fileRx.value?.path ?? "").toList();
              //         Get.toNamed(
              //           AppRoutes.checkoutScreen,
              //           arguments: {
              //             'address_id': addressId,
              //             'coupon_id': couponId,
              //             'vendor_id': vendorId,
              //             'total': total,
              //             'regular_price': regularPrice,
              //             'coupon_discount': couponDiscount,
              //             'save_amount': saveAmount,
              //             'delivery_charge': deliveryCharge,
              //             'cart_id': cartId,
              //             'wallet': walletBalance,
              //             'cartType': cartType,
              //             'imagePath': imagePaths,
              //           },
              //         );
              //       }
              //     },
              //     text: prescription != "yes" && controller.imageList.first.value == null ? "Skip" : "Continue",
              //     height: 55.h,
              //     width: Get.width * .8,
              //   )
              // ),
              hBox(30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget dynamicImages() {
    return Obx(
      () => ListView.separated(
        itemCount: controller.imageList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, index) {
          return Column(
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () {
                    bottomSheet(context, index);
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(12),
                    padding: const EdgeInsets.all(6),
                    dashPattern: const [4],
                    color: AppColors.primary,
                    child: SizedBox(
                      height: 200,
                      width: Get.width,
                      child: controller.imageList[index].value != null
                          ? ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(12)),
                              child: Image.file(
                                controller.imageList[index].value!,
                                width: 130,
                                height: 130,
                                // fit: BoxFit.fill,
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImageConstants.uploadImage,
                                  height: 45,
                                  width: 45,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.hintText,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  "Upload Prescription Image",
                                  style: AppFontStyle.text_14_500(
                                    AppColors.mediumText,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  "jpg should be less than 5MB",
                                  style: AppFontStyle.text_14_400(
                                    AppColors.hintText,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
              hBox(8.h),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (controller.imageList.length > 1) ...[
                      GestureDetector(
                        onTap: () {
                          controller.imageList.removeAt(index);
                        },
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.minus,
                              color: AppColors.red,
                              size: 20.sp,
                            ),
                            Text(
                              " Remove",
                              style: AppFontStyle.text_15_400(
                                AppColors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                    const Spacer(),
                    if (controller.imageList[index].value != null &&
                        index == (controller.imageList.length - 1)) ...[
                      GestureDetector(
                        onTap: () {
                          if (controller.imageList[index].value != null) {
                            controller.imageList.add(Rx<File?>(null));
                          }
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              color: AppColors.primary,
                              size: 20.sp,
                            ),
                            Text(
                              " Add More",
                              style: AppFontStyle.text_15_400(
                                AppColors.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return hBox(12.h);
        },
      ),
    );
  }

  Future bottomSheet(BuildContext context, int index) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: OutlineInputBorder(
        borderSide: const BorderSide(width: 0, color: Colors.transparent),
        gapPadding: 0,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
      ),
      showDragHandle: true,
      constraints: BoxConstraints(maxHeight: 218.h),
      elevation: 12.w,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: AppColors.primary.withOpacity(0.2),
                  blurRadius: 5,
                  blurStyle: BlurStyle.outer)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r)),
            color: Colors.white,
            // gradient: LinearGradient(
            //     colors: [Colors.white, AppColors.primary.withOpacity(0.05)],
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: REdgeInsets.all(12.0),
            child: Column(
              children: [
                Text("Pick an Image",
                    style: GoogleFonts.poppins(
                      textStyle: AppFontStyle.text_18_400(AppColors.mediumText),
                    )),
                hBox(18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.pickImage(ImageSource.camera, index);
                        // _pickImageFromCamera();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: REdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.primary.withOpacity(0.2),
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.photo_camera_outlined,
                              color: AppColors.lightText,
                              size: 24.h,
                            ),
                            Text(
                              "Camera",
                              style:
                                  AppFontStyle.text_16_400(AppColors.lightText),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.pickImage(ImageSource.gallery, index);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: REdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.primary.withOpacity(0.2),
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              color: AppColors.lightText,
                              size: 24.h,
                            ),
                            Text(
                              "Gallery",
                              style:
                                  AppFontStyle.text_16_400(AppColors.lightText),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
