import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_expansion_tile.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/controller/grocery_specific_product_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/grocery_product_details_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/controller/pharma_specific_product_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/pharmacy_product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_details/order_details_controller.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/cancel_order/cancel_order_controller.dart';
import 'dart:io';

import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/app_image.dart';
import 'package:woye_user/shared/widgets/file_downloder.dart';


class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});

  final OrderDetailsController controller = Get.put(OrderDetailsController());
  final RestaurantNavbarController restaurantNavbarController = Get.put(RestaurantNavbarController());
  final CancelOrderController cancelOrderController = Get.put(CancelOrderController());
  final FileDownloader fileDownloader = Get.put(FileDownloader());

  @override
  Widget build(BuildContext context) {
    print("orderDetails?.drslip>>> : ${controller.ordersData.value.orderDetails?.drslip}");

    final arguments = Get.arguments ?? {};
    final id = arguments['order_id'] ?? "";
    print('Order ID: $id');
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Order Details",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child: circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet'|| controller.error.value == "InternetExceptionWidget") {
              return InternetExceptionWidget(
                onPress: () {
                  controller.orderDetailsApi(orderId: id);
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.orderDetailsApi(orderId: id);
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.orderDetailsApi(orderId: id);
              },
              child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: REdgeInsets.symmetric(horizontal: 24),
                  child: Obx(
                    ()=> Column(
                      children: [
                        heading(),
                        hBox(30),
                        orderDetails(),
                        hBox(20),
                        orderIdDetails(),
                        hBox(20),
                        paymentDetails(),
                        if ((controller.ordersData.value.orderDetails?.deliverySoon?.isNotEmpty ?? false) ||
                            (controller.ordersData.value.orderDetails?.deliveryNotes?.isNotEmpty ?? false)) ...[
                          hBox(20),
                          otherDetails(),
                        ],
                        if(controller.ordersData.value.orderDetails?.type == 'pharmacy' &&
                         (controller.ordersData.value.orderDetails?.drslip?.isNotEmpty ?? false))...[
                        hBox(20),
                        prescriptions(),
                        ],
                        if (controller.ordersData.value.review != null)...[
                          hBox(20),
                          reviews(),
                        ],
                        hBox(20),
                        downloadInvoice(),
                        if(controller.ordersData.value.orderDetails?.status?.toLowerCase() == "pending")...[
                        hBox(14),
                        cancelOrder(id: id),
                        ],
                        hBox(14),
                        continueShopping(),
                        hBox(20),
                        buttons(),
                        hBox(50)
                      ],
                    ),
                  )),
            );
        }
      }),
    );
  }

  CustomElevatedButton continueShopping() {
    return CustomElevatedButton(
        forGroundColor: AppColors.primary,
        color: AppColors.primary,
        onPressed:(){
          restaurantNavbarController.navigateBackToMainNavbar(index: 0);
        },
        text: "Continue Shopping",
        textStyle:AppFontStyle.text_16_500(AppColors.white,family: AppFontFamily.onestMedium)
      );
  }

  CustomElevatedButton cancelOrder({required String id}) {
    return CustomElevatedButton(
      forGroundColor: AppColors.black,
      color: AppColors.black,
      onPressed:(){
        cancelPopUp(oderId: controller.ordersData.value.orderDetails?.orderId ?? "",id: id);
      },
      child: Row(
        children: [
          AppImage(path: ImageConstants.delete,svgColor:ColorFilter.mode( AppColors.white, BlendMode.srcIn)),
          wBox(10),
          Text("Cancel Order",style:AppFontStyle.text_16_500(AppColors.white,family: AppFontFamily.onestSemiBold),),
          const Spacer(),
          Icon(Icons.arrow_forward_ios_rounded,color: AppColors.white),
        ],
      ),
    );
  }

  CustomElevatedButton downloadInvoice() {
    return CustomElevatedButton(
      forGroundColor: AppColors.white,
      color: AppColors.white,
      side: BorderSide(
        color: AppColors.black,
        width: 0.8,
      ),
      onPressed:(){
        fileDownloader.downloadAndSaveFile(controller.ordersData.value.invoice ?? "",saveInDownload: true);
      },
      child:Obx(
        ()=> fileDownloader.rxRequestStats.value == Status.LOADING ? circularProgressIndicator() : Row(
          children: [
            AppImage(path: ImageConstants.receipt),
            wBox(10),
            Text("Download Invoice",style:AppFontStyle.text_16_500(AppColors.black,family: AppFontFamily.onestMedium),),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,color: AppColors.black),
          ],
        ),
      ),
    );
  }

  Widget heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
         "Hey, ${controller.ordersData.value.addressDetails?.fullName.toString().capitalize ?? ""}",
          style: AppFontStyle.text_24_400(AppColors.darkText,family: AppFontFamily.onestSemiBold),
        ),
        hBox(10.h),
        Wrap(
          children: [
            Text(
              "Thank you for your order! We'll keep you updated on its arrival.",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFontFamily.onestRegular,
                  color: AppColors.lightText),
            ),
          ],
        ),
      ],
    );
  }

  Widget orderDetails() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: CustomExpansionTile(
        title: "Order Details",
        children: [
          const Divider(),
          hBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order id",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
              ),
              Text(
                controller.ordersData.value.orderDetails!.orderId.toString(),
                // style: AppFontStyle.text_12_600(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),

              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Status",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
              ),
              Text(
                controller.ordersData.value.orderDetails?.status?.replaceAll("_", " ").capitalize ?? "",
                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking id",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
              ),
              Text(
                controller.ordersData.value.orderDetails?.trackingId ?? "",
                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order placed",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
              ),
              Text(
                  DateFormat('dd MMMM yyyy').format(DateTime.parse( controller.ordersData.value.orderDetails?.createdAt ?? "",)),

                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.ordersData.value.orderDetails?.type?.capitalizeFirst ?? "",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
              ),
              wBox(10),
              Flexible(
                child: Text(
                  controller.ordersData.value.orderDetails?.vendorName ?? "",
                  maxLines: 2,
                  style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
                ),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.onestSemiBold),
              ),
              Text(
                "\$${controller.ordersData.value.orderDetails?.total ?? ""}",
                style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.onestSemiBold),
              ),
            ],
          ),
          hBox(10),
          const Divider(),
          hBox(10),
          Text(
            "Delivery Address",
            style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.onestMedium),
          ),
          hBox(10),
          Text(
            controller.ordersData.value.addressDetails?.addressType.toString().capitalize ?? "",
            style: AppFontStyle.text_16_400(AppColors.primary,family: AppFontFamily.onestMedium),
          ),
          hBox(10),
          Text(
            controller.ordersData.value.addressDetails?.fullName?.capitalize ?? "",
            style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestMedium),
          ),
          hBox(10),
          Text(
            controller.ordersData.value.addressDetails?.address.toString() ?? "",
            maxLines: 4,
            style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
          ),
          hBox(10),
          Text(
            "${controller.ordersData.value.addressDetails?.countryCode ?? ""} ${controller.ordersData.value.addressDetails?.phoneNumber ?? ""}",
            style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.onestMedium),
          ),
          hBox(15),
        ],
      ),
    );
  }

  final specific_Product_Controller specificProductController =Get.put(specific_Product_Controller());
  final PharmaSpecificProductController pharmaSpecificProductController = Get.put(PharmaSpecificProductController());
  final GrocerySpecificProductController grocerySpecificProductController  = Get.put(GrocerySpecificProductController());

  Widget orderIdDetails() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.textFieldBorder)),
        child: CustomExpansionTile(
          title:
              "Order Id: #${controller.ordersData.value.orderDetails?.orderId ?? ""}",
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller
                  .ordersData.value.orderDetails!.decodedAttribute!.length,
              itemBuilder: (context, index) {
                final item = controller
                    .ordersData.value.orderDetails!.decodedAttribute![index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (controller.ordersData.value.orderDetails!.type
                                .toString() ==
                            "restaurant") {
                          Get.to(ProductDetailsScreen(
                            productId: item.productId.toString(),
                            categoryId: item.categoryId.toString(),
                            categoryName: item.categoryName.toString(),
                          ));

                          specificProductController.specific_Product_Api(
                              productId: item.productId.toString(),
                              categoryId: item.categoryId.toString());
                        } else if (controller
                                .ordersData.value.orderDetails!.type
                                .toString() ==
                            "pharmacy") {
                          pharmaSpecificProductController
                              .pharmaSpecificProductApi(
                                  productId: item.productId.toString(),
                                  categoryId: item.categoryId.toString());
                          Get.to(() => PharmacyProductDetailsScreen(
                                productId: item.productId.toString(),
                                categoryId: item.categoryId.toString(),
                                categoryName: item.categoryName.toString(),
                              ));

                          // Get.to(PharmacyProductDetailsScreen(
                          //   productId: item.productId.toString(),
                          //   categoryId: item.categoryId.toString(),
                          //   categoryName: item.categoryName.toString(),
                          // ));
                        }else if (controller
                            .ordersData.value.orderDetails!.type
                            .toString() ==
                            "grocery") {
                          grocerySpecificProductController.pharmaSpecificProductApi(
                              productId: item.productId.toString(),
                              categoryId: item.categoryId.toString());
                          Get.to(() => GroceryProductDetailsScreen(
                            productId: item.productId.toString(),
                            categoryId: item.categoryId.toString(),
                            categoryName: item.categoryName.toString(),
                          ));
                        }
                      },
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: item.productImage.toString(),
                            height: 100.h,
                            width: 100.h,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: AppColors.gray,
                              highlightColor: AppColors.lightText,
                              child: Container(
                                color: AppColors.white,
                                height: 100.h,
                                width: 100.h,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                          wBox(15.h),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName.toString(),
                                  maxLines: 2,
                                  style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.onestRegular),
                                  // style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                                ),
                                hBox(10),
                                Text(
                                  "Qty:${item.quantity.toString()}",
                                  style: AppFontStyle.text_12_400(
                                      AppColors.darkText,family: AppFontFamily.onestRegular),
                                ),
                                hBox(10),
                                Text(
                                  "\$${item.price.toString()}",
                                  style: AppFontStyle.text_14_600(
                                      AppColors.primary,family: AppFontFamily.onestRegular),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (controller.ordersData.value.orderDetails?.type !="pharmacy")
                      if (item.attribute?.isNotEmpty ?? true)
                        Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: SizedBox(
                            width: Get.width,
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 2.w,
                              runSpacing: 2.w,
                              children: List.generate(
                                item.attribute?.length ?? 0,
                                (addonIndex) {
                                  bool isLast =
                                      addonIndex == item.attribute!.length - 1;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item.attribute?[addonIndex].itemDetails?.itemName?.capitalizeFirst}',
                                        style: AppFontStyle.text_12_400(
                                            AppColors.primary,family: AppFontFamily.onestMedium),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        ' - ',
                                        style: AppFontStyle.text_12_400(
                                            AppColors.primary,family: AppFontFamily.onestRegular),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        '\$${item.attribute?[addonIndex].itemDetails?.itemPrice ?? ""}',
                                        style: AppFontStyle.text_12_400(
                                            AppColors.primary,family: AppFontFamily.onestMedium),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      if (!isLast)
                                        Text(
                                          ',',
                                          style: AppFontStyle.text_12_400(
                                              AppColors.primary,family: AppFontFamily.onestMedium),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                    if (controller.ordersData.value.orderDetails?.type !=
                        "pharmacy")
                      if (item.addons?.isNotEmpty ?? true)
                        Padding(
                          padding: REdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: Get.width,
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 2.w,
                              runSpacing: 2.w,
                              children: List.generate(
                                item.addons?.length ?? 0,
                                (addonIndex) {
                                  bool isLast =
                                      addonIndex == item.addons!.length - 1;
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${item.addons![addonIndex].name?.capitalizeFirst}',
                                        style: AppFontStyle.text_12_400(
                                            AppColors.lightText,family: AppFontFamily.onestMedium),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        ' - ',
                                        style: AppFontStyle.text_12_400(
                                            AppColors.lightText,family: AppFontFamily.onestMedium),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        '\$${item.addons![addonIndex].price}',
                                        style: AppFontStyle.text_12_400(
                                            AppColors.lightText,family: AppFontFamily.onestMedium),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      if (!isLast)
                                        Text(
                                          ',',
                                          style: AppFontStyle.text_12_400(
                                              AppColors.lightText,family: AppFontFamily.onestMedium),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
            hBox(0.h),
            const Divider(),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Subtotal",
            //       style: AppFontStyle.text_12_400(AppColors.lightText),
            //     ),
            //     Text(
            //       "\$132.00",
            //       style: AppFontStyle.text_12_600(AppColors.darkText),
            //     ),
            //   ],
            // ),
            // hBox(10),
            if (controller.ordersData.value.orderDetails!.coupon != null)
              hBox(5),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sub Total",
                      // style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                      style: AppFontStyle.text_13_400(AppColors.lightText,family: AppFontFamily.onestRegular),
                    ),
                    Text(
                      "\$${controller.ordersData.value.orderDetails?.subtotal.toString() ?? ""}",
                      // "\$${controller.ordersData.value.subtotal.toString()}",
                      style: AppFontStyle.text_13_600(AppColors.darkText,family: AppFontFamily.onestRegular),
                      // style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),

                    ),
                  ],
                ),
                hBox(5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Charge",
                      style: AppFontStyle.text_13_400(AppColors.lightText,family: AppFontFamily.onestRegular),
                    ),
                    Text(
                      "\$${controller.ordersData.value.deliveryCharges ?? "0"}",
                      style: AppFontStyle.text_13_600(AppColors.darkText,family: AppFontFamily.onestRegular),
                    ),
                  ],
                ),
                hBox(5),
                if (controller.ordersData.value.orderDetails?.couponDiscount?.isNotEmpty ?? false
                || controller.ordersData.value.orderDetails?.couponDiscount.toString() != '0.00')...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coupon Discount",
                    style: AppFontStyle.text_12_400(AppColors.lightText,family: AppFontFamily.onestRegular),
                  ),
                  Text(
                   "\$${controller.ordersData.value.orderDetails!.couponDiscount.toString()}",
                    style: AppFontStyle.text_12_600(AppColors.darkText,family: AppFontFamily.onestRegular),
                  ),/*Text(
                    controller.ordersData.value.orderDetails!.coupon!.couponType.toString() == "percentage"
                        ? "-${controller.ordersData.value.orderDetails!.coupon!.value.toString()}%"
                        : "-\$${controller.ordersData.value.orderDetails!.coupon!.value.toString()}",
                    style: AppFontStyle.text_12_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                  ),*/
                ],
              ),
                  hBox(5),

                ],
                if(controller.ordersData.value.orderDetails?.courierTip?.isNotEmpty ?? false)...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Delivery Tip",
                      style: AppFontStyle.text_13_400(AppColors.lightText,family: AppFontFamily.onestRegular),
                    ),
                    Text(
                      "\$${controller.ordersData.value.orderDetails?.courierTip.toString()}",
                      style: AppFontStyle.text_13_600(AppColors.darkText,family: AppFontFamily.onestRegular),
                    ),
                  ],
                ),
               ],
              ],
            ),
            // hBox(15),
            const Divider(),
            // hBox(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total ",
                  style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestMedium),
                ),
                Text(
                  // "\$${controller.ordersData.value.subtotal.toString()}",
                  "\$${controller.ordersData.value.orderDetails!.total.toString()}",
                  style: AppFontStyle.text_16_400(AppColors.primary,family: AppFontFamily.onestSemiBold),
                ),
              ],
            ),
            hBox(15),
          ],
        ),
    );
  }

  Widget paymentDetails() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: CustomExpansionTile(title: "Payments Details", children: [
        const Divider(),
        hBox(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment method",
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
            ),
            Text(
              controller.ordersData.value.orderDetails!.paymentMethod
                  .toString()
                  .replaceAll("_", " ")
                  .toString()
                  .capitalize!,
              style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
            ),
          ],
        ),
        hBox(6),
        if (controller.ordersData.value.orderDetails?.walletUsed.toString() != "0")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wallet",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
              ),
              Text(
                "\$${controller.ordersData.value.orderDetails!.walletUsed.toString()}",
                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              ),
            ],
          ),
        if (controller.ordersData.value.orderDetails?.walletUsed.toString() != "0")
          hBox(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment Date",
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
            ),
            Text(controller.ordersData.value.orderDetails?.createdAt == null ? "" :
              DateFormat('dd MMMM, yyyy').format(DateTime.parse(controller.ordersData.value.orderDetails?.createdAt.toString() ?? "")),
              overflow: TextOverflow.ellipsis,
              style: AppFontStyle.text_13_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              // style: AppFontStyle.text_12_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
            ),
            Text(
              // "\$${controller.ordersData.value.subtotal.toString()}",
              "\$${controller.ordersData.value.orderDetails?.total ?? ""}",
              style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),

              // style: AppFontStyle.text_12_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
        hBox(15)
      ]),
    );
  }

  Widget otherDetails() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: CustomExpansionTile(title: "Other Details", children: [
        const Divider(),
        hBox(15),
        if((controller.ordersData.value.orderDetails?.deliveryNotes != null ) ||
        (controller.ordersData.value.orderDetails?.deliveryNotes?.isNotEmpty ?? false))...[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Delivery Notes",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Expanded(
                child: Text(
                  controller.ordersData.value.orderDetails!.deliveryNotes.toString().capitalize ?? "",
                  maxLines: 25,
                  style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
                ),
              ),
            ),
          ],
        ),
        ],
        if((controller.ordersData.value.orderDetails?.deliverySoon != null ) ||
            (controller.ordersData.value.orderDetails?.deliverySoon?.isNotEmpty ?? false))...[
        hBox(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Delivery Soon",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
              ),
              Text(
                controller.ordersData.value.orderDetails?.deliverySoon ?? "",
                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.onestMedium),
              ),
            ],
          ),
        ],
        hBox(15)
      ]),
    );
  }

  Widget prescriptions() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: CustomExpansionTile(title: "Prescriptions", children: [
        const Divider(),
        hBox(8.h),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // itemCount: 5,
            itemCount: controller.ordersData.value.orderDetails?.drslip?.length,
            itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.r),
                  child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.prescriptionsScreen,
                          arguments: {
                            "index" : index,
                            "imageUrls" :controller.ordersData.value.orderDetails?.drslip,
                          },
                        );
                      },
                      child: CachedNetworkImage(
                        memCacheHeight: memCacheHeight,
                        imageUrl: controller.ordersData.value.orderDetails?.drslip?[index] ?? "",
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColors.gray,
                          highlightColor: AppColors.lightText,
                          child: Container(
                            width: 160.h,
                            height: 160.h,
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 160.h,
                          // height: 80.h,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.greyBackground),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Icon(
                            Icons.broken_image_rounded,
                            size: 40.h,
                            color: AppColors.lightText.withOpacity(0.5),
                          ),
                        ),
                      ),
                  ),
              ),
            );
          },),
        ),
        hBox(15.h),
      ],
      ),
    );
  }

  Widget reviews() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: CustomExpansionTile(
        title: "Review",
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RatingBar.readOnly(
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star,
                        filledColor: AppColors.goldStar,
                        emptyColor: AppColors.normalStar,
                        initialRating: double.parse(controller
                            .ordersData.value.review?.rating ?? ""),
                        maxRating: 5,
                        size: 20.h,
                      ),
                      hBox(10),
                      Text(
                        controller.ordersData.value.review!.review.toString(),
                        style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestMedium),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: IconButton(
                    onPressed: () {
                      final arguments = {
                        'order_id': controller.ordersData.value.orderDetails!.id
                            .toString(),
                        'vendor_id': controller
                            .ordersData.value.orderDetails!.vendorId
                            .toString(),
                        'type': controller.ordersData.value.orderDetails!.type
                            .toString(),
                        'reply': controller.ordersData.value.review!.review
                            .toString()
                            .trim(),
                        "raring": controller.ordersData.value.review!.rating
                            .toString(),
                        "from": "details",
                      };
                      Get.toNamed(
                        AppRoutes.rateAndReviewProductScreen,
                        arguments: arguments,
                      );
                    },
                    icon: Icon(
                      Icons.edit,
                      color: AppColors.primary,
                    )),
              )
            ],
          ),
          const Divider(),
          if (controller.ordersData.value.review!.reply != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.reply,
                  color: AppColors.primary,
                ),
                Flexible(
                  child: Text(
                    controller.ordersData.value.review?.reply?.trim() ?? "",
                    style: AppFontStyle.text_16_400(AppColors.lightText ,family: AppFontFamily.onestMedium),
                    maxLines: 100,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          hBox(10),
        ],
      ),
    );
  }

  Widget buttons() {
    return Column(children: [
      if (controller.ordersData.value.orderDetails!.status.toString() ==
          "completed")
        CustomOutlinedButton(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            onPressed: () async {
              var invoiceUrl = controller.ordersData.value.invoice;

              if (invoiceUrl != null) {
                try {
                  // Get the temporary directory to save the file
                  var dir = await getTemporaryDirectory();
                  var fileName =
                      "invoice${controller.ordersData.value.orderDetails!.orderId.toString()}.pdf";
                  var savePath = "${dir.path}/$fileName";

                  // Download the invoice file using Dio
                  Dio dio = Dio();
                  await dio.download(invoiceUrl, savePath);

                  // Show a message when download is complete
                  Utils.showToast("Invoice downloaded to $savePath");

                  // Open the file using open_file package
                  await OpenFile.open(
                      savePath); // This will open the downloaded file
                } catch (e) {
                  // Handle any errors that occur during the download
                  Utils.showToast("Failed to download the invoice: $e");
                }
              } else {
                Utils.showToast("No invoice URL found.");
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/svg/invoice.svg",
                  height: 22,
                ),
                wBox(10),
                Text(
                  "Download Invoice",
                  style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: AppColors.black,
                  size: 18.h,
                )
              ],
            )),
      // hBox(15),
      // CustomOutlinedButton(
      //     padding: EdgeInsets.symmetric(horizontal: 20),
      //     onPressed: () {},
      //     child: Row(
      //       children: [
      //         SvgPicture.asset(
      //           "assets/svg/delete-outlined.svg",
      //           height: 22,
      //         ),
      //         wBox(10),
      //         Text(
      //           "Cancel Order",
      //           style: AppFontStyle.text_14_400(AppColors.darkText),
      //         ),
      //         const Spacer(),
      //         Icon(
      //           Icons.arrow_forward_ios_sharp,
      //           color: AppColors.black,
      //           size: 18.h,
      //         )
      //       ],
      //     )),
      hBox(15),
      // CustomElevatedButton(
      //   onPressed: () {},
      //   text: "Continue Shopping",
      // )
    ]);
  }

  Future<dynamic> cancelPopUp({ required String oderId ,required String id}) {
    return showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog.adaptive(
              surfaceTintColor: AppColors.transparent,
              backgroundColor: AppColors.white,
              content: Container(
                height: 150.h,
                width: 320.w,
                padding: REdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cancel',
                      style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                    ),
                    // hBox(15),
                    Text(
                      'Are you sure you want to cancel?',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                    ),
                    // hBox(15),
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            height: 40.h,
                            color: AppColors.black,
                            onPressed: () {
                              Get.back();
                            },
                            text: "No",
                            textStyle:
                            AppFontStyle.text_14_400(AppColors.white,family: AppFontFamily.gilroyMedium),
                          ),
                        ),
                        wBox(15),
                        Expanded(
                          child: Obx(
                                () => CustomElevatedButton(
                              isLoading: (cancelOrderController
                                  .rxRequestStatus.value ==
                                  Status.LOADING),
                              height: 40.h,
                              onPressed: () async{
                                final success =  await cancelOrderController.cancelOrderApi(orderId: id);
                                  if (success) {
                                    controller.orderDetailsApi(orderId: id,isShowLoading: false);
                                  }
                              },
                              text: "Yes",
                              textStyle:
                              AppFontStyle.text_14_400(AppColors.white,family: AppFontFamily.gilroyMedium),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

}
