import 'package:woye_user/Core/Utils/app_export.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Track Order",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
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
            orderConfirmed(),
            hBox(20),
            onItsWay(),
            hBox(20),
            addressBar(),
            hBox(20),
            orderButton(),
            hBox(50)
          ],
        ),
      ),
    );
  }

  Widget deliveryBoyProfile() {
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
                style: AppFontStyle.text_18_400(AppColors.darkText),
              ),
              hBox(10),
              Text(
                "+791 12 123 1234",
                textAlign: TextAlign.center,
                style: AppFontStyle.text_14_400(AppColors.lightText),
              )
            ],
          ),
          const Spacer(),
          CircleAvatar(
            radius: 20.r,
            child: SvgPicture.asset(
              "assets/svg/call.svg",
              // height: 20,
              fit: BoxFit.cover,
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
                style: AppFontStyle.text_14_400(AppColors.lightText),
              ),
              hBox(8),
              Text(
                "20 Minutes",
                style: AppFontStyle.text_16_600(AppColors.darkText),
              ),
            ],
          ),
          const VerticalDivider(),
          Column(
            children: [
              Text(
                "Order id",
                style: AppFontStyle.text_14_400(AppColors.lightText),
              ),
              hBox(8),
              Text(
                "#1947034",
                style: AppFontStyle.text_16_600(AppColors.darkText),
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
                  style: AppFontStyle.text_16_600(AppColors.darkText),
                ),
                hBox(8),
                Text(
                  "We have received your order at 09:00 AM",
                  style: AppFontStyle.text_14_400(AppColors.lightText),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget orderConfirmed() {
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
              )),
          wBox(10),
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Confirmed",
                  style: AppFontStyle.text_16_600(AppColors.darkText),
                ),
                hBox(8),
                Text(
                  "Your order has been confirmed at 09:10 AM",
                  style: AppFontStyle.text_14_400(AppColors.lightText),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget onItsWay() {
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
                height: 30.h,
                width: 30.h,
                decoration: BoxDecoration(
                    color: AppColors.white, shape: BoxShape.circle),
                child: Icon(
                  Icons.access_time_filled_sharp,
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
                  "On its way",
                  style: AppFontStyle.text_16_600(AppColors.darkText),
                ),
                hBox(8),
                Text(
                  "Store Location | 09:15 AM",
                  style: AppFontStyle.text_14_400(AppColors.lightText),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget addressBar() {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.lightPrimary)),
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
                  "Home",
                  style: AppFontStyle.text_16_600(AppColors.darkText),
                ),
                hBox(8),
                Text(
                  "888 Abc Road, Greenfield, Abc manchester,",
                  style: AppFontStyle.text_14_400(AppColors.lightText),
                ),
                Text(
                  "199 | 09:20 AM",
                  style: AppFontStyle.text_14_400(AppColors.lightText),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget orderButton() {
    return CustomElevatedButton(
        color: AppColors.lightPrimary,
        text: "Order Received",
        onPressed: () {
          Get.toNamed(AppRoutes.orderReveived);
        });
  }
}
