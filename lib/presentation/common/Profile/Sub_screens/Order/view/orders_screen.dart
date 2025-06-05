
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_details/order_details_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/cancel_order/cancel_order_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/controller/order_screen_controller.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrderScreenController controller = Get.put(OrderScreenController());

  final OrderDetailsController orderDetailsController = Get.put(OrderDetailsController());

  final CancelOrderController cancelOrderController = Get.put(CancelOrderController());

  @override
  void initState() {
    controller.getOrdersListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments ?? {};
    if (arguments['pageIndex'] != null && arguments['pageIndex'] is int) {
     controller.pageIndex = arguments['pageIndex'] as int;
    }else{
      controller.pageIndex = 0;
    }
    controller.screenType = arguments['screenType'] ?? "";
    pt("screenTypeOrder screen : ${controller.screenType}");
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Orders",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child: circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet' || controller.error.value == 'InternetExceptionWidget') {
              return InternetExceptionWidget(
                onPress: () {
                  controller.refreshOrdersListApi();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.refreshOrdersListApi();
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.refreshOrdersListApi();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 5),
                child: GetBuilder(
                    init: OrderScreenController(),
                    builder: (orderScreenController) {
                      return Column(
                        children: [
                          orderStatusList(orderScreenController),
                          hBox(30.h),
                          IndexedStack(
                            index: orderScreenController.pageIndex,
                            children: [
                              allOrders(context),
                              waitingForDelivery(context),
                              delivered(),
                              cancelled(),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
            );
        }
      }),
    );
  }

  Widget orderStatusList(OrderScreenController orderScreenController) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
          controller: orderScreenController.scrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 4,
          itemBuilder: (c, i) {
            List buttonNames = [
              "All Orders",
              "Waiting for delivery",
              "Delivered",
              "Cancelled"
            ];
            bool isSelected = orderScreenController.pageIndex == i;
            return GestureDetector(
              onTap: () {
                orderScreenController.getIndex(i);
              },
              child: AnimatedContainer(
                // key: orderScreenController.tabKeys[i],
                duration: const Duration(microseconds: 500),
                curve: Curves.easeInOut,
                padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    color:
                        isSelected ? AppColors.primary : AppColors.lightPrimary,
                    borderRadius: BorderRadius.circular(50.r)),
                child: Center(
                  child: Text(
                    buttonNames[i],
                    style: AppFontStyle.text_15_400(
                        isSelected ? AppColors.white : AppColors.black,family: AppFontFamily.gilroyMedium),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (c, i) => wBox(10)),
    );
  }

  Widget allOrders(BuildContext context) {
    var height = Get.height;
    var weight = Get.width;
    return Obx(() {
      if (controller.ordersData.value.orders?.isEmpty ?? true) {
        return Center(
          child: Text(
            "No orders available",
            style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyMedium),
          ),
        );
      }

      return Container(
        height: height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: controller.ordersData.value.orders?.length ?? 0,
                itemBuilder: (context, index) {
                  var order = controller.ordersData.value.orders![index];
                  return Container(
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: AppColors.textFieldBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("orderId $order.id.toString()");

                            final arguments = {
                              'order_id': order.id.toString(),
                            };
                            Get.toNamed(
                              AppRoutes.orderDetails,
                              arguments: arguments,
                            );
                            orderDetailsController.orderDetailsApi(
                                orderId: order.id.toString());
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius : BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: order
                                      .decodedAttribute![0].productImage
                                      .toString(),
                                  height: 100.h,
                                  width: 100.h,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
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
                              ),
                              wBox(15.h),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      order.decodedAttribute![0].productName.toString(),
                                      style: AppFontStyle.text_14_600(
                                          AppColors.darkText,family: AppFontFamily.gilroyRegular),
                                    ),
                                    hBox(10),
                                    Text(
                                      "Qty:${order.decodedAttribute![0].quantity.toString()}",
                                      style: AppFontStyle.text_12_400(
                                          AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        hBox(15),
                        buildOrderDetailRow(
                            "Order id", order.orderId.toString()),
                        buildOrderDetailRow(
                            "Tracking number:", order.trackingId.toString()),
                        buildOrderDetailRow(order.type.toString().capitalize!,
                            order.vendorName.toString()),
                        buildOrderDetailRow(
                            "Date & Time", order.createdAt.toString()),
                        buildOrderDetailRow(
                          "Status",
                          order.status
                              .toString()
                              .replaceAll("_", " ")
                              .capitalize!,
                        ),
                        hBox(15),
                        buildTotalAmountRow(order.total.toString()),
                        hBox(20),
                        buildDeliveryTimeRow(),
                        hBox(10),
                        buildActionButtons(
                          context: context,
                          orderId: order.id.toString(),
                          orderStatus: order.status.toString(),
                          type: order.type.toString(),
                          vendorId: order.vendorId.toString(),
                          reviews: order.review,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return hBox(10);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget waitingForDelivery(context) {
    return Obx(() {
      if (controller.ordersData.value.waitingOrders?.isEmpty ?? true) {
        return Center(
          child: Text(
            "No orders available", // Custom message when there are no orders
            style: AppFontStyle.text_14_600(AppColors.darkText),
          ),
        );
      }
      return Container(
        height: Get.height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                // To prevent scrolling here
                itemCount:
                    controller.ordersData.value.waitingOrders?.length ?? 0,
                itemBuilder: (context, index) {
                  var order = controller.ordersData.value.waitingOrders![index];

                  return Container(
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: AppColors.textFieldBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("orderId $order.id.toString()");

                            final arguments = {
                              'order_id': order.id.toString(),
                            };
                            Get.toNamed(
                              AppRoutes.orderDetails,
                              arguments: arguments,
                            );
                            orderDetailsController.orderDetailsApi(
                                orderId: order.id.toString());
                          },
                          child: GestureDetector(
                            onTap: () {
                              print("orderId $order.id.toString()");

                              final arguments = {
                                'order_id': order.id.toString(),
                              };
                              Get.toNamed(
                                AppRoutes.orderDetails,
                                arguments: arguments,
                              );
                              orderDetailsController.orderDetailsApi(
                                  orderId: order.id.toString());
                            },
                            child: GestureDetector(
                              onTap: () {
                                print("orderId $order.id.toString()");

                                final arguments = {
                                  'order_id': order.id.toString(),
                                };
                                Get.toNamed(
                                  AppRoutes.orderDetails,
                                  arguments: arguments,
                                );
                                orderDetailsController.orderDetailsApi(
                                    orderId: order.id.toString());
                              },
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: order
                                        .decodedAttribute![0].productImage
                                        .toString(),
                                    height: 100.h,
                                    width: 100.h,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order.decodedAttribute![0].productName
                                              .toString(),
                                          style: AppFontStyle.text_14_600(
                                              AppColors.darkText),
                                        ),
                                        hBox(10),
                                        Text(
                                          "Qty:${order.decodedAttribute![0].quantity.toString()}",
                                          style: AppFontStyle.text_12_400(
                                              AppColors.darkText),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        hBox(15),
                        buildOrderDetailRow(
                            "Order id", order.orderId.toString()),
                        buildOrderDetailRow(
                            "Tracking number:", order.trackingId.toString()),
                        buildOrderDetailRow(order.type.toString().capitalize!,
                            order.vendorName.toString()),
                        buildOrderDetailRow(
                            "Date & Time", order.createdAt.toString()),
                        buildOrderDetailRow(
                          "Status",
                          order.status
                              .toString()
                              .replaceAll("_", " ")
                              .capitalize!,
                        ),
                        hBox(15),
                        buildTotalAmountRow(order.total.toString()),
                        hBox(20),
                        buildDeliveryTimeRow(),
                        hBox(10),
                        buildActionButtons(
                          context: context,
                          orderId: order.id.toString(),
                          orderStatus: order.status.toString(),
                          type: order.type.toString(),
                          vendorId: order.vendorId.toString(),
                          reviews: order.review,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return hBox(10);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget delivered() {
    return Obx(() {
      if (controller.ordersData.value.deliveredOrders?.isEmpty ?? true) {
        return Center(
          child: Text(
            "No orders available", // Custom message when there are no orders
            style: AppFontStyle.text_14_600(AppColors.darkText),
          ),
        );
      }
      return Container(
        height: Get.height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                // To prevent scrolling here
                itemCount:
                    controller.ordersData.value.deliveredOrders?.length ?? 0,
                itemBuilder: (context, index) {
                  var order =
                      controller.ordersData.value.deliveredOrders![index];

                  return Container(
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: AppColors.textFieldBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("orderId $order.id.toString()");

                            final arguments = {
                              'order_id': order.id.toString(),
                            };
                            Get.toNamed(
                              AppRoutes.orderDetails,
                              arguments: arguments,
                            );
                            orderDetailsController.orderDetailsApi(
                                orderId: order.id.toString());
                          },
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: order
                                    .decodedAttribute![0].productImage
                                    .toString(),
                                height: 100.h,
                                width: 100.h,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
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
                                      order.decodedAttribute![0].productName
                                          .toString(),
                                      style: AppFontStyle.text_14_600(
                                          AppColors.darkText),
                                    ),
                                    hBox(10),
                                    Text(
                                      "Qty:${order.decodedAttribute![0].quantity.toString()}",
                                      style: AppFontStyle.text_12_400(
                                          AppColors.darkText),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        hBox(15),
                        buildOrderDetailRow(
                            "Order id", order.orderId.toString()),
                        buildOrderDetailRow(
                            "Tracking number:", order.trackingId.toString()),
                        buildOrderDetailRow(order.type.toString().capitalize!,
                            order.vendorName.toString()),
                        buildOrderDetailRow(
                            "Date & Time", order.createdAt.toString()),
                        buildOrderDetailRow(
                          "Status",
                          order.status
                              .toString()
                              .replaceAll("_", " ")
                              .capitalize!,
                        ),
                        hBox(15),
                        buildTotalAmountRow(order.total.toString()),
                        hBox(20),
                        buildDeliveryTimeRow(),
                        hBox(10),
                        buildActionButtons(
                          context: context,
                          orderId: order.id.toString(),
                          orderStatus: order.status.toString(),
                          type: order.type.toString(),
                          vendorId: order.vendorId.toString(),
                          reviews: order.review,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return hBox(10.h);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget cancelled() {
    return Obx(() {
      if (controller.ordersData.value.cancelOrders?.isEmpty ?? true) {
        return Center(
          child: Text(
            "No orders available",
            style: AppFontStyle.text_14_600(AppColors.darkText),
          ),
        );
      }
      return Container(
        height: Get.height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount:
                    controller.ordersData.value.cancelOrders?.length ?? 0,
                itemBuilder: (context, index) {
                  var order = controller.ordersData.value.cancelOrders![index];
                  return Container(
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(color: AppColors.textFieldBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("orderId $order.id.toString()");

                            final arguments = {
                              'order_id': order.id.toString(),
                            };
                            Get.toNamed(
                              AppRoutes.orderDetails,
                              arguments: arguments,
                            );
                            orderDetailsController.orderDetailsApi(
                                orderId: order.id.toString());
                          },
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                imageUrl: order
                                    .decodedAttribute![0].productImage
                                    .toString(),
                                height: 100.h,
                                width: 100.h,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
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
                                      order.decodedAttribute![0].productName
                                          .toString(),
                                      style: AppFontStyle.text_14_600(
                                          AppColors.darkText),
                                    ),
                                    hBox(10.h),
                                    Text(
                                      "Qty:${order.decodedAttribute![0].quantity.toString()}",
                                      style: AppFontStyle.text_12_400(
                                          AppColors.darkText),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        hBox(15.h),
                        buildOrderDetailRow(
                            "Order id", order.orderId.toString()),
                        buildOrderDetailRow(
                            "Tracking number:", order.trackingId.toString()),
                        buildOrderDetailRow(order.type.toString().capitalize!,
                            order.vendorName.toString()),
                        buildOrderDetailRow(
                            "Date & Time", order.createdAt.toString()),
                        buildOrderDetailRow(
                            "Status",
                            order.status
                                .toString()
                                .replaceAll("_", " ")
                                .capitalize!),
                        hBox(15),
                        buildTotalAmountRow(order.total.toString()),
                        hBox(20),
                        buildDeliveryTimeRow(),
                        hBox(10),
                        buildActionButtons(
                          context: context,
                          orderId: order.id.toString(),
                          orderStatus: order.status.toString(),
                          type: order.type.toString(),
                          vendorId: order.vendorId.toString(),
                          reviews: order.review,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return hBox(10);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildOrderDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFontStyle.text_12_500(AppColors.lightText,family: AppFontFamily.gilroyMedium),
        ),
        Text(
          value,
          // style: AppFontStyle.text_12_600(AppColors.darkText),
          style: AppFontStyle.text_12_500(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
        ),
      ],
    );
  }

  Widget buildTotalAmountRow(var total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Total Amount:",
          style: AppFontStyle.text_14_500(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
        ),
        Text(
          "\$$total",
          style: AppFontStyle.text_14_500(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
        ),
      ],
    );
  }

  Widget buildDeliveryTimeRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Your order will be delivered to you at ",
          style: AppFontStyle.text_12_500(AppColors.lightText,family: AppFontFamily.gilroyMedium),
        ),
        hBox(4),
        Text(
          "12 Apr - 10:00 AM",
          style: AppFontStyle.text_12_500(AppColors.lightText,family: AppFontFamily.gilroyMedium),
        ),
      ],
    );
  }

  Widget buildActionButtons({
    required BuildContext context,
    required String orderId,
    required String orderStatus,
    required String vendorId,
    required String type,
    required var reviews,
  }) {
    return Row(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            print("orderId $orderId");

            final arguments = {
              'order_id': orderId,
            };
            Get.toNamed(
              AppRoutes.orderDetails,
              arguments: arguments,
            );
            orderDetailsController.orderDetailsApi(orderId: orderId.toString());
          },
          child: Container(
            padding: REdgeInsets.symmetric(vertical: 10.h, horizontal: 20.h),
            decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(50.r)),
            child: Center(
              child: Text(
                "Details",
                style: AppFontStyle.text_15_400(AppColors.white,family: AppFontFamily.gilroyMedium),
              ),
            ),
          ),
        ),
        wBox(10.h),
        if (orderStatus == "pending")
          InkWell(
            onTap: () {
              cancelPopUp(oderId: orderId, context: context);
            },
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(50.r)),
              child: Center(
                child: Text(
                  "Cancel",
                  style: AppFontStyle.text_15_400(AppColors.white,family: AppFontFamily.gilroyMedium),
                ),
              ),
            ),
          ),
        wBox(10.h),
        if (orderStatus != "pending" && orderStatus != "completed" && orderStatus != "cancelled")
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              pt("orders c${controller.screenType}");
              Get.toNamed(AppRoutes.trackOrder,
                  arguments: {
                    "id" : orderId,
                    "screenType" : controller.screenType,
                  });
            },
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 9, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50.r)),
              child: Center(
                child: Text(
                  "Track",
                  style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                ),
              ),
            ),
          ),
        if (orderStatus == "completed" && reviews == null)
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              final arguments = {
                'order_id': orderId,
                'vendor_id': vendorId,
                'type': type,
                'reply': "null",
                "raring": "0",
                "from": "order"
              };
              Get.toNamed(
                AppRoutes.rateAndReviewProductScreen,
                arguments: arguments,
              );
            },
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 9, horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50.r)),
              child: Center(
                child: Text(
                  "Rate & Review",
                  style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Future<dynamic> cancelPopUp({context, required String oderId}) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog.adaptive(
              content: Container(
                height: 150.h,
                width: 320.w,
                padding: REdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cancel',
                      style: AppFontStyle.text_18_600(AppColors.darkText),
                    ),
                    // hBox(15),
                    Text(
                      'Are you sure you want to cancel?',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: AppFontStyle.text_14_400(AppColors.lightText),
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
                                AppFontStyle.text_14_400(AppColors.darkText),
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
                              onPressed: () {
                                cancelOrderController.cancelOrderApi(
                                    orderId: oderId);
                              },
                              text: "Yes",
                              textStyle:
                                  AppFontStyle.text_14_400(AppColors.darkText),
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
