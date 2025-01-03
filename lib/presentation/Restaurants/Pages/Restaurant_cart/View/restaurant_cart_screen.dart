import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:intl/intl.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/checked_unchecked/checked_unchecked_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/coupon_apply/apply_cpooun_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/delete_ptoduct/delete_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/quantity_update/quantityupdatecontroller.dart';

class RestaurantCartScreen extends StatefulWidget {
  final bool isBack;

  const RestaurantCartScreen({super.key, this.isBack = false});

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
  final ApplyCouponController applyCouponController =
      Get.put(ApplyCouponController());
  final CheckedUncheckedController checkedUncheckedController =
      Get.put(CheckedUncheckedController());

  void initState() {
    controller.getRestaurantCartApi();
    super.initState();
    _scrollController.addListener(
      () {
        if (_scrollController.position.isScrollingNotifier.value) {
          controller.readOnly.value = true;
        }
      },
    );
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        controller.readOnly.value = true;
      },
      child: Scaffold(
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
                            style:
                                AppFontStyle.text_16_400(AppColors.mediumText),
                          ),
                        ],
                      )
                    : Padding(
                        padding: REdgeInsets.symmetric(horizontal: 20.h),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: _scrollController,
                          child: Column(
                            children: [
                              if (controller.cartData.value.addressExists ==
                                  true)
                                address(),
                              if (controller.cartData.value.addressExists ==
                                  true)
                                hBox(20.h),
                              cartItems(),
                              hBox(40.h),
                              promoCode(context),
                              hBox(40.h),
                              paymentDetails(),
                              hBox(30.h),
                              Divider(
                                  thickness: .5.w, color: AppColors.hintText),
                              hBox(15.h),
                              checkoutButton(),
                              hBox(100.h)
                            ],
                          ),
                        ),
                      ),
              );
          }
        }),
      ),
    );
  }

  Widget address() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Delivery Address",
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            const Spacer(),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Get.toNamed(AppRoutes.deliveryAddressScreen,
                    arguments: {'type': "Cart"});
              },
              child: Row(
                children: [
                  Text(
                    "Change Address",
                    style: AppFontStyle.text_14_600(AppColors.primary),
                  ),
                  wBox(4),
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: AppColors.primary,
                    size: 18,
                  )
                ],
              ),
            ),
          ],
        ),
        hBox(10.h),
        Container(
          height: 82.h,
          width: Get.width,
          padding: EdgeInsets.all(20.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: AppColors.mediumText)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.cartData.value.address!.addressType.toString(),
                style: AppFontStyle.text_15_600(AppColors.primary),
              ),
              VerticalDivider(thickness: 1.w, color: AppColors.hintText),
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  controller.cartData.value.address!.address.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppFontStyle.text_14_400(AppColors.darkText),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget cartItems() {
  //   return ListView.separated(
  //     itemCount: controller.cartData.value.cart!.decodedAttribute!.length,
  //     physics: const NeverScrollableScrollPhysics(),
  //     shrinkWrap: true,
  //     itemBuilder: (context, index) {
  //       return Row(
  //         children: [
  //           Expanded(
  //             flex: 1,
  //             child: Transform.scale(
  //               scale: 1.2,
  //               child: Checkbox(
  //                 activeColor: AppColors.black,
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(5)),
  //                 value: controller.cartData.value.cart!
  //                         .decodedAttribute![index].checked ==
  //                     'true',
  //                 side: BorderSide(
  //                   color: AppColors.black,
  //                 ),
  //                 onChanged: (value) {
  //                   if (checkedUncheckedController.rxRequestStatus.value !=
  //                       Status.LOADING) {
  //                     bool newCheckedStatus = !(controller.cartData.value.cart!
  //                             .decodedAttribute![index].checked ==
  //                         'true');
  //
  //                     checkedUncheckedController.checkedUncheckedApi(
  //                       productId: controller.cartData.value.cart!
  //                           .decodedAttribute![index].productId
  //                           .toString(),
  //                       cartId: controller.cartData.value.cart!.id.toString(),
  //                       status: newCheckedStatus.toString(),
  //                     );
  //                   }
  //                 },
  //               ),
  //             ),
  //           ),
  //           wBox(10),
  //           ClipRRect(
  //             borderRadius: BorderRadius.circular(20.r),
  //             child: CachedNetworkImage(
  //               imageUrl: controller
  //                   .cartData.value.cart!.decodedAttribute![index].productImage
  //                   .toString(),
  //               height: 100.h,
  //               width: 100.h,
  //               fit: BoxFit.fill,
  //               placeholder: (context, url) => circularProgressIndicator(),
  //               errorWidget: (context, url, error) => const Icon(Icons.error),
  //             ),
  //           ),
  //           wBox(10),
  //           Expanded(
  //             flex: 6,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 hBox(5.h),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(
  //                       width: 110.w,
  //                       child: Text(
  //                         controller.cartData.value.cart!
  //                             .decodedAttribute![index].productName
  //                             .toString(),
  //                         overflow: TextOverflow.ellipsis,
  //                         maxLines: 2,
  //                         style: AppFontStyle.text_14_500(AppColors.darkText),
  //                       ),
  //                     ),
  //                     Obx(
  //                       () => deleteProductController.rxRequestStatus.value ==
  //                                   Status.LOADING &&
  //                               controller
  //                                       .cartData
  //                                       .value
  //                                       .cart!
  //                                       .decodedAttribute![index]
  //                                       .isDelete
  //                                       .value ==
  //                                   true
  //                           ? Center(
  //                               child: Row(
  //                               children: [
  //                                 circularProgressIndicator(size: 15.h),
  //                                 wBox(2.h),
  //                               ],
  //                             ))
  //                           : GestureDetector(
  //                               onTap: () {
  //                                 controller
  //                                     .cartData
  //                                     .value
  //                                     .cart!
  //                                     .decodedAttribute![index]
  //                                     .isDelete
  //                                     .value = true;
  //                                 deleteProductController.deleteProductApi(
  //                                     productId: controller.cartData.value.cart!
  //                                         .decodedAttribute![index].productId
  //                                         .toString());
  //                               },
  //                               child: SvgPicture.asset(
  //                                 "assets/svg/delete-outlined.svg",
  //                                 height: 20,
  //                               ),
  //                             ),
  //                     ),
  //                   ],
  //                 ),
  //                 hBox(10),
  //                 if (controller.cartData.value.cart!.decodedAttribute![index]
  //                     .addonName!.isNotEmpty)
  //                   Wrap(
  //                     children: List.generate(
  //                       (controller
  //                                   .cartData
  //                                   .value
  //                                   .cart!
  //                                   .decodedAttribute![index]
  //                                   .addonName!
  //                                   .length /
  //                               2)
  //                           .ceil(),
  //                       (rowIndex) {
  //                         int firstItemIndex = rowIndex * 2;
  //                         int secondItemIndex = firstItemIndex + 1;
  //                         return Row(
  //                           mainAxisSize: MainAxisSize.min,
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.only(right: 8.0),
  //                               child: Text(
  //                                 controller
  //                                     .cartData
  //                                     .value
  //                                     .cart!
  //                                     .decodedAttribute![index]
  //                                     .addonName![firstItemIndex],
  //                                 style: AppFontStyle.text_12_400(
  //                                     AppColors.lightText),
  //                               ),
  //                             ),
  //                             if (secondItemIndex <
  //                                 controller
  //                                     .cartData
  //                                     .value
  //                                     .cart!
  //                                     .decodedAttribute![index]
  //                                     .addonName!
  //                                     .length)
  //                               Padding(
  //                                 padding: const EdgeInsets.only(right: 8.0),
  //                                 child: Text(
  //                                   controller
  //                                       .cartData
  //                                       .value
  //                                       .cart!
  //                                       .decodedAttribute![index]
  //                                       .addonName![secondItemIndex],
  //                                   style: AppFontStyle.text_12_400(
  //                                       AppColors.lightText),
  //                                 ),
  //                               ),
  //                           ],
  //                         );
  //                       },
  //                     ),
  //                   ),
  //                 hBox(10),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   crossAxisAlignment: CrossAxisAlignment.end,
  //                   children: [
  //                     Text(
  //                       "\$${controller.cartData.value.cart!.decodedAttribute![index].totalPrice.toString()}",
  //                       overflow: TextOverflow.ellipsis,
  //                       style: AppFontStyle.text_14_600(AppColors.primary),
  //                     ),
  //                     Container(
  //                       height: 35.h,
  //                       width: 90.w,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(50.r),
  //                         border: Border.all(
  //                             width: 0.8.w, color: AppColors.primary),
  //                       ),
  //                       child: Obx(
  //                         () => quantityUpdateController
  //                                         .rxRequestStatus.value ==
  //                                     Status.LOADING &&
  //                                 controller
  //                                         .cartData
  //                                         .value
  //                                         .cart!
  //                                         .decodedAttribute![index]
  //                                         .isLoading
  //                                         .value ==
  //                                     true
  //                             ? Center(child: circularProgressIndicator2())
  //                             : Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   InkWell(
  //                                     splashColor: Colors.transparent,
  //                                     highlightColor: Colors.transparent,
  //                                     onTap: () {
  //                                       if (controller
  //                                               .cartData
  //                                               .value
  //                                               .cart!
  //                                               .decodedAttribute![index]
  //                                               .quantity ==
  //                                           1) {
  //                                         Utils.showToast(
  //                                             "Qty can not less then 1");
  //                                       } else {
  //                                         controller
  //                                             .cartData
  //                                             .value
  //                                             .cart!
  //                                             .decodedAttribute![index]
  //                                             .isLoading
  //                                             .value = true;
  //                                         quantityUpdateController
  //                                             .updateQuantityApi(
  //                                           productId: controller
  //                                               .cartData
  //                                               .value
  //                                               .cart!
  //                                               .decodedAttribute![index]
  //                                               .productId
  //                                               .toString(),
  //                                           productQuantity: (controller
  //                                                       .cartData
  //                                                       .value
  //                                                       .cart!
  //                                                       .decodedAttribute![
  //                                                           index]
  //                                                       .quantity! -
  //                                                   1)
  //                                               .toString(),
  //                                         );
  //                                       }
  //                                     },
  //                                     child: Icon(
  //                                       Icons.remove,
  //                                       size: 16.w,
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     controller.cartData.value.cart!
  //                                         .decodedAttribute![index].quantity
  //                                         .toString(),
  //                                     style: AppFontStyle.text_14_400(
  //                                         AppColors.darkText),
  //                                   ),
  //                                   InkWell(
  //                                     splashColor: Colors.transparent,
  //                                     highlightColor: Colors.transparent,
  //                                     onTap: () {
  //                                       controller
  //                                           .cartData
  //                                           .value
  //                                           .cart!
  //                                           .decodedAttribute![index]
  //                                           .isLoading
  //                                           .value = true;
  //                                       quantityUpdateController
  //                                           .updateQuantityApi(
  //                                         productId: controller
  //                                             .cartData
  //                                             .value
  //                                             .cart!
  //                                             .decodedAttribute![index]
  //                                             .productId
  //                                             .toString(),
  //                                         productQuantity: (controller
  //                                                     .cartData
  //                                                     .value
  //                                                     .cart!
  //                                                     .decodedAttribute![index]
  //                                                     .quantity! +
  //                                                 1)
  //                                             .toString(),
  //                                       );
  //                                     },
  //                                     child: Icon(
  //                                       Icons.add,
  //                                       size: 16.w,
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 hBox(5),
  //               ],
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //     separatorBuilder: (context, index) {
  //       return hBox(20);
  //     },
  //   );
  // }

  Widget cartItems() {
    return ListView.separated(
      itemCount: controller.cartData.value.cart!.decodedAttribute!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        bool isLoading = checkedUncheckedController.rxRequestStatus.value ==
                Status.LOADING &&
            controller.cartData.value.cart!.decodedAttribute?[index]
                    .isSelectedLoading.value ==
                true;

        return Row(
          children: [
            Expanded(
              flex: 1,
              child: Transform.scale(
                scale: 1.2,
                child: isLoading
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: const Checkbox(
                          value: false,
                          onChanged: null,
                        ),
                      )
                    : Checkbox(
                        activeColor: AppColors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: controller.cartData.value.cart!
                                .decodedAttribute![index].checked ==
                            'true',
                        side: BorderSide(
                          color: AppColors.black,
                        ),
                        onChanged: (value) {
                          if (checkedUncheckedController
                                  .rxRequestStatus.value !=
                              Status.LOADING) {
                            controller
                                .cartData
                                .value
                                .cart!
                                .decodedAttribute?[index]
                                .isSelectedLoading
                                .value = true;
                            bool newCheckedStatus = !(controller.cartData.value
                                    .cart!.decodedAttribute![index].checked ==
                                'true');

                            checkedUncheckedController.checkedUncheckedApi(
                              productId: controller.cartData.value.cart!
                                  .decodedAttribute![index].productId
                                  .toString(),
                              cartId:
                                  controller.cartData.value.cart!.id.toString(),
                              status: newCheckedStatus.toString(),
                            );
                          }
                        },
                      ),
              ),
            ),
            wBox(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: isLoading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        color: Colors.white,
                        height: 100.h,
                        width: 100.h,
                      ),
                    )
                  : GestureDetector(
                onTap: () {

                  if (checkedUncheckedController
                      .rxRequestStatus.value !=
                      Status.LOADING) {
                    controller
                        .cartData
                        .value
                        .cart!
                        .decodedAttribute?[index]
                        .isSelectedLoading
                        .value = true;
                    bool newCheckedStatus = !(controller.cartData.value
                        .cart!.decodedAttribute![index].checked ==
                        'true');

                    checkedUncheckedController.checkedUncheckedApi(
                      productId: controller.cartData.value.cart!
                          .decodedAttribute![index].productId
                          .toString(),
                      cartId:
                      controller.cartData.value.cart!.id.toString(),
                      status: newCheckedStatus.toString(),
                    );
                  }

                },
                    child: CachedNetworkImage(
                        imageUrl: controller.cartData.value.cart!
                            .decodedAttribute![index].productImage
                            .toString(),
                        height: 100.h,
                        width: 100.h,
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            circularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                  ),
            ),
            wBox(10),
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  hBox(5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 14.h,
                                width: 110.w,
                                color: Colors.white,
                              ),
                            )
                          : SizedBox(
                              width: 110.w,
                              child: Text(
                                controller.cartData.value.cart!
                                    .decodedAttribute![index].productName
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: AppFontStyle.text_14_500(
                                    AppColors.darkText),
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
                                child: Row(
                                  children: [
                                    circularProgressIndicator(size: 15.h),
                                    wBox(2.h),
                                  ],
                                ),
                              )
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
                                child: isLoading
                                    ? Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        child: Container(
                                          height: 12.h,
                                          width: 50.w,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
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
                                  child: isLoading
                                      ? Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          child: Container(
                                            height: 12.h,
                                            width: 50.w,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
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
                      isLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 14.h,
                                width: 60.w,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "\$${controller.cartData.value.cart!.decodedAttribute![index].totalPrice.toString()}",
                              overflow: TextOverflow.ellipsis,
                              style:
                                  AppFontStyle.text_14_600(AppColors.primary),
                            ),
                      isLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                height: 35.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50.r),
                                  border: Border.all(width: 0.8.w),
                                ),
                              ),
                            )
                          : Container(
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
                                    ? Center(
                                        child: circularProgressIndicator2())
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
                                                      .checked !=
                                                  "false") {
                                                if (controller
                                                        .cartData
                                                        .value
                                                        .cart!
                                                        .decodedAttribute![
                                                            index]
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
                                                        .decodedAttribute![
                                                            index]
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
                                              } else {
                                                Utils.showToast(
                                                    "First select product");
                                              }
                                            },
                                            child: Icon(
                                              Icons.remove,
                                              size: 16.w,
                                            ),
                                          ),
                                          Text(
                                            controller
                                                .cartData
                                                .value
                                                .cart!
                                                .decodedAttribute![index]
                                                .quantity
                                                .toString(),
                                            style: AppFontStyle.text_14_400(
                                                AppColors.darkText),
                                          ),
                                          InkWell(
                                            splashColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () {
                                              if (controller
                                                      .cartData
                                                      .value
                                                      .cart!
                                                      .decodedAttribute![index]
                                                      .checked !=
                                                  "false") {
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
                                                              .quantity! +
                                                          1)
                                                      .toString(),
                                                );
                                              } else {
                                                Utils.showToast(
                                                    "First select product");
                                              }
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
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return hBox(20);
      },
    );
  }

  FocusNode focusNode = FocusNode();

  Widget promoCode(context) {
    return controller.cartData.value.cart!.couponApplied == null
        ? DottedBorder(
            strokeWidth: 2,
            borderType: BorderType.RRect,
            radius: Radius.circular(15.r),
            color: AppColors.primary,
            dashPattern: [6.w, 3.w],
            child: SizedBox(
              height: Get.height * 0.065,
              width: Get.width * 0.9,
              child: Row(
                children: [
                  wBox(15.h),
                  SvgPicture.asset("assets/svg/coupon.svg"),
                  wBox(10.h),
                  SizedBox(
                    height: Get.height * 0.08,
                    width: Get.width * 0.5,
                    child: Center(
                      child: CustomTextFormField(
                        controller: controller.couponCodeController.value,
                        readOnly: controller.readOnly.value,
                        focusNode: focusNode,
                        onTap: () {
                          if (controller.cartData.value.cart!.decodedAttribute!
                              .where((item) => item.checked == "true")
                              .isEmpty) {
                            Utils.showToast("Please select a product");
                          } else if (controller
                              .cartData.value.coupons!.isNotEmpty) {
                            if (controller.readOnly.value) {
                              bottomBar(context);
                            }
                          } else {
                            controller.readOnly.value = false;
                            Utils.showToast("Coupon Not available");
                          }
                        },
                        alignment: Alignment.center,
                        contentPadding: EdgeInsets.zero,
                        borderDecoration: InputBorder.none,
                        prefixConstraints:
                            BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
                        hintText: "Enter coupon code",
                        hintStyle:
                            AppFontStyle.text_16_400(AppColors.lightText),
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  ),
                  const Spacer(),
                  applyCouponController.rxRequestStatus.value == Status.LOADING
                      ? Center(child: circularProgressIndicator(size: 20.h))
                      : GestureDetector(
                          onTap: () {
                            if (controller
                                .couponCodeController.value.text.isNotEmpty) {
                              applyCouponController.applyCouponApi(
                                  cartId: controller.cartData.value.cart!.id
                                      .toString(),
                                  couponCode: controller
                                      .couponCodeController.value.text
                                      .toString());
                            } else {
                              Utils.showToast("Please Enter Coupon Code");
                            }
                          },
                          child: Text(
                            "Apply",
                            style: AppFontStyle.text_16_600(AppColors.primary),
                          ),
                        ),
                  wBox(20.h),
                ],
              ),
            ),
          )
        : Container(
            height: Get.height * 0.080,
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  right: -5.h,
                  top: -5.h,
                  child: SizedBox(
                    height: 36.h,
                    width: 36.h,
                    child: applyCouponController.rxRequestStatus.value ==
                            Status.LOADING
                        ? circularProgressIndicator(size: 18.h)
                        : Center(
                            child: GestureDetector(
                              onTap: () {
                                applyCouponController.applyCouponApi(
                                  cartId: controller.cartData.value.cart!.id
                                      .toString(),
                                  couponCode: controller
                                      .cartData.value.cart!.couponApplied!.code
                                      .toString(),
                                );
                              },
                              child: Icon(
                                Icons.cancel,
                                size: 30.h,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    wBox(15.h),
                    Container(
                      height: 36.h,
                      width: 36.h,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        // borderRadius: BorderRadius.circular(100.r),
                        border: Border.all(color: AppColors.black, width: 2),
                      ),
                      child: Icon(
                        Icons.done,
                        color: AppColors.primary,
                      ),
                    ),
                    wBox(15.h),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              controller
                                  .cartData.value.cart!.couponApplied!.code
                                  .toString(),
                              style: AppFontStyle.text_18_600(AppColors.black),
                            ),
                            wBox(5.h),
                            Text(
                              "Applied",
                              style:
                                  AppFontStyle.text_16_600(AppColors.primary),
                            ),
                          ],
                        ),
                        Text(
                          "-\$${controller.cartData.value.cart!.couponDiscount}",
                          style: AppFontStyle.text_16_400(AppColors.lightText),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
  }

  Widget paymentDetails() {
    bool isLoading =
        checkedUncheckedController.rxRequestStatus.value == Status.LOADING ||
            deleteProductController.rxRequestStatus.value == Status.LOADING ||
            quantityUpdateController.rxRequestStatus.value == Status.LOADING;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Details",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
        hBox(20.h),
        if (isLoading) ...[
          shimmerItem("Regular Price"),
          shimmerItem("Save Amount"),
          shimmerItem("Coupon Discount"),
          shimmerItem("Delivery Charge"),
        ],
        if (!isLoading) ...[
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
          hBox(10.h),
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
          if (controller.cartData.value.cart!.couponApplied != null)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coupon Discount",
                    style: AppFontStyle.text_14_400(AppColors.lightText),
                  ),
                  Text(
                    "- \$${controller.cartData.value.cart!.couponDiscount.toString()}",
                    style: AppFontStyle.text_14_600(AppColors.darkText),
                  ),
                ],
              ),
            ),
          if (controller.cartData.value.addressExists == true)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
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
            ),
        ],
      ],
    );
  }

  Widget checkoutButton() {
    bool isLoading =
        checkedUncheckedController.rxRequestStatus.value == Status.LOADING ||
            deleteProductController.rxRequestStatus.value == Status.LOADING ||
            quantityUpdateController.rxRequestStatus.value == Status.LOADING;

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
            isLoading
                ? shimmerItem('\$0.00',
                    width: 70, height: 40, secondShimmer: false)
                : Text(
                    "\$${controller.cartData.value.cart!.totalPrice.toString()}",
                    style: AppFontStyle.text_26_600(AppColors.primary),
                  ),
          ],
        ),
        isLoading
            ? shimmerButton()
            : controller.cartData.value.addressExists == true
                ? SizedBox(
                    width: 200.w,
                    height: 55.h,
                    child: CustomElevatedButton(
                      onPressed: () {
                        var selectedItems = controller
                            .cartData.value.cart!.decodedAttribute!
                            .where((item) => item.checked == "true")
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
                    ),
                  )
                : SizedBox(
                    width: 200.w,
                    height: 55.h,
                    child: CustomElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.addAddressScreen,
                            arguments: {'type': "RestaurantCart"});
                      },
                      text: "Complete Address",
                      textStyle: AppFontStyle.text_16_600(AppColors.white),
                    ),
                  ),
      ],
    );
  }

  Widget shimmerButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: 200.w,
        height: 55.h,
        color: Colors.white,
      ),
    );
  }

  Widget shimmerItem(
    String label, {
    double width = 120.0,
    double height = 14.0,
    bool secondShimmer = true,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: width.w,
              height: height.h,
              color: Colors.white,
            ),
          ),
          secondShimmer == true
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80.h,
                    height: 14.h,
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
        ],
      ),
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
                          controller.readOnly.value = false;
                          focusNode.requestFocus();
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
                  restaurantPromoCodeList(),
                ],
              ),
            ),
          );
        });
  }

  Widget restaurantPromoCodeList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.cartData.value.coupons!.length,
      itemBuilder: (context, index) {
        String expireDate =
            controller.cartData.value.coupons![index].expireDate ?? "";
        DateTime expiryDate = DateFormat("dd-MM-yyyy").parse(expireDate);
        DateTime currentDate = DateTime.now();
        Duration difference = expiryDate.difference(currentDate);

        String daysRemaining = difference.inDays > 0
            ? "${difference.inDays} days remaining"
            : "Expired";
        return Container(
          padding: REdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: AppColors.navbar.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.r)),
          child: Row(
            children: [
              Container(
                padding: REdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                    color: index % 2 == 0 ? AppColors.primary : AppColors.black,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${controller.cartData.value.coupons![index].discountAmount}",
                            style: AppFontStyle.text_30_600(Colors.white,
                                height: 1.h),
                          ),
                          Text(
                            controller.cartData.value.coupons![index]
                                        .discountType
                                        .toString() ==
                                    "percent"
                                ? "%"
                                : "\$",
                            style: AppFontStyle.text_14_400(Colors.white),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "OFF",
                      style: AppFontStyle.text_15_400(Colors.white),
                    )
                  ],
                ),
              ),
              wBox(10.h),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.cartData.value.coupons![index].couponType
                          .toString(),
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.text_13_400(AppColors.lightText),
                    ),
                    hBox(10),
                    FittedBox(
                      child: Text(
                        controller.cartData.value.coupons![index].code
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_15_400(AppColors.darkText,
                            height: 1.h),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        daysRemaining,
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_12_400(AppColors.lightText),
                      ),
                    ),
                    hBox(8),
                    if (controller.cartData.value.coupons![index].expiryStatus
                            .toString() !=
                        "Expired")
                      CustomElevatedButton(
                        textStyle:
                            AppFontStyle.text_13_400(Colors.white, height: 1.0),
                        width: 85.w,
                        height: 36.h,
                        text: "Apply",
                        onPressed: () {
                          controller.couponCodeController.value.text =
                              controller.cartData.value.coupons![index].code
                                  .toString();
                          Get.back();
                          FocusScope.of(context).unfocus();
                        },
                      )
                  ],
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => hBox(20),
    );
  }
}
