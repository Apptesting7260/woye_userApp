import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/'
    'grocery_cart_controller.dart';
import 'package:intl/intl.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/coupon/grocery_apply_coupon_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/grocery_delete_ptoduct/delete_grocery_vendor.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/grocery_delete_ptoduct/delete_product_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/grocery_quantity_update/grocery_quantity_update_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/controller/grocery_specific_product_controller.dart';
import 'package:woye_user/shared/theme/font_family.dart';

import '../../Grocery_home/Sub_screens/Product_details/grocery_product_details_screen.dart';

class GroceryCartScreen extends StatefulWidget {
  final bool isBack;

  const GroceryCartScreen({super.key, this.isBack = false});

  @override
  State<GroceryCartScreen> createState() => _GroceryCartScreenState();
}

class _GroceryCartScreenState extends State<GroceryCartScreen> {
  final GroceryCartController controller = Get.put(GroceryCartController());
  final ApplyCouponGroceryController applyCouponController = Get.put(ApplyCouponGroceryController());
  final GrocerySpecificProductController grocerySpecificProductController = Get.put(GrocerySpecificProductController());

  @override
  void initState() {
    super.initState();
    controller.getGroceryAllCartApi();
    _scrollController.addListener(
      () {
        if (_scrollController.position.isScrollingNotifier.value) {
          controller.readOnly.value = true;
        }
      },
    );
  }

  final DeleteGroceryProductController deleteProductController =
      Get.put(DeleteGroceryProductController());
  final DeleteGroceryVendorController deleteVendorController =
      Get.put(DeleteGroceryVendorController());

  final GroceryQuantityController quantityUpdateController =
      Get.put(GroceryQuantityController());

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
            style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
          ),
        ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: circularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet' || controller.error.value == "InternetExceptionWidget") {
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
                            style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                          ),
                          hBox(5.h),
                          Text(
                            "Explore more and shortlist some items",
                            style:AppFontStyle.text_15_400(AppColors.mediumText,family: AppFontFamily.gilroyMedium),
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
                              controller.cartData.value.addressExists == true
                                  ? address()
                                  : locationAddress(),
                              hBox(20.h),
                              cartItems(),
                              hBox(20.h),
                              promoCode(context),
                              hBox(30.h),
                              paymentDetails(),
                              hBox(30.h),
                              Divider(
                                  thickness: .5.w, color: AppColors.hintText),
                              hBox(15.h),
                              checkoutButton(),
                              hBox(widget.isBack != true ? 100.h : 30.h)
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
              style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
            ),
            const Spacer(),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                Get.toNamed(AppRoutes.deliveryAddressScreen, arguments: {
                  // 'type': "PharmacyCart",
                  'type': "GroceryCart",
                  "fromcart": true,
                });
              },
              child: Row(
                children: [
                  Text(
                    "Change Address",
                    style: AppFontStyle.text_14_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
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
                controller.cartData.value.address!.addressType.toString().capitalizeFirst                    .toString(),
                style: AppFontStyle.text_15_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
              ),
              VerticalDivider(thickness: 1.w, color: AppColors.hintText),
              SizedBox(
                width: Get.width * 0.6,
                child: Text(
                  controller.cartData.value.address!.address.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  var currentLocation = ''.obs;

  void loadLocationData() async {
    var storage = GetStorage();
    currentLocation.value = storage.read('location') ?? '';
    print('Stored Location: ${currentLocation.value}');
  }

  Widget locationAddress() {
    loadLocationData();
    return Container(
      height: 60.h,
      width: Get.width,
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.mediumText)),
      child: Row(
        children: [
          Text(
            "Your\nLocation",
            textAlign: TextAlign.center,
            style: AppFontStyle.text_15_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
          ),
          VerticalDivider(thickness: 1.w, color: AppColors.hintText),
          SizedBox(
            width: Get.width * 0.6,
            child: Text(
              currentLocation.value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
            ),
          ),
        ],
      ),
    );
  }

  Widget cartItems() {
    return ListView.separated(
      itemCount: controller.cartData.value.cart!.buckets!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        var buckets = controller.cartData.value.cart!.buckets![index];
        WidgetsBinding.instance.addPostFrameCallback((_) {
          buckets.isDelivery.value = buckets.orderType == 'self' ? false : true;
        },);
        // bool isLoading =checkedUncheckedController.rxRequestStatus.value ==Status.LOADING &&
        // controller.cartData.value.cart!.decodedAttribute?[index].isSelectedLoading.value ==true;

        return Container(
          width: Get.width,
          padding:
              EdgeInsets.only(top: 10.r, bottom: 10.r, left: 10.r, right: 10.r),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.hintText)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 50.h,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.r),
                          child: CachedNetworkImage(
                            imageUrl: buckets.vendorImage.toString(),
                            placeholder: (context, url) =>
                                circularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(
                              Icons.person,
                              size: 40.h,
                              color: AppColors.lightText.withOpacity(0.5),
                            ),
                            fit: BoxFit.cover,
                          ))),
                  wBox(10.h),
                  Container(
                    width: Get.width / 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          buckets.vendorName?.capitalize.toString() ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                        ),
                        hBox(3.h),
                        Text(
                          buckets.vendorAddress.toString(),
                          style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        hBox(2.h),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Text(
                            //   price,
                            //   textAlign: TextAlign.left,
                            //   style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroySemiBold),
                            // ),

                            SvgPicture.asset(ImageConstants.clockIcon,height: 14,colorFilter: ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),),
                            wBox(3.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                "30-50 mins",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppFontStyle.text_13_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                              ),
                            ),
                            Text(
                              " • ",
                              textAlign: TextAlign.left,
                              style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                            ),
                            SvgPicture.asset(ImageConstants.scooterImage,height: 14,colorFilter: ColorFilter.mode(AppColors.darkText.withOpacity(0.8), BlendMode.srcIn),),
                            wBox(3.w),
                            Padding(
                              padding: const EdgeInsets.only(top: 3.0),
                              child: Text(
                                "\$5 Delivery",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: AppFontStyle.text_13_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                              ),
                            ),
                          ],
                        ),
                        hBox(5.h),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Obx(
                  //   () => deleteVendorController.rxRequestStatus.value ==
                  //               Status.LOADING &&
                  //           buckets.isVendorDelete.value == true
                  //       ? Center(
                  //           child: Padding(
                  //             padding:
                  //                 const EdgeInsets.only(top: 10, right: 22),
                  //             child: Row(
                  //               children: [
                  //                 circularProgressIndicator(size: 15.h),
                  //                 wBox(2.h),
                  //               ],
                  //             ),
                  //           ),
                  //         )
                  //       :

                    Padding(
                      padding: REdgeInsets.only(right:2,top:5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // Obx(
                          //   ()=>SizedBox(
                          //     height: 20,
                          //     width: 20,
                          //     child: Checkbox(
                          //       activeColor: AppColors.primary,
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(5),
                          //       ),
                          //       value: buckets.isChecked.value,
                          //       side: BorderSide(
                          //         color: AppColors.black,
                          //       ),
                          //       onChanged: (value) {
                          //         buckets.isChecked.value = !buckets.isChecked.value;
                          //       },
                          //     ),
                          //   ),
                          // ),
                          // hBox(10.h),
                          Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      showRemoveVendorDialog(
                                          index: index,
                                          cartId: buckets.cartId.toString());
                                      // buckets.isVendorDelete.value = true;
                                      // deleteVendorController.deleteProductApi(cartId: buckets.cartId.toString());
                                    },
                                    child: Text(
                                      "Remove",
                                      style: AppFontStyle.text_14_400(AppColors.red,family: AppFontFamily.gilroyMedium),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                // ),
                                            ),
                        ],
                      ),
                    ),
                ],
              ),
              hBox(8.h),
              Row(
                children: [
                  Text("Delivery Type", style: AppFontStyle.text_16_500(
                      AppColors.darkText,family: AppFontFamily.gilroyMedium),),
                  const Spacer(),
                  Obx(
                        ()=> InkWell(
                      onTap: () {
                        if(buckets.isDelivery.value  == true){
                          buckets.isDelivery.value  == false;
                          controller.groceryOrderTypeApi(index: index, cartId: buckets.cartId.toString(), type: "self");
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: 30,width: 84,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color:buckets.isDelivery.value ? AppColors.lightPrimary : AppColors.primary,width: 1),
                        ),
                        child: Center(child: (controller.rxRequestStatusOrderType.value == Status.LOADING &&
                            controller.loadingIndex.value == index && controller.loadingType.value == "self") ?
                        circularProgressIndicator2() : Text("Self", style: AppFontStyle.text_14_400(
                            buckets.isDelivery.value ? AppColors.darkText :AppColors.primary,family: AppFontFamily.gilroyMedium),)),
                      ),
                    ),
                  ),
                  wBox(8.w),
                  Obx(
                        ()=> InkWell(
                      onTap: () {
                        if(buckets.isDelivery.value  == false){
                          buckets.isDelivery.value  == true;
                          controller.groceryOrderTypeApi(index: index, cartId: buckets.cartId.toString(), type: "delivery");
                      }},
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: 30,width: 84,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color:buckets.isDelivery.value ? AppColors.primary : AppColors.lightPrimary,width: 1),
                        ),
                        child: Center(child: (controller.rxRequestStatusOrderType.value == Status.LOADING &&
                            controller.loadingIndex.value == index && controller.loadingType.value == "delivery") ?
                        circularProgressIndicator2() :Text("Delivery", style: AppFontStyle.text_14_400(
                          buckets.isDelivery.value ? AppColors.primary : AppColors.darkText,family: AppFontFamily.gilroyMedium,
                        ),
                        ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              hBox(8.h),
              Divider(thickness: .5.w, color: AppColors.hintText),
              hBox(6.h),
              ListView.separated(
                padding: EdgeInsets.all(0.r),
                itemCount: buckets.bucket!.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index1) {
                  var items = buckets.bucket![index1];
                  return Row(
                    children: [
                      // Expanded(
                      //   flex: 1,
                      //   child: Transform.scale(
                      //     scale: 1.2,
                      //     child: isLoading
                      //         ? Shimmer.fromColors(
                      //       baseColor: Colors.grey.shade300,
                      //       highlightColor: Colors.grey.shade100,
                      //       child: const Checkbox(
                      //         value: false,
                      //         onChanged: null,
                      //       ),
                      //     )
                      //         : Checkbox(
                      //       activeColor: AppColors.black,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //       value: controller.cartData.value.cart!
                      //           .decodedAttribute![index].checked ==
                      //           'true',
                      //       side: BorderSide(
                      //         color: AppColors.black,
                      //       ),
                      //       onChanged: (value) {
                      //         if (checkedUncheckedController
                      //             .rxRequestStatus.value !=
                      //             Status.LOADING) {
                      //           controller
                      //               .cartData
                      //               .value
                      //               .cart!
                      //               .decodedAttribute?[index]
                      //               .isSelectedLoading
                      //               .value = true;
                      //           bool newCheckedStatus = !(controller
                      //               .cartData
                      //               .value
                      //               .cart!
                      //               .decodedAttribute![index]
                      //               .checked ==
                      //               'true');
                      //
                      //           checkedUncheckedController.checkedUncheckedApi(
                      //             productId: controller.cartData.value.cart!
                      //                 .decodedAttribute![index].productId
                      //                 .toString(),
                      //             cartId: controller.cartData.value.cart!.id
                      //                 .toString(),
                      //             status: newCheckedStatus.toString(),
                      //             countId: controller.cartData.value.cart!
                      //                 .decodedAttribute![index].count
                      //                 .toString(),
                      //           );
                      //         }
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // wBox(10.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child:

                            // isLoading
                            //     ? Shimmer.fromColors(
                            //   baseColor: Colors.grey.shade300,
                            //   highlightColor: Colors.grey.shade100,
                            //   child: Container(
                            //     color: Colors.white,
                            //     height: 100.h,
                            //     width: 100.h,
                            //   ),
                            // )
                            //     :

                            GestureDetector(
                          onTap: () {
                            grocerySpecificProductController
                                .pharmaSpecificProductApi(
                              productId: controller.cartData.value.cart!
                                  .buckets![index].bucket![index1].productId
                                  .toString(),
                              categoryId: controller.cartData.value.cart!
                                  .buckets![index].bucket![index1].productId
                                  .toString(),
                            );
                            print(
                                "category_id ${controller.cartData.value.cart!.buckets![index].bucket![index1].productId.toString()}");
                            print(
                                "category Name ${controller.cartData.value.cart!.buckets![index].bucket![index1].productId.toString()}");
                            print(
                                "product Id ${controller.cartData.value.cart!.buckets![index].bucket![index1].productId.toString()}");

                            Get.to(() => GroceryProductDetailsScreen(
                                  productId: controller.cartData.value.cart!
                                      .buckets![index].bucket![index1].productId
                                      .toString(),
                                  categoryId: controller
                                      .cartData
                                      .value
                                      .cart!
                                      .buckets![index]
                                      .bucket![index1]
                                      .categoryId
                                      .toString(),
                                  categoryName: controller
                                      .cartData
                                      .value
                                      .cart!
                                      .buckets![index]
                                      .bucket![index1]
                                      .categoryName
                                      .toString(),
                                  fromCart: true,
                                ));
                          },
                          child: CachedNetworkImage(
                            imageUrl: items.productImage.toString(),
                            height: 100.h,
                            width: 100.h,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: AppColors.gray,
                              highlightColor: AppColors.lightText,
                              child: Container(
                                color: AppColors.gray,
                                height: 100.h,
                                width: 100.h,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                      wBox(10.h),
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
                                // isLoading
                                //     ? Shimmer.fromColors(
                                //   baseColor: Colors.grey.shade300,
                                //   highlightColor: Colors.grey.shade100,
                                //   child: Container(
                                //     height: 14.h,
                                //     width: 110.w,
                                //     color: Colors.white,
                                //   ),
                                // )
                                //     :

                                SizedBox(
                                  width: 110.w,
                                  child: Text(
                                    items.productName?.capitalize.toString() ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: AppFontStyle.text_16_400(
                                        AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                  ),
                                ),
                                // Obx(
                                //   () => deleteProductController
                                //                   .rxRequestStatus.value ==
                                //               Status.LOADING &&
                                //           items.isDelete.value == true
                                //       ? Center(
                                //           child: Row(
                                //             children: [
                                //               circularProgressIndicator(
                                //                   size: 15.h),
                                //               wBox(2.h),
                                //             ],
                                //           ),
                                //         )
                                //       :
                                GestureDetector(
                                  onTap: () {
                                    // items.isDelete.value = true;
                                    // deleteProductController.deleteProductApi(
                                    //         productId:
                                    //         countId:
                                    //         cartId:
                                    // );
                                    showDeleteProductDialog(
                                      cartId: buckets.cartId.toString(),
                                      productId: items.productId.toString(),
                                      countId: items.count.toString(),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/svg/delete-outlined.svg",
                                    height: 20,
                                  ),
                                ),
                                // ),
                              ],
                            ),
                            hBox(15.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // isLoading
                                //     ? Shimmer.fromColors(
                                //   baseColor: Colors.grey.shade300,
                                //   highlightColor: Colors.grey.shade100,
                                //   child: Container(
                                //     height: 14.h,
                                //     width: 60.w,
                                //     color: Colors.white,
                                //   ),
                                // )
                                //     :
                                Text(
                                  "\$${items.productTotalPrice.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.text_14_600(
                                      AppColors.primary,family: AppFontFamily.gilroyRegular),
                                ),
                                // isLoading
                                //     ?
                                // Shimmer.fromColors(
                                //   baseColor: Colors.grey.shade300,
                                //   highlightColor: Colors.grey.shade100,
                                //   child: Container(
                                //     height: 35.h,
                                //     width: 90.w,
                                //     decoration: BoxDecoration(
                                //       color: Colors.white,
                                //       borderRadius: BorderRadius.circular(50.r),
                                //     ),
                                //   ),
                                // )
                                //     :
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
                                            items.isLoading.value == true
                                        ? Center(
                                            child: circularProgressIndicator2())
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () {
                                                  // if (controller
                                                  //     .cartData
                                                  //     .value
                                                  //     .cart!
                                                  //     .decodedAttribute![
                                                  // index]
                                                  //     .checked !=
                                                  //     "false") {
                                                  if (items.quantity == 1) {
                                                    Utils.showToast(
                                                        "Qty can not less then 1");
                                                  } else {
                                                    items.isLoading.value =
                                                        true;
                                                    quantityUpdateController
                                                        .updateQuantityApi(
                                                      cartId: buckets.cartId
                                                          .toString(),
                                                      productId: items.productId
                                                          .toString(),
                                                      countId: items.count
                                                          .toString(),
                                                      productQuantity:
                                                          (items.quantity! - 1)
                                                              .toString(),
                                                    );
                                                  }
                                                  // }
                                                  // else {
                                                  //   Utils.showToast(
                                                  //       "First select product",
                                                  //       gravity: ToastGravity
                                                  //           .CENTER);
                                                  // }
                                                },
                                                child: Icon(
                                                  Icons.remove,
                                                  size: 16.w,
                                                ),
                                              ),
                                              Text(
                                                items.quantity.toString(),
                                                style: AppFontStyle.text_14_400(
                                                    AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () {
                                                  // if (controller
                                                  //     .cartData
                                                  //     .value
                                                  //     .cart!
                                                  //     .decodedAttribute![
                                                  // index]
                                                  //     .checked !=
                                                  //     "false") {

                                                  items.isLoading.value = true;
                                                  quantityUpdateController
                                                      .updateQuantityApi(
                                                    cartId: buckets.cartId
                                                        .toString(),
                                                    productId: items.productId
                                                        .toString(),
                                                    countId:
                                                        items.count.toString(),
                                                    productQuantity:
                                                        (items.quantity! + 1)
                                                            .toString(),
                                                  );
                                                  // } else {
                                                  //   Utils.showToast(
                                                  //       "First select product");
                                                  // }
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
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return hBox(20.h);
                },
              ),

              // Row(
              //   children: [
              //     // Expanded(
              //     //   flex: 1,
              //     //   child: Transform.scale(
              //     //     scale: 1.2,
              //     //     child: isLoading
              //     //         ? Shimmer.fromColors(
              //     //       baseColor: Colors.grey.shade300,
              //     //       highlightColor: Colors.grey.shade100,
              //     //       child: const Checkbox(
              //     //         value: false,
              //     //         onChanged: null,
              //     //       ),
              //     //     )
              //     //         : Checkbox(
              //     //       activeColor: AppColors.black,
              //     //       shape: RoundedRectangleBorder(
              //     //         borderRadius: BorderRadius.circular(5),
              //     //       ),
              //     //       value: controller.cartData.value.cart!
              //     //           .decodedAttribute![index].checked ==
              //     //           'true',
              //     //       side: BorderSide(
              //     //         color: AppColors.black,
              //     //       ),
              //     //       onChanged: (value) {
              //     //         if (checkedUncheckedController
              //     //             .rxRequestStatus.value !=
              //     //             Status.LOADING) {
              //     //           controller
              //     //               .cartData
              //     //               .value
              //     //               .cart!
              //     //               .decodedAttribute?[index]
              //     //               .isSelectedLoading
              //     //               .value = true;
              //     //           bool newCheckedStatus = !(controller
              //     //               .cartData
              //     //               .value
              //     //               .cart!
              //     //               .decodedAttribute![index]
              //     //               .checked ==
              //     //               'true');
              //     //
              //     //           checkedUncheckedController.checkedUncheckedApi(
              //     //             productId: controller.cartData.value.cart!
              //     //                 .decodedAttribute![index].productId
              //     //                 .toString(),
              //     //             cartId: controller.cartData.value.cart!.id
              //     //                 .toString(),
              //     //             status: newCheckedStatus.toString(),
              //     //             countId: controller.cartData.value.cart!
              //     //                 .decodedAttribute![index].count
              //     //                 .toString(),
              //     //           );
              //     //         }
              //     //       },
              //     //     ),
              //     //   ),
              //     // ),
              //     // wBox(10.h),
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(20.r),
              //       child: isLoading
              //           ? Shimmer.fromColors(
              //         baseColor: Colors.grey.shade300,
              //         highlightColor: Colors.grey.shade100,
              //         child: Container(
              //           color: Colors.white,
              //           height: 100.h,
              //           width: 100.h,
              //         ),
              //       )
              //           : GestureDetector(
              //         onTap: () {
              //           pharmaSpecificProductController
              //               .pharmaSpecificProductApi(
              //               productId: controller.cartData.value.cart!
              //                   .decodedAttribute![index].productId
              //                   .toString(),
              //               categoryId: controller.cartData.value.cart!
              //                   .decodedAttribute![index].categoryId
              //                   .toString());
              //           print(
              //               "category_id ${controller.cartData.value.cart!.decodedAttribute![index].categoryId.toString()}");
              //           print(
              //               "category Name ${controller.cartData.value.cart!.decodedAttribute![index].categoryName.toString()}");
              //           print(
              //               "product Id ${controller.cartData.value.cart!.decodedAttribute![index].productId.toString()}");
              //           // Get.to(PharmacyProductDetailsScreen(
              //           //   productId: controller.cartData.value.cart!
              //           //       .decodedAttribute![index].productId
              //           //       .toString(),
              //           //   categoryId: controller.cartData.value.cart!
              //           //       .decodedAttribute![index].categoryId
              //           //       .toString(),
              //           //   categoryName: controller.cartData.value.cart!
              //           //       .decodedAttribute![index].categoryName
              //           //       .toString(),
              //           // ));
              //           Get.to(() => PharmacyProductDetailsScreen( productId: controller.cartData.value.cart!
              //               .decodedAttribute![index].productId
              //               .toString(),
              //             categoryId: controller.cartData.value.cart!
              //                 .decodedAttribute![index].categoryId
              //                 .toString(),
              //             categoryName: controller.cartData.value.cart!
              //                 .decodedAttribute![index].categoryName
              //                 .toString(),));
              //
              //         },
              //         child: CachedNetworkImage(
              //           imageUrl: controller.cartData.value.cart!
              //               .decodedAttribute![index].productImage
              //               .toString(),
              //           height: 100.h,
              //           width: 100.h,
              //           fit: BoxFit.cover,
              //           placeholder: (context, url) => Shimmer.fromColors(
              //             baseColor: AppColors.gray,
              //             highlightColor: AppColors.lightText,
              //             child: Container(
              //               color: AppColors.gray,
              //               height: 100.h,
              //               width: 100.h,
              //             ),
              //           ),
              //           errorWidget: (context, url, error) =>
              //           const Icon(Icons.error),
              //         ),
              //       ),
              //     ),
              //     wBox(10.h),
              //     Expanded(
              //       flex: 6,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           hBox(5.h),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               isLoading
              //                   ? Shimmer.fromColors(
              //                 baseColor: Colors.grey.shade300,
              //                 highlightColor: Colors.grey.shade100,
              //                 child: Container(
              //                   height: 14.h,
              //                   width: 110.w,
              //                   color: Colors.white,
              //                 ),
              //               )
              //                   : SizedBox(
              //                 width: 110.w,
              //                 child: Text(
              //                   controller.cartData.value.cart!
              //                       .decodedAttribute![index].productName
              //                       .toString(),
              //                   overflow: TextOverflow.ellipsis,
              //                   maxLines: 2,
              //                   style: AppFontStyle.text_14_500(
              //                       AppColors.darkText),
              //                 ),
              //               ),
              //               Obx(
              //                     () => deleteProductController
              //                     .rxRequestStatus.value ==
              //                     Status.LOADING &&
              //                     controller
              //                         .cartData
              //                         .value
              //                         .cart!
              //                         .decodedAttribute![index]
              //                         .isDelete
              //                         .value ==
              //                         true
              //                     ? Center(
              //                   child: Row(
              //                     children: [
              //                       circularProgressIndicator(size: 15.h),
              //                       wBox(2.h),
              //                     ],
              //                   ),
              //                 )
              //                     : GestureDetector(
              //                   onTap: () {
              //                     controller
              //                         .cartData
              //                         .value
              //                         .cart!
              //                         .decodedAttribute![index]
              //                         .isDelete
              //                         .value = true;
              //                     deleteProductController.deleteProductApi(
              //                       productId: controller
              //                           .cartData
              //                           .value
              //                           .cart!
              //                           .decodedAttribute![index]
              //                           .productId
              //                           .toString(),
              //                       countId: controller.cartData.value.cart!
              //                           .decodedAttribute![index].count
              //                           .toString(),
              //                     );
              //                   },
              //                   child: SvgPicture.asset(
              //                     "assets/svg/delete-outlined.svg",
              //                     height: 20,
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //           hBox(15.h),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               isLoading
              //                   ? Shimmer.fromColors(
              //                 baseColor: Colors.grey.shade300,
              //                 highlightColor: Colors.grey.shade100,
              //                 child: Container(
              //                   height: 14.h,
              //                   width: 60.w,
              //                   color: Colors.white,
              //                 ),
              //               )
              //                   : Text(
              //                 "\$${controller.cartData.value.cart!.decodedAttribute![index].totalPrice.toString()}",
              //                 overflow: TextOverflow.ellipsis,
              //                 style: AppFontStyle.text_14_600(
              //                     AppColors.primary),
              //               ),
              //               isLoading
              //                   ? Shimmer.fromColors(
              //                 baseColor: Colors.grey.shade300,
              //                 highlightColor: Colors.grey.shade100,
              //                 child: Container(
              //                   height: 35.h,
              //                   width: 90.w,
              //                   decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     borderRadius: BorderRadius.circular(50.r),
              //                   ),
              //                 ),
              //               )
              //                   : Container(
              //                 height: 35.h,
              //                 width: 90.w,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(50.r),
              //                   border: Border.all(
              //                       width: 0.8.w, color: AppColors.primary),
              //                 ),
              //                 child: Obx(
              //                       () => quantityUpdateController
              //                       .rxRequestStatus.value ==
              //                       Status.LOADING &&
              //                       controller
              //                           .cartData
              //                           .value
              //                           .cart!
              //                           .decodedAttribute![index]
              //                           .isLoading
              //                           .value ==
              //                           true
              //                       ? Center(
              //                       child: circularProgressIndicator2())
              //                       : Row(
              //                     mainAxisAlignment:
              //                     MainAxisAlignment.spaceEvenly,
              //                     children: [
              //                       InkWell(
              //                         splashColor: Colors.transparent,
              //                         highlightColor:
              //                         Colors.transparent,
              //                         onTap: () {
              //                           if (controller
              //                               .cartData
              //                               .value
              //                               .cart!
              //                               .decodedAttribute![
              //                           index]
              //                               .checked !=
              //                               "false") {
              //                             if (controller
              //                                 .cartData
              //                                 .value
              //                                 .cart!
              //                                 .decodedAttribute![
              //                             index]
              //                                 .quantity ==
              //                                 1) {
              //                               Utils.showToast(
              //                                   "Qty can not less then 1");
              //                             } else {
              //                               controller
              //                                   .cartData
              //                                   .value
              //                                   .cart!
              //                                   .decodedAttribute![
              //                               index]
              //                                   .isLoading
              //                                   .value = true;
              //                               quantityUpdateController
              //                                   .updateQuantityApi(
              //                                 productId: controller
              //                                     .cartData
              //                                     .value
              //                                     .cart!
              //                                     .decodedAttribute![
              //                                 index]
              //                                     .productId
              //                                     .toString(),
              //                                 countId: controller
              //                                     .cartData
              //                                     .value
              //                                     .cart!
              //                                     .decodedAttribute![
              //                                 index]
              //                                     .count
              //                                     .toString(),
              //                                 productQuantity: (controller
              //                                     .cartData
              //                                     .value
              //                                     .cart!
              //                                     .decodedAttribute![
              //                                 index]
              //                                     .quantity! -
              //                                     1)
              //                                     .toString(),
              //                               );
              //                             }
              //                           } else {
              //                             Utils.showToast(
              //                                 "First select product",
              //                                 gravity: ToastGravity
              //                                     .CENTER);
              //                           }
              //                         },
              //                         child: Icon(
              //                           Icons.remove,
              //                           size: 16.w,
              //                         ),
              //                       ),
              //                       Text(
              //                         controller
              //                             .cartData
              //                             .value
              //                             .cart!
              //                             .decodedAttribute![index]
              //                             .quantity
              //                             .toString(),
              //                         style: AppFontStyle.text_14_400(
              //                             AppColors.darkText),
              //                       ),
              //                       InkWell(
              //                         splashColor: Colors.transparent,
              //                         highlightColor:
              //                         Colors.transparent,
              //                         onTap: () {
              //                           if (controller
              //                               .cartData
              //                               .value
              //                               .cart!
              //                               .decodedAttribute![
              //                           index]
              //                               .checked !=
              //                               "false") {
              //                             controller
              //                                 .cartData
              //                                 .value
              //                                 .cart!
              //                                 .decodedAttribute![
              //                             index]
              //                                 .isLoading
              //                                 .value = true;
              //                             quantityUpdateController
              //                                 .updateQuantityApi(
              //                               productId: controller
              //                                   .cartData
              //                                   .value
              //                                   .cart!
              //                                   .decodedAttribute![
              //                               index]
              //                                   .productId
              //                                   .toString(),
              //                               countId: controller
              //                                   .cartData
              //                                   .value
              //                                   .cart!
              //                                   .decodedAttribute![
              //                               index]
              //                                   .count
              //                                   .toString(),
              //                               productQuantity: (controller
              //                                   .cartData
              //                                   .value
              //                                   .cart!
              //                                   .decodedAttribute![
              //                               index]
              //                                   .quantity! +
              //                                   1)
              //                                   .toString(),
              //                             );
              //                           } else {
              //                             Utils.showToast(
              //                                 "First select product");
              //                           }
              //                         },
              //                         child: Icon(
              //                           Icons.add,
              //                           size: 16.w,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // hBox(5.h),
              // hBox(10.h),
              // if (controller.cartData.value.cart!.decodedAttribute![index]
              //     .attribute!.isNotEmpty &&
              //     controller.cartData.value.cart!.decodedAttribute![index]
              //         .checked ==
              //         "true")
              //   Padding(
              //     padding: EdgeInsets.only(bottom: 10.h),
              //     child: SizedBox(
              //       width: Get.width,
              //       child: Wrap(
              //         direction: Axis.horizontal,
              //         spacing: 2.w,
              //         runSpacing: 2.w,
              //         children: List.generate(
              //           controller.cartData.value.cart!.decodedAttribute![index]
              //               .attribute!.length,
              //               (addonIndex) {
              //             bool isLast = addonIndex ==
              //                 controller
              //                     .cartData
              //                     .value
              //                     .cart!
              //                     .decodedAttribute![index]
              //                     .attribute!
              //                     .length -
              //                     1;
              //             return Row(
              //               mainAxisSize: MainAxisSize.min,
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   '${controller.cartData.value.cart!.decodedAttribute![index].attribute![addonIndex].itemDetails!.itemName}',
              //                   style:
              //                   AppFontStyle.text_12_400(AppColors.primary),
              //                   overflow: TextOverflow.ellipsis,
              //                   maxLines: 1,
              //                 ),
              //                 Text(
              //                   ' - ',
              //                   style:
              //                   AppFontStyle.text_12_400(AppColors.primary),
              //                   overflow: TextOverflow.ellipsis,
              //                   maxLines: 1,
              //                 ),
              //                 Text(
              //                   '\$${controller.cartData.value.cart!.decodedAttribute![index].attribute![addonIndex].itemDetails!.itemPrice}',
              //                   style:
              //                   AppFontStyle.text_12_400(AppColors.primary),
              //                   overflow: TextOverflow.ellipsis,
              //                   maxLines: 1,
              //                 ),
              //                 if (!isLast)
              //                   Text(
              //                     ',',
              //                     style:
              //                     AppFontStyle.text_12_400(AppColors.primary),
              //                     overflow: TextOverflow.ellipsis,
              //                     maxLines: 1,
              //                   ),
              //               ],
              //             );
              //           },
              //         ),
              //       ),
              //     ),
              //   ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return hBox(20.h);
      },
    );
  }

  FocusNode focusNode = FocusNode();

  Widget promoCode(context) {
    return controller.cartData .value.couponApplied == false
        ? Padding(
          padding: REdgeInsets.symmetric(horizontal: 1.5),
          child: DottedBorder(
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
                    /*  if (controller.cartData.value.cart!.decodedAttribute!
                          .where((item) => item.checked == "true")
                          .isEmpty) {
                        Utils.showToast("Please select a product");
                      } else*/ if (controller
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
                    AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
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
                  // if (controller.couponCodeController.value.text.isNotEmpty) {
                  //   applyCouponController.applyCouponApi(
                  //     cartId: controller.cartData.value.cart?.buckets?.map((e) => e.cartId).toList() ?? [],
                  //     couponCode: controller.couponCodeController.value.text.toString(),
                  //     grandTotal: controller.cartData.value.cart?.grandTotalPrice.toString() ?? "",
                  //   );
                  final carts = controller.cartData.value.cart?.buckets?.map((e) => {
                    "cart_id": e.cartId.toString(),
                    "grand_total": e.specificTotalPrice.toString(),
                  }).toList() ?? [];
                  if (controller.couponCodeController.value.text.isNotEmpty) {
                    applyCouponController.applyCouponApi(
                      carts: carts,
                      couponCode: controller.couponCodeController.value.text.trim(),
                    );
                  } else {
                    Utils.showToast("Please Enter Coupon Code");
                  }
                },
                child: Text(
                  "Apply",
                  style: AppFontStyle.text_16_600(AppColors.primary,family: AppFontFamily.gilroyMedium),
                ),
              ),
              wBox(20.h),
            ],
          ),
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
            right: 0.h,
            top: 0.h,
            child: SizedBox(
              height: 36.h,
              width: 36.h,
              child: applyCouponController.rxRequestStatus.value ==
                  Status.LOADING
                  ? circularProgressIndicator(size: 18.h)
                  :Center(
                child: GestureDetector(
                  onTap: () {
                    // applyCouponController.applyCouponApi(
                    //   cartId: controller.cartData.value.cart?.buckets?.map((e) => e.cartId).toList() ?? [],
                    //   couponCode: controller.cartData.value.appliedCoupon?.code.toString() ?? "",
                    //   grandTotal: controller.cartData.value.cart?.grandTotalPrice.toString() ?? "",
                    // );
                    final carts = controller.cartData.value.cart?.buckets?.map((e) => {
                      "cart_id": e.cartId.toString(),
                      "grand_total": e.specificTotalPrice.toString(),
                    }).toList() ?? [];
                    applyCouponController.applyCouponApi(
                      carts: carts,
                      couponCode: controller.cartData.value.appliedCoupon?.code.toString() ?? "",
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
                        controller.cartData.value.appliedCoupon?.code.toString() ?? "",
                        style: AppFontStyle.text_16_600(AppColors.black,family: AppFontFamily.gilroyRegular),
                      ),
                      wBox(5.h),
                      Text(
                        "Applied",
                        style:
                        AppFontStyle.text_16_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
                      ),
                    ],
                  ),
                  Text(
                    "-\$${controller.cartData.value.cart!.couponDiscount}",
                    style: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
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
        //  checkedUncheckedController.rxRequestStatus.value == Status.LOADING ||
        deleteProductController.rxRequestStatus.value == Status.LOADING ||
        quantityUpdateController.rxRequestStatus.value == Status.LOADING ||
        controller.rxRequestStatusOrderType.value == Status.LOADING;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Payment Details",
          style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(10.h),
        if (isLoading) ...[
          shimmerItem("Regular Price"),
          shimmerItem("Save Amount"),
          // if (controller.cartData.value.cart!.couponApplied != null)
          //   shimmerItem("Coupon Discount"),
          if (controller.cartData.value.addressExists == true)
            shimmerItem("Delivery Charge"),
        ],
        if (!isLoading) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Regular Price",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              ),
              Text(
                "\$${controller.cartData.value.cart!.regularPrice.toString()}",
                style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ],
          ),
          hBox(10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Save Amount",
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              ),
              Text(
                "\$${controller.cartData.value.cart!.saveAmount.toString()}",
                style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ],
          ),
          // if (controller.cartData.value.cart!.couponApplied != null)
          //   Padding(
          //     padding: EdgeInsets.only(top: 10.h),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           "Coupon Discount",
          //           style: AppFontStyle.text_14_400(AppColors.lightText),
          //         ),
          //         Text(
          //           "- \$${controller.cartData.value.cart!.couponDiscount.toString()}",
          //           style: AppFontStyle.text_14_600(AppColors.darkText),
          //         ),
          //       ],
          //     ),
          //   ),
          if (controller.cartData.value.addressExists == true)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Charge",
                    style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                  ),
                  Text(
                    "\$${controller.cartData.value.cart!.deliveryCharge.toString()}",
                    style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
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
        //checkedUncheckedController.rxRequestStatus.value == Status.LOADING ||
        deleteProductController.rxRequestStatus.value == Status.LOADING ||
            quantityUpdateController.rxRequestStatus.value == Status.LOADING;
            controller.rxRequestStatusOrderType.value == Status.LOADING;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total Price",
              style: AppFontStyle.text_14_500(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
            ),
            isLoading
                ? shimmerItem('\$0.00',
                    width: 70, height: 40, secondShimmer: false)
                : Text(
                    "\$${controller.cartData.value.cart!.grandTotalPrice.toString()}",
              style: AppFontStyle.text_22_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
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
                      // isLoading: controller.rxCreateOrderRequestStatus.value == Status.LOADING,
                      onPressed: () {
                        final vendorId = controller.cartData.value.cart?.buckets
                            ?.map((data) => data.vendorId)
                            .toList();
                        final cartId = controller.cartData.value.cart?.buckets
                            ?.map((data) => data.cartId)
                            .toList();
                        final specificTotalPrice = controller
                            .cartData.value.cart?.buckets
                            ?.map((data) => data.specificTotalPrice)
                            .toList();
                        final specificDeliveryCharge = controller
                            .cartData.value.cart?.buckets
                            ?.map((data) => data.specificDeliveryCharge)
                            .toList();

                        final grandTotalPrice = controller.cartData.value.cart?.buckets?.map((data) => data.grandTotalPrice).toList();
                        final couponDiscount = controller.cartData.value.cart?.buckets?.map((data) => data.couponDiscount).toList();

                        Get.toNamed(AppRoutes.checkoutScreen, arguments: {
                          'address_id':
                              controller.cartData.value.address!.id.toString(),
                          'total': controller.cartData.value.cart!.grandTotalPrice
                              .toString(),
                          'coupon_id': controller.cartData.value.appliedCoupon?.id.toString(),
                          'regular_price': controller
                              .cartData.value.cart!.regularPrice
                              .toString(),
                          // 'coupon_discount': controller
                          //     .cartData.value.cart!.couponDiscount
                          //     .toString(),
                          'save_amount': controller
                              .cartData.value.cart!.saveAmount
                              .toString(),
                          'delivery_charge': controller
                              .cartData.value.cart!.deliveryCharge
                              .toString(),
                          'cart_id': cartId,
                          'vendor_id': vendorId,
                          'cart_total': specificTotalPrice,
                          'cart_delivery': specificDeliveryCharge,
                          'wallet': controller.cartData.value.wallet.toString(),
                          'cartType': "grocery",
                          'grandtotal_price' : grandTotalPrice,
                          'coupon_discount': couponDiscount,

                        });
                      },
                      // onPressed: () {
                      //   var selectedItems = controller
                      //       .cartData.value.cart!.decodedAttribute!
                      //       .where((item) => item.checked == "true")
                      //       .map((item) => {
                      //     'name': item.productName,
                      //     'price': "\$${item.totalPrice.toString()}"
                      //   })
                      //       .toList();
                      //
                      //   if (selectedItems.isNotEmpty) {
                      //     selectedItems.forEach((item) {
                      //       print(
                      //           "Selected Product: ${item['name']}, Price: ${item['price']}");
                      //
                      //       Get.toNamed(
                      //         AppRoutes.prescriptionScreen,
                      //         arguments: {
                      //           'address_id': controller
                      //               .cartData.value.address!.id
                      //               .toString(),
                      //           'coupon_id': controller
                      //               .cartData.value.cart!.couponApplied?.id
                      //               .toString(),
                      //           'vendor_id': controller
                      //               .cartData.value.cart!.pharmaId
                      //               .toString(),
                      //           'total': controller
                      //               .cartData.value.cart!.totalPrice
                      //               .toString(),
                      //           'regular_price': controller
                      //               .cartData.value.cart!.regularPrice
                      //               .toString(),
                      //           'coupon_discount': controller
                      //               .cartData.value.cart!.couponDiscount
                      //               .toString(),
                      //           'save_amount': controller
                      //               .cartData.value.cart!.saveAmount
                      //               .toString(),
                      //           'delivery_charge': controller
                      //               .cartData.value.cart!.deliveryCharge
                      //               .toString(),
                      //           'cart_id': controller.cartData.value.cart!.id
                      //               .toString(),
                      //           'wallet':
                      //           controller.cartData.value.wallet.toString(),
                      //           'cartType': "pharmacy",
                      //           'prescription': controller.cartData.value.prescription.toString(),
                      //         },
                      //       );
                      //     });
                      //   } else {
                      //     Utils.showToast(
                      //         "Please select product to proceed to checkout");
                      //   }
                      // },
                      text: "Checkout",
                      textStyle: AppFontStyle.text_16_600(AppColors.white,family: AppFontFamily.gilroyRegular),
                    ),
                  )
                : SizedBox(
                    width: 200.w,
                    height: 55.h,
                    child: CustomElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.addAddressScreen, arguments: {
                          'type': "GroceryCart",
                          "fromcart": false,
                        });
                      },
                      text: "Complete Address",
                      textStyle: AppFontStyle.text_16_600(AppColors.white,family: AppFontFamily.gilroyRegular),
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
                        style: AppFontStyle.text_20_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
      itemCount: controller.cartData.value.coupons?.length ?? 0,
      itemBuilder: (context, index) {
        String daysRemaining = "Expired";
        String? expireDate = controller.cartData.value.coupons?[index].expireDate;

        if (expireDate != null && expireDate.trim().isNotEmpty) {
          try {
            DateTime expiryDate = DateFormat("dd-MM-yyyy").parse(expireDate.trim());
            DateTime currentDate = DateTime.now();
            Duration difference = expiryDate.difference(currentDate);

            daysRemaining = difference.inDays > 0
                ? "${difference.inDays} days remaining"
                : "Expired";
          } catch (e) {
            debugPrint("❌ Invalid date format: $expireDate");
            daysRemaining = "Expired";
          }
        }

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
                            controller.cartData.value.coupons![index].value ?? "0",
                            style: AppFontStyle.text_22_600(Colors.white,
                                height: 1.h,family: AppFontFamily.gilroyMedium),
                          ),
                          Text(
                    controller.cartData.value.coupons![index].couponType
                                .toString() ==
                                "percentage"
                                ? "%"
                                : "\$",
                            style: AppFontStyle.text_14_400(Colors.white,family: AppFontFamily.gilroyRegular),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "OFF",
                      style: AppFontStyle.text_15_400(Colors.white,family: AppFontFamily.gilroyRegular),
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
                      controller.cartData.value.coupons![index].title.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                    ),
                    hBox(10),
                    FittedBox(
                      child: Text(
                        controller.cartData.value.coupons![index].code
                            .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold,
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
                    // FittedBox(
                    //   child: Text(
                    //     daysRemaining.toString(),
                    //     overflow: TextOverflow.ellipsis,
                    //     style: AppFontStyle.text_12_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                    //   ),
                    // ),
                    // hBox(8),
                    // if (controller.cartData.value.coupons![index]
                    //     .toString() !=
                    //     "Expired")
                      CustomElevatedButton(
                        textStyle:
                        AppFontStyle.text_14_400(Colors.white, height: 1.0,family: AppFontFamily.gilroyMedium),
                        width: 85.w,
                        height: 36.h,
                        text: "Select",
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
      separatorBuilder: (context, index) => hBox(20.h),
    );
  }

  Future showDeleteProductDialog({
    required String cartId,
    required String productId,
    required String countId,
  }) {
    return Get.dialog(
      PopScope(
        canPop: true,
        child: AlertDialog.adaptive(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete Product',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontFamily: AppFontFamily.gilroyRegular,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Are you sure you want to delete this product?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                  fontFamily: AppFontFamily.gilroyMedium,

                ),
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      height: 40.h,
                      color: AppColors.black,
                      onPressed: () {
                        Get.back();
                      },
                      text: "Cancel",
                      textStyle: AppFontStyle.text_16_400(AppColors.darkText ,family: AppFontFamily.gilroyMedium,),
                  ),),
                  wBox(15),
                  Obx(
                    () => Expanded(
                      child: CustomElevatedButton(
                        fontFamily: AppFontFamily.gilroyMedium,
                        height: 40.h,
                        isLoading:
                            deleteProductController.rxRequestStatus.value ==
                                Status.LOADING,
                        onPressed: () {
                          deleteProductController.deleteProductApi(
                            cartId: cartId,
                            productId: productId,
                            countId: countId,
                          );
                        },
                        text: "Yes",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  Future showRemoveVendorDialog({
    required int index,
    required String cartId,
  }) {
    return Get.dialog(
      PopScope(
        canPop: true,
        child: AlertDialog.adaptive(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Remove Products',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppFontFamily.gilroyRegular,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'Are you sure you want to delete all products?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: AppFontFamily.gilroyMedium,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      height: 40.h,
                      color: AppColors.black,
                      onPressed: () {
                        Get.back();
                      },
                      text: "Cancel",
                      fontFamily: AppFontFamily.gilroyMedium,
                    ),
                  ),
                  wBox(15),
                  Obx(
                    () => Expanded(
                      child: CustomElevatedButton(
                        fontFamily: AppFontFamily.gilroyMedium,
                        height: 40.h,
                        isLoading:
                            deleteVendorController.rxRequestStatus.value ==
                                    Status.LOADING &&
                                controller.cartData.value.cart!.buckets![index]
                                        .isVendorDelete.value ==
                                    true,
                        onPressed: () {
                          controller.cartData.value.cart!.buckets![index]
                              .isVendorDelete.value = true;
                          deleteVendorController.deleteProductApi(
                              cartId: cartId);
                        },
                        text: "Yes",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

}
