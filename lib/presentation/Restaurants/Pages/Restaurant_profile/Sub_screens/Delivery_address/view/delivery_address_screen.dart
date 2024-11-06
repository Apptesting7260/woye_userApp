import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_profile/Sub_screens/Delivery_address/controller/delivery_address_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';

class DeliveryAddressScreen extends StatelessWidget {
  const DeliveryAddressScreen({super.key});

  static final DeliveryAddressController deliveryAddressController =
      Get.put(DeliveryAddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Delivery Address",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [addressList(), hBox(30), addAddress()],
        ),
      ),
    );
  }

  Widget addressList() {
    return GetBuilder(
        init: deliveryAddressController,
        builder: (controller) {
          return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              bool isSelected =
                  deliveryAddressController.selectedIndex == index;
              return Container(
                padding: EdgeInsets.all(20.r),
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
                      flex: 1,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          controller.selectedIndex = index;
                          controller.update();
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5.r),
                          height: 20.h,
                          width: 20.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: AppColors.primary)),
                          child: isSelected
                              ? SvgPicture.asset(
                                  "assets/svg/green-check-circle.svg")
                              : null,
                        ),
                      ),
                    ),
                    wBox(6),
                    Expanded(
                      flex: 9,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                index == 0 ? "Home" : "Office",
                                style: AppFontStyle.text_20_600(
                                    AppColors.darkText),
                              ),
                              wBox(10),
                              Text(
                                "default",
                                style: AppFontStyle.text_14_400(
                                    AppColors.lightText),
                              ),
                              const Spacer(),
                              SvgPicture.asset("assets/svg/edit.svg")
                              // SvgPicture.asset(
                              //     "assets/svg/green-check-circle.svg")
                            ],
                          ),
                          hBox(10),
                          Text(
                            "John doe",
                            style: AppFontStyle.text_14_400(AppColors.darkText),
                          ),
                          hBox(10),
                          Text(
                            "D 888 Abc Road, Greenfield, Abc Manchester, 199",
                            style:
                                AppFontStyle.text_14_400(AppColors.lightText),
                          ),
                          hBox(10),
                          Text(
                            "+791 12 123 1234",
                            style: AppFontStyle.text_14_400(AppColors.darkText),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (c, i) => hBox(15),
          );
        });
  }

  Widget addAddress() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.primary)),
      child: ListTile(
        onTap: () {
          Get.toNamed(AppRoutes.addAddressScreen);
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 15.r),
        horizontalTitleGap: 10.w,
        leading: SvgPicture.asset(
          "assets/svg/pin_location.svg",
          height: 22.h,
        ),
        title: Text(
          "Add Address",
          style: AppFontStyle.text_16_400(AppColors.primary),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_sharp,
          size: 20.h,
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
}
