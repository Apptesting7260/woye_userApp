import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Payment_method/Controller/payment_method_controller.dart';

class PaymentMethodScreen extends StatelessWidget {
   PaymentMethodScreen({super.key});

   final PaymentMethodController paymentMethodController =
      Get.put(PaymentMethodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Payment method",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Payment Default",
              style: AppFontStyle.text_16_600(
                AppColors.darkText,
              ),
            ),
            hBox(10),
            methodList(),
            hBox(15),
            addNewCard()
          ],
        ),
      ),
    );
  }

  Widget methodList() {
    return GetBuilder(
      init: paymentMethodController,
      builder: (controller) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            bool isSelected = paymentMethodController.selectedIndex == index;
            if (index == 0) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  controller.selectedIndex = index;
                  controller.update();
                },
                child: Container(
                  padding: EdgeInsets.all(16.r),
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
                          children: [
                            SvgPicture.asset("assets/svg/wallet.svg"),
                            wBox(10),
                            Text(
                              "My Wallet (\$400)",
                              style:
                                  AppFontStyle.text_16_400(AppColors.darkText),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      wBox(6),
                      Expanded(
                        flex: 1,
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
                    ],
                  ),
                ),
              );
            } else if (index == 1) {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  controller.selectedIndex = index;
                  controller.update();
                },
                child: Container(
                  padding: EdgeInsets.all(16.r),
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
                          children: [
                            SvgPicture.asset("assets/svg/master-card.svg"),
                            wBox(10),
                            Text(
                              "•••• •••• •••• ",
                              style: AppFontStyle.text_28_600(
                                  AppColors.darkText,
                                  height: 1.h),
                            ),
                            Text(
                              " 8888",
                              style:
                                  AppFontStyle.text_16_400(AppColors.darkText),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      wBox(6),
                      Expanded(
                        flex: 1,
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
                    ],
                  ),
                ),
              );
            } else {
              return InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  controller.selectedIndex = index;
                  controller.update();
                },
                child: Container(
                  padding: EdgeInsets.all(16.r),
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
                          children: [
                            // SvgPicture.asset("assets/svg/cod-icon.svg"),
                            Text(
                              "Cash On Delivery",
                              style:
                                  AppFontStyle.text_16_400(AppColors.darkText),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      wBox(6),
                      Expanded(
                        flex: 1,
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
                    ],
                  ),
                ),
              );
            }
          },
          separatorBuilder: (c, i) => hBox(15.h),
        );
      },
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
              style: AppFontStyle.text_16_400(AppColors.primary),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_sharp)
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
}
