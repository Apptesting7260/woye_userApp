import 'package:woye_user/Core/Utils/app_export.dart';

import '../../../../../../../Data/components/GeneralException.dart';
import '../../../../../../../Data/components/InternetException.dart';
import '../../../../../../../Shared/Widgets/CircularProgressIndicator.dart';
import '../../../../../../../shared/theme/font_family.dart';
import 'controller/track_order_controller.dart';

class TrackOrderScreen extends StatelessWidget {
  TrackOrderScreen({super.key});

  final TrackOrderController  controller = Get.put(TrackOrderController());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments ?? {};
    String cartType = arguments['type'] ?? "";
    String screenType = arguments['screenType'] ?? "";
    String orderId = arguments['id'] ?? "";
    print("sdgf >> $cartType  >>  $screenType  >>  $orderId");
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Track Order",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
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
                  controller.trackOrder(orderNo: controller.orderId.value);
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.trackOrder(orderNo: controller.orderId.value);
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
                onRefresh: () async {
                  controller.trackOrder(orderNo: controller.orderId.value);
                },
                child: SingleChildScrollView(
                  padding: REdgeInsets.symmetric(horizontal: 22),
                  child:Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        deliveryBoyProfile(),
                        hBox(15),
                        map(),
                        hBox(20),
                        orderDetails(),
                        hBox(20),
                        orderPlaced(),
                        hBox(20),
                        // if(controller.apiData.value.orderDetails?.status == "in_progress" || controller.apiData.value.orderDetails?.status == "completed")...[
                          orderConfirmed(),
                          hBox(20),
                        // ],
                        // if(controller.apiData.value.orderDetails?.status == "completed")
                        onItsWay(),
                        hBox(20),
                        addressBar(),
                        hBox(20),
                        orderButton(cartType,screenType),
                        hBox(50)
                      ],
                    ),
                  ),
                );
        }
      })
    );
  }

  Widget deliveryBoyProfile() {
    String phoneNumber = "+791 12 123 1234";
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.primary.withOpacity(0.1)),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35.r,
            child: Image.asset(
              "assets/images/profile-image.png",
              // height: 80.h,
            ),
          ),
          wBox(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "David Ronney",
                textAlign: TextAlign.center,
                style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
              ),
              hBox(10),
              Text(
                phoneNumber,
                textAlign: TextAlign.center,
                style: AppFontStyle.text_15_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
              )
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              controller.makePhoneCall(phoneNumber);
            },
            child: CircleAvatar(
              radius: 20.r,
              child: SvgPicture.asset(
                "assets/svg/call.svg",
                // height: 20,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget map() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.r),
      child: Image.asset(
        "assets/images/map.png",
        height: 200.h,
      ),
    );
  }

  Widget orderDetails() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                "Transit Time",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
              ),
              hBox(8),
              Text(
                "20 Minutes",
                style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
              ),
            ],
          ),
          const VerticalDivider(),
          Column(
            children: [
              Text(
                "Order id",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
              ),
              hBox(8),
              Obx(
                ()=> Text(
                  controller.apiData.value.orderDetails?.orderId ?? "",
                  style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget orderPlaced() {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.primary)),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                height: 25.h,
                width: 25.h,
                decoration: BoxDecoration(
                    color: AppColors.primary, shape: BoxShape.circle),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18.w,
                ),
              )
              //  SvgPicture.asset("assets/svg/check.svg")
              ),
          wBox(10),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Placed",
                  style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
                ),
                hBox(8),
                Obx(
                    ()=> Text(
                    "We have received your order at ${controller.convertToTime(controller.apiData.value.orderDetails?.createdAt.toString() ?? "")}",
                    style: AppFontStyle.text_13_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget orderConfirmed() {
    return Obx(
      ()=> Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color:controller.apiData.value.orderDetails?.status == "in_progress"
                || controller.apiData.value.orderDetails?.status == "completed" ? AppColors.primary :AppColors.lightPrimary,
            ),
        ),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: BoxDecoration(
                    color: controller.apiData.value.orderDetails?.status == "in_progress" ||
                    controller.apiData.value.orderDetails?.status == "completed" ?
                    AppColors.primary : AppColors.primary.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 18.w,
                  ),
                )),
            wBox(10),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Confirmed",
                    style: AppFontStyle.text_16_400( controller.apiData.value.orderDetails?.status == "in_progress" ||
                        controller.apiData.value.orderDetails?.status == "completed" ? AppColors.darkText : AppColors.darkText.withOpacity(0.3)
                        ,family: AppFontFamily.gilroySemiBold
                    ),
                  ),
                  hBox(8),
                  Text(
                    "Your order has been confirmed at ${ controller.apiData.value.orderDetails?.status == "in_progress" ||
                        controller.apiData.value.orderDetails?.status == "completed" ?
                    controller.convertToTime(controller.apiData.value.orderDetails?.createdAt.toString() ?? "") : "..."}",
                    style: AppFontStyle.text_13_400( controller.apiData.value.orderDetails?.status == "in_progress" ||
                        controller.apiData.value.orderDetails?.status == "completed" ? AppColors.lightText : AppColors.lightText.withOpacity(.4),family: AppFontFamily.gilroyRegular),
                    maxLines: 2,
                  ),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget onItsWay() {
    return Obx(
      ()=> Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color:controller.apiData.value.orderDetails?.status == "in_progress"
                || controller.apiData.value.orderDetails?.status == "completed" ? AppColors.primary :AppColors.lightPrimary,)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 30.h,
                  width: 30.h,
                  decoration: BoxDecoration(
                      color: AppColors.white, shape: BoxShape.circle),
                  child: Icon(
                    Icons.access_time_filled_sharp,
                    color:controller.apiData.value.orderDetails?.status == "in_progress"
                        || controller.apiData.value.orderDetails?.status == "completed" ? AppColors.primary :AppColors.lightPrimary,                  size: 30.w,
                  ),
                )),
            wBox(10),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "On its way",
                    style: AppFontStyle.text_16_400(controller.apiData.value.orderDetails?.status == "in_progress"
                        || controller.apiData.value.orderDetails?.status == "completed" ? AppColors.darkText :AppColors.darkText.withOpacity(0.4),family: AppFontFamily.gilroySemiBold),
                  ),
                  hBox(8),
                  Text(
                    "Store Location | 09:15 AM",
                    style: AppFontStyle.text_13_400(controller.apiData.value.orderDetails?.status == "in_progress"
                        || controller.apiData.value.orderDetails?.status == "completed" ? AppColors.lightText :AppColors.lightText.withOpacity(0.4),family: AppFontFamily.gilroyRegular),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addressBar() {
    return Obx(
      ()=> Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(color:controller.apiData.value.orderDetails?.status == "completed" ? AppColors.primary : AppColors.lightPrimary)),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  height: 30.h,
                  width: 30.h,
                  decoration: BoxDecoration(
                      color: AppColors.white, shape: BoxShape.circle),
                  child: Icon(
                    Icons.location_pin,
                    color: AppColors.primary,
                    size: 30.w,
                  ),
                )),
            wBox(10),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.apiData.value.orderDetails?.addressDetails?.addressType.toString() ?? "",
                    style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
                  ),
                  hBox(8),
                  Text(
                    "${controller.apiData.value.orderDetails?.addressDetails?.address.toString() ?? ""} ,"
                        "${controller.apiData.value.orderDetails?.addressDetails?.houseDetails.toString() ?? ""}",
                    style: AppFontStyle.text_13_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                    maxLines: 5,
                  ),
                  // Text(
                  // // | 09:20 AM
                  //   controller.apiData.value.orderDetails?.addressDetails?.houseDetails.toString() ?? "",
                  //   style: AppFontStyle.text_14_400(AppColors.lightText),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget orderButton(String? cartType,String screenType) {
    return CustomElevatedButton(
          // color: controller.apiData.value.orderDetails?.status == "completed" ? AppColors.primary : AppColors.primary.withOpacity(0.4)  ,
          color: AppColors.primary,
          fontFamily: AppFontFamily.gilroyMedium,
          text: "Order Received",
          onPressed: () {
            // if(controller.apiData.value.orderDetails?.status == "completed") {
              Get.offNamed(AppRoutes.orderReveived,
                  arguments: {'type': cartType,"screenType" : screenType}
              );
            // }
            // else{
            //   Utils.showToast("Your order is not delivered yet. Please wait for it to be delivered.");
            // }
          },
    );
  }
}
