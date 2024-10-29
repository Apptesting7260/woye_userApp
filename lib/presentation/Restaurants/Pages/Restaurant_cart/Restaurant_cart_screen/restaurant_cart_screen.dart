import 'dart:math';

import 'package:woye_user/core/utils/app_export.dart';

class RestaurantCartScreen extends StatelessWidget {
  const RestaurantCartScreen({super.key});

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
            couponBox(),
            hBox(40),
            paymentMethod(),
            hBox(30),
            Divider(
              thickness: .5.w,
              color: AppColors.hintText,
            ),
            hBox(15),
            checkout(),
            hBox(100)
          ],
        ),
      ),
    );
  }

  Widget cartItems() {
    return ListView.separated(
      itemCount: 10,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        RxInt cartCount = 1.obs;
        RxBool isSelected = false.obs;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Transform.scale(
                scale: 1.2,
                child: SizedBox(
                  height: 20.h,
                  width: 24.h,
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
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: Image.asset(
                "assets/images/cat-image${index % 5}.png",
                height: 100.h,
                width: 100.h,
                fit: BoxFit.cover,
              ),
            ),
            wBox(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hBox(5),
                SizedBox(
                  width: (Get.width * 0.51) - 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 110.w,
                        child: Text(
                          "McMushroom Pizza",
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.text_14_500(AppColors.darkText),
                        ),
                      ),
                      Icon(
                        Icons.delete_outlined,
                        color: AppColors.lightText,
                      )
                    ],
                  ),
                ),
                hBox(10),
                Text(
                  "Small",
                  style: AppFontStyle.text_12_400(AppColors.lightText),
                ),
                // hBox(10),
                SizedBox(
                  width: (Get.width * 0.51) - 4,
                  child: Row(
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
                        height: 40.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.r),
                          border: Border.all(
                              width: 0.8.w, color: AppColors.primary),
                        ),
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
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
                              GestureDetector(
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
                ),
                hBox(5),
              ],
            )
          ],
        );
      },
      separatorBuilder: (context, index) {
        return hBox(20);
      },
    );
  }

  Widget couponBox() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(15.r),
      color: AppColors.primary,
      dashPattern: [6.w, 3.w],
      padding: REdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15.r)),
        child: Row(
          children: [
            SvgPicture.asset("assets/svg/coupon.svg"),
            wBox(15),
            Text(
              "Enter coupon code",
              style: AppFontStyle.text_14_400(AppColors.lightText),
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

  Widget paymentMethod() {
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

  Widget checkout() {
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
        SizedBox(
          width: 200.w,
          height: 60.h,
          child: CustomElevatedButton(
            onPressed: () {},
            text: "Checkout",
            textStyle: AppFontStyle.text_16_600(AppColors.white),
          ),
        )
      ],
    );
  }
}
