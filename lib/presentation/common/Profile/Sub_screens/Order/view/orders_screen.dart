
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Add_to_Cart/addtocartcontroller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_details/order_details_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/cancel_order/cancel_order_controller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/controller/order_screen_controller.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/custom_no_data_found.dart';
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
  final AddToCartController addToCartController = Get.put(AddToCartController());

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
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.onestSemiBold),
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
            return  SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 5),
                child: GetBuilder(
                    init: OrderScreenController(),
                    builder: (orderScreenController) {
                      return RefreshIndicator(
                        onRefresh: () async{
                          await controller.refreshOrdersListApi();
                        },
                        child: Column(
                          children: [
                            orderStatusList(orderScreenController),
                            hBox(27.h),
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
                        ),
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
      height: 40.h,
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
                padding: REdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                    color:isSelected ? AppColors.black : AppColors.lightText.withAlpha(50),
                    borderRadius: BorderRadius.circular(50.r)),
                child: Center(
                  child: Text(
                    buttonNames[i],
                    style: AppFontStyle.text_15_400(
                        isSelected ? AppColors.white : AppColors.black,family: AppFontFamily.onestMedium),
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
          child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                CustomNoDataFound(heightBox: hBox(0)),
              ],
            ),
          ),
        );
      }

      return SizedBox(
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
                                  imageUrl: order.decodedAttribute![0].productImage ?? "",
                                  height: 90.h,
                                  width: 90.h,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: AppColors.gray,
                                    highlightColor: AppColors.lightText,
                                    child: Container(
                                      color: AppColors.white,
                                      height: 90.h,
                                      width: 90.h,
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
                                      order.decodedAttribute?[0].productName ?? "",
                                      style: AppFontStyle.text_15_600(
                                          AppColors.darkText,family: AppFontFamily.onestRegular),
                                    ),
                                    hBox(10),
                                    Text(
                                      "Qty:${order.decodedAttribute?[0].quantity ?? ""}",
                                      style: AppFontStyle.text_13_400(
                                          AppColors.darkText,family: AppFontFamily.onestMedium),
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
                        hBox(5),
                        buildOrderDetailRow(
                            "Tracking number:", order.trackingId.toString()),
                        hBox(5),
                        buildOrderDetailRow(order.type.toString().capitalize!,
                            order.vendorName.toString()),
                        hBox(5),
                        buildOrderDetailRow("Date & Time", formatOrderDate(order.createdAt.toString())),
                        hBox(5),
                        // buildOrderDetailRow(
                        buildOrderDetailRowStatus("Status",order.status.toString().replaceAll("_", " ").capitalize ?? ''),
                        hBox(15),
                        // buildTotalAmountRow(order.ordersSubtotal.toString()),
                        buildTotalAmountRow(order.discountedTotal.toString()),
                        hBox(10),
                        buildDeliveryTimeRow(),
                        hBox(15),
                        buildActionButtons(
                          context: context,
                          orderId: order.id.toString(),
                          orderStatus: order.status.toString(),
                          type: order.type.toString(),
                          vendorId: order.vendorId.toString(),
                          reviews: order.review,
                          index: index,
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


  String formatOrderDate(String? date) {
    try {
      if (date == null || date.isEmpty) return "--";

      final parsedDate = DateTime.parse(date).toLocal();
      return DateFormat('EEE, dd MMM - hh:mm a').format(parsedDate);
    } catch (e) {
      debugPrint("Date parse error: $e");
      return "--";
    }
  }

  Widget waitingForDelivery(context) {
    return Obx(() {
      if (controller.ordersData.value.waitingOrders?.isEmpty ?? true) {
        return Center(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                CustomNoDataFound(heightBox: hBox(0)),
              ],
            ),
          ),
        );
      }
      return SizedBox(
        height: Get.height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
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
                            "Date & Time",DateFormat('dd MMMM yyyy').format(DateTime.parse(order.createdAt.toString()))),
                        // buildOrderDetailRow(
                        buildOrderDetailRowStatus(
                          "Status",
                          order.status
                              .toString()
                              .replaceAll("_", " ")
                              .capitalize!,
                        ),
                        hBox(15),
                        buildTotalAmountRow(order.discountedTotal.toString()),
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
                          index: index,
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
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                CustomNoDataFound(heightBox: hBox(0)),
              ],
            ),
          ),
        );
      }
      return SizedBox(
        height: Get.height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
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
                            "Date & Time", DateFormat('dd MMMM yyyy').format(DateTime.parse(order.createdAt.toString()))),
                        buildOrderDetailRowStatus(
                          "Status",
                          order.status
                              .toString()
                              .replaceAll("_", " ")
                              .capitalize!,
                        ),
                        hBox(15),
                        buildTotalAmountRow(order.discountedTotal.toString()),
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
                          index: index,
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
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                CustomNoDataFound(heightBox: hBox(0)),
              ],
            ),
          ),
        );
      }
      return SizedBox(
        height: Get.height * 0.7,
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
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
                                          AppColors.darkText,family: AppFontFamily.gilroyRegular),
                                    ),
                                    hBox(10.h),
                                    Text(
                                      "Qty:${order.decodedAttribute?[0].quantity.toString() ?? ""}",
                                      style: AppFontStyle.text_12_400(
                                          AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
                            "Date & Time",DateFormat('dd MMMM yyyy').format(DateTime.parse(order.createdAt.toString()))),
                        buildOrderDetailRowStatus(
                            "Status",
                            order.status
                                .toString()
                                .replaceAll("_", " ")
                                .capitalize ?? ""),
                        hBox(15),
                        buildTotalAmountRow(order.discountedTotal.toString()),
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
                          index: index,
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
          style: AppFontStyle.text_13_500(AppColors.lightText,family: AppFontFamily.onestMedium),
        ),
        Text(
          value,
          // style: AppFontStyle.text_12_600(AppColors.darkText),
          style: AppFontStyle.text_13_500(AppColors.darkText,family: AppFontFamily.onestMedium),
        ),
      ],
    );
  }

  Widget buildOrderDetailRowStatus(String label, String value) {
    Color getValueColor(String value) {
      if (value.toLowerCase() == 'pending') {
        return Colors.orange;
      } else if (value.toLowerCase() == 'cancelled') {
        return Colors.red;
      }  else if (value.toLowerCase() == "delivered") {
        return AppColors.primary;
      } else {
        return Colors.green;
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFontStyle.text_13_500(AppColors.lightText,family: AppFontFamily.onestMedium),
        ),
        Text(
          value,
          style: AppFontStyle.text_13_500(getValueColor(value),family: AppFontFamily.onestSemiBold),
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
          style: AppFontStyle.text_14_500(AppColors.darkText,family: AppFontFamily.onestSemiBold),
        ),
        Text(
          "\$$total",
          style: AppFontStyle.text_14_500(AppColors.primary,family: AppFontFamily.onestSemiBold),
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
          style: AppFontStyle.text_13_500(AppColors.lightText,family: AppFontFamily.onestMedium),
        ),
        hBox(4),
        Text(
          "12 Apr - 10:00 AM",
          style: AppFontStyle.text_13_500(AppColors.lightText,family: AppFontFamily.onestMedium),
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
    required int index,
  }) {
    return Wrap(
      spacing: 8, // horizontal gap
      runSpacing: 8, // next line gap
      children: [
        /// DETAILS
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            final arguments = {'order_id': orderId};
            Get.toNamed(AppRoutes.orderDetails, arguments: arguments);
            orderDetailsController.orderDetailsApi(orderId: orderId);
          },
          child: Container(
            padding: REdgeInsets.symmetric(vertical: 9, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(50.r),
            ),
            child: Text(
              "Details",
              style: AppFontStyle.text_15_400(
                AppColors.white,
                family: AppFontFamily.onestMedium,
              ),
            ),
          ),
        ),

        /// CANCEL
        if (orderStatus == "pending")
          InkWell(
            onTap: () {
              cancelPopUp(oderId: orderId, context: context);
            },
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColors.black),
              ),
              child: Text(
                "Cancel",
                style: AppFontStyle.text_15_400(
                  AppColors.black,
                  family: AppFontFamily.onestMedium,
                ),
              ),
            ),
          ),

        if (orderStatus == "delivered" || orderStatus == "cancelled")
          InkWell(
            onTap: () {
              controller.setSelectedIndex(index);
                final orders = controller.ordersData.value.orders;
                if (orders != null && index < orders.length) {
                  final order = orders[index];
                  // if (order.decodedAttribute?.isNotEmpty == true && order.decodedAttribute?.first.attribute?.isNotEmpty == true) {
                    final attributes = order.decodedAttribute?.first.attribute;
                    final extrasItemIds = attributes?.map((e) => e.choices?.optionId).whereType<String>().toList();

                    final extrasItemNames = attributes?.map((e) => e.choices?.name).whereType<String>().toList();

                    final extrasItemPrices = attributes?.map((e) => e.choices?.price).whereType<String>().toList();

                    addToCartController.addToCartApi(
                      isPopUp: false,
                      productId: order.orderss?.first.productId ?? "",
                      productPrice: order.orderss?.first.price ?? "",
                      productQuantity: order.orderss?.first.quantity ?? "",
                      restaurantId: order.vendorId?.toString() ?? "",
                      addons: order.decodedAttribute?.first.addons ?? [],
                      extrasItemIds: extrasItemIds ?? [],
                      extrasItemNames: extrasItemNames ?? [],
                      extrasItemPrices: extrasItemPrices ?? [],
                      extrasIds: extrasItemIds ?? [],
                      isReOrder: true,
                    );
                  // }
                }
            },
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(50.r),
                border: Border.all(color: AppColors.black),
              ),
              child:Obx(
                ()=>controller.selectedIndex.value == index &&  addToCartController.rxRequestStatus.value == Status.LOADING ?
                SizedBox(
                    height: 23,
                    width: 60,
                    child: circularProgressIndicator()) :
                Text(
                  "Re-Order",
                  style: AppFontStyle.text_15_400(
                    AppColors.black,
                    family: AppFontFamily.onestMedium,
                  ),
                ),
              ),
            ),
          ),

        /// TRACK
        if (orderStatus != "delivered" && orderStatus != "cancelled")
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.toNamed(
                AppRoutes.trackOrder,
                arguments: {
                  "id": orderId,
                  "screenType": controller.screenType,
                },
              );
            },
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                color: AppColors.white,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Text(
                "Track",
                style: AppFontStyle.text_15_400(
                  AppColors.primary,
                  family: AppFontFamily.onestMedium,
                ),
              ),
            ),
          ),

        /// RATE & REVIEW
        if (orderStatus == "delivered" && reviews == null)
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Get.toNamed(
                AppRoutes.rateAndReviewProductScreen,
                arguments: {
                  'order_id': orderId,
                  'vendor_id': vendorId,
                  'type': type,
                  'reply': "null",
                  "raring": "0",
                  "from": "order",
                },
              );
            },
            child: Container(
              padding: REdgeInsets.symmetric(vertical: 8, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                color: AppColors.white,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Text(
                "Rate & Review",
                style: AppFontStyle.text_15_400(
                  AppColors.primary,
                  family: AppFontFamily.onestMedium,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // Widget buildActionButtons({
  //   required BuildContext context,
  //   required String orderId,
  //   required String orderStatus,
  //   required String vendorId,
  //   required String type,
  //   required var reviews,
  // }) {
  //   return Wrap(
  //     children: [
  //       InkWell(
  //         splashColor: Colors.transparent,
  //         highlightColor: Colors.transparent,
  //         onTap: () {
  //           print("orderId $orderId");
  //
  //           final arguments = {
  //             'order_id': orderId,
  //           };
  //           Get.toNamed(
  //             AppRoutes.orderDetails,
  //             arguments: arguments,
  //           );
  //           orderDetailsController.orderDetailsApi(orderId: orderId.toString());
  //         },
  //         child: Container(
  //           padding: REdgeInsets.symmetric(vertical: 8.h, horizontal: 20.h),
  //           decoration: BoxDecoration(
  //               color: AppColors.black,
  //               borderRadius: BorderRadius.circular(50.r)),
  //           child: Center(
  //             child: Text(
  //               "Details",
  //               style: AppFontStyle.text_15_400(AppColors.white,family: AppFontFamily.onestMedium),
  //             ),
  //           ),
  //         ),
  //       ),
  //
  //       if (orderStatus == "pending")...[
  //         wBox(8.h),
  //         InkWell(
  //           onTap: () {
  //             cancelPopUp(oderId: orderId, context: context);
  //           },
  //           child: Container(
  //             padding: REdgeInsets.symmetric(vertical: 7, horizontal: 20),
  //             decoration: BoxDecoration(
  //                 color: AppColors.white,
  //                 borderRadius: BorderRadius.circular(50.r),
  //             border: Border.all(color: AppColors.black),
  //             ),
  //             child: Center(
  //               child: Text(
  //                 "Cancel",
  //                 style: AppFontStyle.text_15_400(AppColors.black,family: AppFontFamily.onestMedium),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //
  //       if (orderStatus == "delivered")...[
  //         wBox(8.h),
  //         InkWell(
  //           onTap: () {
  //             // cancelPopUp(oderId: orderId, context: context);
  //           },
  //           child: Container(
  //             padding: REdgeInsets.symmetric(vertical: 7, horizontal: 20),
  //             decoration: BoxDecoration(
  //                 color: AppColors.white,
  //                 borderRadius: BorderRadius.circular(50.r),
  //             border: Border.all(color: AppColors.black),
  //             ),
  //             child: Center(
  //               child: Text(
  //                 "Re-Order",
  //                 style: AppFontStyle.text_15_400(AppColors.black,family: AppFontFamily.onestMedium),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //       // if (orderStatus != "pending" && orderStatus != "completed" && orderStatus != "cancelled")
  //       if (orderStatus != "delivered"  && orderStatus != "cancelled")...[
  //         wBox(8.h),
  //         InkWell(
  //           splashColor: Colors.transparent,
  //           highlightColor: Colors.transparent,
  //           onTap: () {
  //             pt("orders c${controller.screenType}");
  //             Get.toNamed(AppRoutes.trackOrder,
  //                 arguments: {
  //                   "id" : orderId,
  //                   "screenType" : controller.screenType,
  //                 });
  //           },
  //           child: Container(
  //             padding: REdgeInsets.symmetric(vertical: 7, horizontal: 20),
  //             decoration: BoxDecoration(
  //                 border: Border.all(color: AppColors.primary),
  //                 color: AppColors.white,
  //                 borderRadius: BorderRadius.circular(50.r)),
  //             child: Center(
  //               child: Text(
  //                 "Track",
  //                 style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.onestMedium),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //       if (orderStatus == "delivered" && reviews == null)...[
  //        wBox(8.h),
  //       InkWell(
  //             splashColor: Colors.transparent,
  //           highlightColor: Colors.transparent,
  //           onTap: () {
  //             final arguments = {
  //               'order_id': orderId,
  //               'vendor_id': vendorId,
  //               'type': type,
  //               'reply': "null",
  //               "raring": "0",
  //               "from": "order"
  //             };
  //             Get.toNamed(
  //               AppRoutes.rateAndReviewProductScreen,
  //               arguments: arguments,
  //             );
  //           },
  //           child: Container(
  //             padding: REdgeInsets.symmetric(vertical: 8, horizontal: 20),
  //             decoration: BoxDecoration(
  //                 border: Border.all(color: AppColors.primary),
  //                 color: AppColors.white,
  //                 borderRadius: BorderRadius.circular(50.r)),
  //             child: Center(
  //               child: Text(
  //                 "Rate & Review",
  //                 style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.onestMedium),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ],
  //   );
  // }

  Future<dynamic> cancelPopUp({context, required String oderId}) {
    return showCupertinoModalPopup(
        context: context,
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
                              onPressed: () {
                                cancelOrderController.cancelOrderApi(orderId: oderId);
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
