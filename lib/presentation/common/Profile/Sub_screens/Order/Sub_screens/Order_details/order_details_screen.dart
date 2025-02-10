import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_expansion_tile.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/Sub_screens/Order_details/order_details_controller.dart';

class OrderDetailsScreen extends StatelessWidget {
  OrderDetailsScreen({super.key});

  final OrderDetailsController controller = Get.put(OrderDetailsController());

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final id = arguments['order_id'];
    // final vendorId = arguments['vendor_id'];
    // final type = arguments['type'];

    print('Order ID: $orderId');
    // print('Vendor ID: $vendorId');
    // print('Type: $type');
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Order Details",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child: circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet') {
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
                  padding: REdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      heading(),
                      hBox(30),
                      orderDetails(),
                      hBox(20),
                      orderId(),
                      hBox(20),
                      paymentDetails(),
                      hBox(20),
                      buttons(),
                      hBox(50)
                    ],
                  )),
            );
        }
      }),
    );
  }

  Widget heading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.ordersData.value.addressDetails!.fullName
              .toString()
              .capitalize!,
          style: AppFontStyle.text_28_600(AppColors.darkText),
        ),
        hBox(20),
        Wrap(
          children: [
            Text(
              "Thank you for your order! We'll keep you updated on its arrival.",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
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
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                controller.ordersData.value.orderDetails!.orderId.toString(),
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Status",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                controller.ordersData.value.orderDetails!.status
                    .toString()
                    .capitalize!,
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking id",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                controller.ordersData.value.orderDetails!.trackingId.toString(),
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order placed",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                controller.ordersData.value.orderDetails!.createdAt.toString(),
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.ordersData.value.orderDetails!.type
                    .toString()
                    .capitalizeFirst!,
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              wBox(10),
              Flexible(
                child: Text(
                  controller.ordersData.value.orderDetails!.vendorName
                      .toString(),
                  maxLines: 2,
                  style: AppFontStyle.text_12_600(AppColors.darkText),
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
                style: AppFontStyle.text_14_600(AppColors.darkText),
              ),
              Text(
                "\$${controller.ordersData.value.orderDetails!.total.toString()}",
                style: AppFontStyle.text_14_600(AppColors.primary),
              ),
            ],
          ),
          hBox(10),
          const Divider(),
          hBox(10),
          Text(
            "Delivery Address",
            style: AppFontStyle.text_18_600(AppColors.darkText),
          ),
          hBox(10),
          Text(
            controller.ordersData.value.addressDetails!.addressType
                .toString()
                .capitalize!,
            style: AppFontStyle.text_14_400(AppColors.primary),
          ),
          hBox(10),
          Text(
            controller.ordersData.value.addressDetails!.fullName
                .toString()
                .capitalize!,
            style: AppFontStyle.text_14_600(AppColors.darkText),
          ),
          hBox(10),
          Text(
            controller.ordersData.value.addressDetails!.address.toString(),
            maxLines: 4,
            style: AppFontStyle.text_12_400(AppColors.lightText),
          ),
          hBox(10),
          Text(
            "${controller.ordersData.value.addressDetails!.countryCode} ${controller.ordersData.value.addressDetails!.phoneNumber.toString()}",
            style: AppFontStyle.text_14_600(AppColors.darkText),
          ),
          hBox(15),
        ],
      ),
    );
  }

  Widget orderId() {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color: AppColors.textFieldBorder)),
        child: CustomExpansionTile(
          title:
              "Order Id ${controller.ordersData.value.orderDetails!.orderId.toString()}",
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller
                  .ordersData.value.orderDetails!.decodedAttribute!.length,
              itemBuilder: (context, index) {
                final item = controller
                    .ordersData.value.orderDetails!.decodedAttribute![index];
                return Column(
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: item.productImage.toString(),
                          height: 100.h,
                          width: 100.h,
                          fit: BoxFit.fill,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName.toString(),
                              style:
                                  AppFontStyle.text_14_600(AppColors.darkText),
                            ),
                            hBox(10),
                            Text(
                              "Qty:${item.quantity.toString()}",
                              style:
                                  AppFontStyle.text_12_400(AppColors.darkText),
                            ),
                            hBox(10),
                            Text(
                              "\$${item.price.toString()}",
                              style:
                                  AppFontStyle.text_14_600(AppColors.primary),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (item.attribute!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: SizedBox(
                          width: Get.width,
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 2.w,
                            runSpacing: 2.w,
                            children: List.generate(
                              item.attribute!.length,
                              (addonIndex) {
                                bool isLast =
                                    addonIndex == item.attribute!.length - 1;
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${item.attribute![addonIndex].itemDetails!.itemName}',
                                      style: AppFontStyle.text_12_400(
                                          AppColors.primary),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      ' - ',
                                      style: AppFontStyle.text_12_400(
                                          AppColors.primary),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      '\$${item.attribute![addonIndex].itemDetails!.itemPrice}',
                                      style: AppFontStyle.text_12_400(
                                          AppColors.primary),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    if (!isLast)
                                      Text(
                                        ',',
                                        style: AppFontStyle.text_12_400(
                                            AppColors.primary),
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
                    if (item.addons!.isNotEmpty)
                      SizedBox(
                        width: Get.width,
                        child: Wrap(
                          direction: Axis.horizontal,
                          spacing: 2.w,
                          runSpacing: 2.w,
                          children: List.generate(
                            item.addons!.length,
                            (addonIndex) {
                              bool isLast =
                                  addonIndex == item.addons!.length - 1;
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${item.addons![addonIndex].name}',
                                    style: AppFontStyle.text_12_400(
                                        AppColors.lightText),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    ' - ',
                                    style: AppFontStyle.text_12_400(
                                        AppColors.lightText),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    '\$${item.addons![addonIndex].price}',
                                    style: AppFontStyle.text_12_400(
                                        AppColors.lightText),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  if (!isLast)
                                    Text(
                                      ',',
                                      style: AppFontStyle.text_12_400(
                                          AppColors.lightText),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
            hBox(0.h),
            Divider(),
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
            if(controller.ordersData.value.orderDetails!.coupon != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Coupon Discount",
                  style: AppFontStyle.text_12_400(AppColors.lightText),
                ),
                Text(
                  controller.ordersData.value.orderDetails!.coupon!.discountType
                              .toString() ==
                          "percent"
                      ? "${controller.ordersData.value.orderDetails!.coupon!.discountAmount.toString()}%"
                      : "\$${controller.ordersData.value.orderDetails!.coupon!.discountAmount.toString()}",
                  style: AppFontStyle.text_12_600(AppColors.darkText),
                ),
              ],
            ),
            if(controller.ordersData.value.orderDetails!.coupon != null)
            hBox(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Delivery Charge",
                  style: AppFontStyle.text_12_400(AppColors.lightText),
                ),
                Text(
                  "\$${controller.ordersData.value.deliveryCharges.toString()}",
                  style: AppFontStyle.text_12_600(AppColors.darkText),
                ),
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
                  style: AppFontStyle.text_14_600(AppColors.darkText),
                ),
                Text(
                  "\$${controller.ordersData.value.orderDetails!.total.toString()}",
                  style: AppFontStyle.text_14_600(AppColors.primary),
                ),
              ],
            ),
            hBox(15),
          ],
        ));
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
              style: AppFontStyle.text_12_400(AppColors.lightText),
            ),
            Text(
              controller.ordersData.value.orderDetails!.paymentMethod
                  .toString()
                  .characters
                  .toString()
                  .capitalize!,
              style: AppFontStyle.text_12_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10),
        if (controller.ordersData.value.orderDetails!.walletUsed.toString() !=
            "0")
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wallet",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "\$${controller.ordersData.value.orderDetails!.walletUsed.toString()}",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
        if (controller.ordersData.value.orderDetails!.walletUsed.toString() !=
            "0")
          hBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Payment Date",
              style: AppFontStyle.text_12_400(AppColors.lightText),
            ),
            Text(
              controller.ordersData.value.orderDetails!.createdAt.toString(),
              style: AppFontStyle.text_12_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: AppFontStyle.text_12_400(AppColors.lightText),
            ),
            Text(
              "\$${controller.ordersData.value.orderDetails!.total.toString()}",
              style: AppFontStyle.text_12_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(15)
      ]),
    );
  }

  Widget buttons() {
    return Column(children: [
      CustomOutlinedButton(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          onPressed: () {},
          child: Row(
            children: [
              SvgPicture.asset(
                "assets/svg/invoice.svg",
                height: 22,
              ),
              wBox(10),
              Text(
                "Download Invoice",
                style: AppFontStyle.text_14_400(AppColors.darkText),
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
}
