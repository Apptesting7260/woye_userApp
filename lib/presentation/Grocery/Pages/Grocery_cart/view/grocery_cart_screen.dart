import 'dart:math';

import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Promo_codes/promo_codes.dart';

class GroceryCartScreen extends StatelessWidget {
  const GroceryCartScreen({super.key, required bool isBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        isActions: true,
        title: Text(
          "My Cart",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            cartItems(),
            hBox(40),
            promoCode(context),
            hBox(40),
            paymentDetails(),
            hBox(30),
            Divider(
              thickness: .5.w,
              color: AppColors.hintText,
            ),
            hBox(15),
            checkoutButton(),
            hBox(100)
          ],
        ),
      ),
    );
  }

  Widget cartItems() {
    return ListView.separated(
      itemCount: 10,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        RxInt cartCount = 1.obs;
        RxBool isSelected = false.obs;
        return Row(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Expanded(
                flex: 1,
                child: Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                      activeColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      value: isSelected.value,
                      side: BorderSide(
                        color: AppColors.black,
                      ),
                      onChanged: (value) {
                        isSelected.value = !isSelected.value;
                      }),
                ),
              ),
            ),
            wBox(10),
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.asset(
                  "assets/images/tablet.png",
                  height: 100.h,
                  width: 100.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            wBox(10),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hBox(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 110.w,
                        child: FittedBox(
                          child: Text(
                            "McMushroom Pizza",
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.text_14_500(AppColors.darkText),
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        "assets/svg/delete-outlined.svg",
                        height: 20,
                      )
                      // Icon(
                      //   Icons.delete_outlined,
                      //   color: AppColors.lightText,
                      // )
                    ],
                  ),
                  hBox(10),
                  Text(
                    "Small",
                    style: AppFontStyle.text_12_400(AppColors.lightText),
                  ),
                  // hBox(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "\$${index * Random.secure().nextInt(100)}",
                            overflow: TextOverflow.ellipsis,
                            style: AppFontStyle.text_14_600(AppColors.primary),
                          ),
                          wBox(4),
                          SizedBox(
                            width: 50,
                            child: Text(
                              "\$20.00",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12.sp,
                                  color: AppColors.mediumText,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: AppColors.mediumText),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 35.h,
                        width: 90.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          border: Border.all(
                              width: 0.8.w, color: AppColors.primary),
                        ),
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  if (cartCount.value != 0) cartCount.value--;
                                },
                                child: Icon(
                                  Icons.remove,
                                  size: 16.w,
                                ),
                              ),
                              Text(
                                "${cartCount.value}",
                                style: AppFontStyle.text_14_400(
                                    AppColors.darkText),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  cartCount.value++;
                                },
                                child: Icon(
                                  Icons.add,
                                  size: 16.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  hBox(5),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (context, index) {
        return hBox(20);
      },
    );
  }

  Widget promoCode(context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(15.r),
      color: AppColors.primary,
      dashPattern: [6.w, 3.w],
      padding: REdgeInsets.symmetric(horizontal: 25, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        child: Row(
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                bottomBar(context);
              },
              child: Row(
                children: [
                  SvgPicture.asset("assets/svg/coupon.svg"),
                  wBox(15),
                  Text(
                    "Enter coupon code",
                    style: AppFontStyle.text_14_400(AppColors.lightText),
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Apply",
                style: AppFontStyle.text_16_600(AppColors.primary),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget paymentDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Details",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
        hBox(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Regular Price",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              "\$${Random.secure().nextInt(100) + 40}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Save Amount",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              "\$${Random.secure().nextInt(20)}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
        hBox(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Delivery Charge",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            Text(
              "\$${Random.secure().nextInt(20)}.00",
              style: AppFontStyle.text_14_600(AppColors.darkText),
            ),
          ],
        ),
      ],
    );
  }

  Widget checkoutButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Price",
              style: AppFontStyle.text_14_500(AppColors.darkText),
            ),
            Text(
              "\$${Random.secure().nextInt(100)}.00",
              style: AppFontStyle.text_26_600(AppColors.primary),
            ),
          ],
        ),
        CustomElevatedButton(
          width: 200.w,
          height: 55.h,
          onPressed: () {
            Get.toNamed(AppRoutes.pharmacyCheckout);
          },
          text: "Checkout",
          textStyle: AppFontStyle.text_16_600(AppColors.white),
        )
      ],
    );
  }

  Future bottomBar(context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        elevation: 8.h,
        builder: (
          context,
        ) {
          return Container(
            // height: 550.h,
            padding: REdgeInsets.symmetric(horizontal: 24, vertical: 30),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.r),
                    topRight: Radius.circular(15.r))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Promo Codes",
                        style: AppFontStyle.text_20_400(AppColors.darkText),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.mediumText,
                        ),
                      )
                    ],
                  ),
                  hBox(15),
                  const PromoCodes().pharmacyPromoCodeList(),
                ],
              ),
            ),
          );
        });
  }
}
