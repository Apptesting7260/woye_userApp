import 'package:flutter/cupertino.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Order/controller/order_screen_controller.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Orders",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: GetBuilder(
            init: OrderScreenController(),
            builder: (orderScreenController) {
              return Column(
                children: [
                  orderStatusList(orderScreenController),
                  hBox(30),
                  IndexedStack(
                    index: orderScreenController.pageIndex,
                    children: [
                      waitingForDelivery(context),
                      delivered(),
                      cancelled()
                    ],
                  )
                ],
              );
            }),
      ),
    );
  }

  Widget orderStatusList(OrderScreenController orderScreenController) {
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (c, i) {
            List buttonNames = [
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
                    style: AppFontStyle.text_16_400(
                        isSelected ? AppColors.white : AppColors.black),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (c, i) => wBox(10)),
    );
  }

  Widget waitingForDelivery(context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    "assets/images/cat-image0.png",
                    height: 100,
                  )),
              wBox(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "McMushroom Pizza",
                    style: AppFontStyle.text_14_600(AppColors.darkText),
                  ),
                  hBox(10),
                  Text(
                    "Small",
                    style: AppFontStyle.text_12_400(AppColors.lightText),
                  ),
                  hBox(10),
                  Text(
                    "1x",
                    style: AppFontStyle.text_12_400(AppColors.darkText),
                  ),
                ],
              )
            ],
          ),
          hBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order id",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "#1947034",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking number:",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "IW3475453455",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "Mon, 04 Apr - 12:00 AM",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "Waiting for delivery",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount:",
                style: AppFontStyle.text_14_600(AppColors.darkText),
              ),
              Text(
                "\$20.00",
                style: AppFontStyle.text_14_600(AppColors.primary),
              ),
            ],
          ),
          hBox(20),
          Text(
            "Your order will be delivered to you at ",
            style: AppFontStyle.text_12_400(AppColors.lightText),
          ),
          hBox(4),
          Text(
            "12 Apr - 10:00 AM",
            style: AppFontStyle.text_12_400(AppColors.lightText),
          ),
          hBox(10),
          Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.toNamed(AppRoutes.orderDetails);
                },
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Center(
                    child: Text(
                      "Details",
                      style: AppFontStyle.text_16_400(AppColors.white),
                    ),
                  ),
                ),
              ),
              wBox(10),
              InkWell(
                onTap: () {
                  cancelPopUp(context);
                },
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: AppFontStyle.text_16_400(AppColors.white),
                    ),
                  ),
                ),
              ),
              wBox(10),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.toNamed(AppRoutes.trackOrder);
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
                      style: AppFontStyle.text_16_400(AppColors.primary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget delivered() {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    "assets/images/cat-image0.png",
                    height: 100,
                  )),
              wBox(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "McMushroom Pizza",
                    style: AppFontStyle.text_14_600(AppColors.darkText),
                  ),
                  hBox(10),
                  Text(
                    "Small",
                    style: AppFontStyle.text_12_400(AppColors.lightText),
                  ),
                  hBox(10),
                  Text(
                    "1x",
                    style: AppFontStyle.text_12_400(AppColors.darkText),
                  ),
                ],
              )
            ],
          ),
          hBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order id",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "#1947034",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking number:",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "IW3475453455",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "Mon, 04 Apr - 12:00 AM",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order id",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "#1947034",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "Delivered",
                style: AppFontStyle.text_12_400(AppColors.primary),
              ),
            ],
          ),
          hBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount:",
                style: AppFontStyle.text_14_600(AppColors.darkText),
              ),
              Text(
                "\$20.00",
                style: AppFontStyle.text_14_600(AppColors.primary),
              ),
            ],
          ),
          hBox(15),
          Text(
            "Successfully delivered. ",
            style: AppFontStyle.text_12_400(AppColors.lightText),
          ),
          hBox(10),
          Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.toNamed(AppRoutes.orderDetails);
                },
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Center(
                    child: Text(
                      "Details",
                      style: AppFontStyle.text_16_400(AppColors.white),
                    ),
                  ),
                ),
              ),
              wBox(10),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.offAll( RestaurantNavbar(
                    navbarInitialIndex: 3,
                  ));
                },
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Center(
                    child: Text(
                      "Re-Order",
                      style: AppFontStyle.text_16_400(AppColors.white),
                    ),
                  ),
                ),
              ),
              wBox(10),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.toNamed(AppRoutes.rateAndReviewProductScreen);
                },
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 9, horizontal: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        "Rate",
                        style: AppFontStyle.text_16_400(AppColors.primary),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cancelled() {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.textFieldBorder)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    "assets/images/cat-image0.png",
                    height: 100,
                  )),
              wBox(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "McMushroom Pizza",
                    style: AppFontStyle.text_14_600(AppColors.darkText),
                  ),
                  hBox(10),
                  Text(
                    "Small",
                    style: AppFontStyle.text_12_400(AppColors.lightText),
                  ),
                  hBox(10),
                  Text(
                    "1x",
                    style: AppFontStyle.text_12_400(AppColors.darkText),
                  ),
                ],
              )
            ],
          ),
          hBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order id",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "#1947034",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tracking number:",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "IW3475453455",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Date & Time",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "Mon, 04 Apr - 12:00 AM",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order id",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "#1947034",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "Cancelled",
                style: AppFontStyle.text_12_600(AppColors.red),
              ),
            ],
          ),
          hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Refund",
                style: AppFontStyle.text_12_400(AppColors.lightText),
              ),
              Text(
                "Wallet",
                style: AppFontStyle.text_12_600(AppColors.darkText),
              ),
            ],
          ),
          hBox(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount:",
                style: AppFontStyle.text_14_600(AppColors.darkText),
              ),
              Text(
                "\$20.00",
                style: AppFontStyle.text_14_600(AppColors.primary),
              ),
            ],
          ),
          hBox(15),
          Text(
            "Order canceled at:  ",
            style: AppFontStyle.text_12_400(AppColors.lightText),
          ),
          hBox(4),
          Text(
            "12 Apr - 10:00 AM",
            style: AppFontStyle.text_12_400(AppColors.lightText),
          ),
          hBox(10),
          Row(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.toNamed(AppRoutes.orderDetails);
                },
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Center(
                    child: Text(
                      "Details",
                      style: AppFontStyle.text_16_400(AppColors.white),
                    ),
                  ),
                ),
              ),
              wBox(10),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  Get.offAll( RestaurantNavbar(
                    navbarInitialIndex: 3,
                  ));
                },
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(50.r)),
                  child: Center(
                    child: Text(
                      "Re-Order",
                      style: AppFontStyle.text_16_400(AppColors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> cancelPopUp(context) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return AlertDialog.adaptive(
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
                        child: CustomElevatedButton(
                          height: 40.h,
                          onPressed: () {
                            Get.offAllNamed(AppRoutes.welcomeScreen);
                          },
                          text: "Yes",
                          textStyle:
                              AppFontStyle.text_14_400(AppColors.darkText),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
