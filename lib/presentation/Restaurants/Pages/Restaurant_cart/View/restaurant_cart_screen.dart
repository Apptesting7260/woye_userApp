import 'package:cached_network_image/cached_network_image.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/delete_ptoduct/delete_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/quantity_update/quantityupdatecontroller.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Promo_codes/promo_codes.dart';

class RestaurantCartScreen extends StatefulWidget {
  bool isBack;

  RestaurantCartScreen({super.key, this.isBack = false});

  @override
  State<RestaurantCartScreen> createState() => _RestaurantCartScreenState();
}

class _RestaurantCartScreenState extends State<RestaurantCartScreen> {
  final RestaurantCartController controller =
      Get.put(RestaurantCartController());
  final QuantityController quantityUpdateController =
      Get.put(QuantityController());

  final DeleteProductController deleteProductController =
      Get.put(DeleteProductController());

  void initState() {
    // TODO: implement initState
    controller.getRestaurantCartApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: widget.isBack,
        isActions: true,
        title: Text(
          "My Cart",
          style: AppFontStyle.text_24_600(AppColors.darkText),
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
                  controller.refreshApi();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.refreshApi();
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.refreshApi();
              },
              child: controller.cartData.value.cartContent != "Notempty"
                  ? Column(
                      children: [
                        hBox(Get.height / 3),
                        Center(
                          child: Image.asset(
                            ImageConstants.wishlistEmpty,
                            height: 70.h,
                            width: 100.h,
                          ),
                        ),
                        hBox(10.h),
                        Text(
                          "Your cart is empty!",
                          style: AppFontStyle.text_20_600(AppColors.darkText),
                        ),
                        hBox(5.h),
                        Text(
                          "Explore more and shortlist some items",
                          style: AppFontStyle.text_16_400(AppColors.mediumText),
                        ),
                      ],
                    )
                  : Padding(
                      padding: REdgeInsets.symmetric(horizontal: 24.h),
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            cartItems(),
                            hBox(40),
                            promoCode(context),
                            hBox(40),
                            paymentDetails(),
                            hBox(30),
                            Divider(thickness: .5.w, color: AppColors.hintText),
                            hBox(15),
                            checkoutButton(),
                            hBox(100)
                          ],
                        ),
                      ),
                    ),
            );
        }
      }),
    );
  }

  Widget cartItems() {
    return ListView.separated(
      itemCount: controller.cartData.value.cart!.decodedAttribute!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
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
                      value: controller.cartData.value.cart!
                          .decodedAttribute![index].isSelected.value,
                      side: BorderSide(
                        color: AppColors.black,
                      ),
                      onChanged: (value) {
                        controller.cartData.value.cart!.decodedAttribute![index]
                                .isSelected.value =
                            !controller.cartData.value.cart!
                                .decodedAttribute![index].isSelected.value;
                      }),
                ),
              ),
            ),
            wBox(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CachedNetworkImage(
                imageUrl: controller
                    .cartData.value.cart!.decodedAttribute![index].productImage
                    .toString(),
                height: 100.h,
                width: 100.h,
                fit: BoxFit.fill,
                placeholder: (context, url) => circularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
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
                        child: Text(
                          controller.cartData.value.cart!
                              .decodedAttribute![index].productName
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppFontStyle.text_14_500(AppColors.darkText),
                        ),
                      ),
                      Obx(
                        () => deleteProductController.rxRequestStatus.value ==
                                    Status.LOADING &&
                                controller
                                        .cartData
                                        .value
                                        .cart!
                                        .decodedAttribute![index]
                                        .isDelete
                                        .value ==
                                    true
                            ? Center(
                                child: circularProgressIndicator(size: 18.h))
                            : GestureDetector(
                                onTap: () {
                                  controller
                                      .cartData
                                      .value
                                      .cart!
                                      .decodedAttribute![index]
                                      .isDelete
                                      .value = true;
                                  deleteProductController.deleteProductApi(
                                      productId: controller.cartData.value.cart!
                                          .decodedAttribute![index].productId
                                          .toString());
                                },
                                child: SvgPicture.asset(
                                  "assets/svg/delete-outlined.svg",
                                  height: 20,
                                ),
                              ),
                      ),
                    ],
                  ),
                  hBox(10),
                  if (controller.cartData.value.cart!.decodedAttribute![index]
                      .addonName!.isNotEmpty)
                    Wrap(
                      children: List.generate(
                        (controller
                                    .cartData
                                    .value
                                    .cart!
                                    .decodedAttribute![index]
                                    .addonName!
                                    .length /
                                2)
                            .ceil(),
                        (rowIndex) {
                          int firstItemIndex = rowIndex * 2;
                          int secondItemIndex = firstItemIndex + 1;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  controller
                                      .cartData
                                      .value
                                      .cart!
                                      .decodedAttribute![index]
                                      .addonName![firstItemIndex],
                                  style: AppFontStyle.text_12_400(
                                      AppColors.lightText),
                                ),
                              ),
                              if (secondItemIndex <
                                  controller
                                      .cartData
                                      .value
                                      .cart!
                                      .decodedAttribute![index]
                                      .addonName!
                                      .length)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    controller
                                        .cartData
                                        .value
                                        .cart!
                                        .decodedAttribute![index]
                                        .addonName![secondItemIndex],
                                    style: AppFontStyle.text_12_400(
                                        AppColors.lightText),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  hBox(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "\$${controller.cartData.value.cart!.decodedAttribute![index].totalPrice.toString()}",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_14_600(AppColors.primary),
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
                          () => quantityUpdateController
                                          .rxRequestStatus.value ==
                                      Status.LOADING &&
                                  controller
                                          .cartData
                                          .value
                                          .cart!
                                          .decodedAttribute![index]
                                          .isLoading
                                          .value ==
                                      true
                              ? Center(child: circularProgressIndicator2())
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        if (controller
                                                .cartData
                                                .value
                                                .cart!
                                                .decodedAttribute![index]
                                                .quantity ==
                                            1) {
                                          Utils.showToast(
                                              "Qty can not less then 1");
                                        } else {
                                          controller
                                              .cartData
                                              .value
                                              .cart!
                                              .decodedAttribute![index]
                                              .isLoading
                                              .value = true;
                                          quantityUpdateController
                                              .updateQuantityApi(
                                            productId: controller
                                                .cartData
                                                .value
                                                .cart!
                                                .decodedAttribute![index]
                                                .productId
                                                .toString(),
                                            productQuantity: (controller
                                                        .cartData
                                                        .value
                                                        .cart!
                                                        .decodedAttribute![
                                                            index]
                                                        .quantity! -
                                                    1)
                                                .toString(),
                                          );
                                        }
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        size: 16.w,
                                      ),
                                    ),
                                    Text(
                                      controller.cartData.value.cart!
                                          .decodedAttribute![index].quantity
                                          .toString(),
                                      style: AppFontStyle.text_14_400(
                                          AppColors.darkText),
                                    ),
                                    InkWell(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () {
                                        controller
                                            .cartData
                                            .value
                                            .cart!
                                            .decodedAttribute![index]
                                            .isLoading
                                            .value = true;
                                        quantityUpdateController
                                            .updateQuantityApi(
                                          productId: controller
                                              .cartData
                                              .value
                                              .cart!
                                              .decodedAttribute![index]
                                              .productId
                                              .toString(),
                                          productQuantity: (controller
                                                      .cartData
                                                      .value
                                                      .cart!
                                                      .decodedAttribute![index]
                                                      .quantity! +
                                                  1)
                                              .toString(),
                                        );
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 16.w,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
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
              "\$${controller.cartData.value.cart!.regularPrice.toString()}",
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
              "\$${controller.cartData.value.cart!.saveAmount.toString()}",
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
              "\$${controller.cartData.value.cart!.deliveryCharge.toString()}",
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
              "\$${controller.cartData.value.cart!.totalPrice.toString()}",
              style: AppFontStyle.text_26_600(AppColors.primary),
            ),
          ],
        ),
        SizedBox(
            width: 200.w,
            height: 55.h,
            child: CustomElevatedButton(
              onPressed: () {
                var selectedItems = controller
                    .cartData.value.cart!.decodedAttribute!
                    .where((item) => item.isSelected.value)
                    .map((item) => {
                          'name': item.productName,
                          'price': "\$${item.totalPrice.toString()}"
                        })
                    .toList();

                if (selectedItems.isNotEmpty) {
                  selectedItems.forEach((item) {
                    print(
                        "Selected Product: ${item['name']}, Price: ${item['price']}");
                    Get.toNamed(AppRoutes.checkoutScreen);
                  });
                } else {
                  Utils.showToast(
                      "Please select product to proceed to checkout");
                }
              },
              text: "Checkout",
              textStyle: AppFontStyle.text_16_600(AppColors.white),
            ))
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
                  const PromoCodes().restaurantPromoCodeList(),
                ],
              ),
            ),
          );
        });
  }
}
