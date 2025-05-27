import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';
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
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/shared/theme/font_family.dart';

class RestaurantCartScreen extends StatefulWidget {
  final bool isBack;

  const RestaurantCartScreen({super.key, this.isBack = false});

  @override
  State<RestaurantCartScreen> createState() => _RestaurantCartScreenState();
}

class _RestaurantCartScreenState extends State<RestaurantCartScreen> {

  final RestaurantCartController controller = Get.put(RestaurantCartController());
  final QuantityController quantityUpdateController = Get.put(QuantityController());
  final DeleteProductController deleteProductController = Get.put(DeleteProductController());
  final ApplyCouponController applyCouponController = Get.put(ApplyCouponController());
  final CheckedUncheckedController checkedUncheckedController = Get.put(CheckedUncheckedController());
  final specific_Product_Controller specific_product_controllerontroller = Get.put(specific_Product_Controller());

  @override
  void initState() {
    controller.getRestaurantCartApi();
    // controller.isCartScreen.value = false;
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
            style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
          ),
        ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: circularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet' || controller.error.value == 'InternetExceptionWidget') {
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
                            style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                          ),
                          hBox(5.h),
                          Text(
                            "Explore more and shortlist some items",
                            style:
                                AppFontStyle.text_16_400(AppColors.mediumText,family: AppFontFamily.gilroyRegular),
                          ),
                        ],
                      )
                    : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _scrollController,
                      child: Column(
                        children: [
                          controller.cartData.value.addressExists == true
                              ? Padding(
                            padding: REdgeInsets.symmetric(horizontal: 20.h),
                                child: address(),
                              )
                              : Padding(
                            padding: REdgeInsets.symmetric(horizontal: 20.h),
                                child: locationAddress(),
                              ),
                          hBox(20.h),
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 20.h),
                            child: cartItems(),
                          ),
                          hBox(20.h),
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 20.h),
                            child: promoCode(context),
                          ),
                          hBox(30.h),
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 20.h),
                            child: paymentDetails(),
                          ),
                          // hBox(50.h),
                          // moreAddToCart(),
                          hBox(20.h),
                          Divider(thickness: .2.w, color: AppColors.hintText),
                          hBox(15.h),
                          Padding(
                            padding: REdgeInsets.symmetric(horizontal: 20.h),
                            child: checkoutButton(),
                          ),
                          hBox(widget.isBack != true ? 100.h : 30.h)
                        ],
                      ),
                    ),
              );
          }
        }),
      ),
    );
  }

  Widget moreAddToCart() {
    return Container(
      // height: 200,
      width: Get.width,
      decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.03),),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text("You may be interested in... ",
            style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
          ),
            hBox(20.h),
           ListView.separated(
             physics: const NeverScrollableScrollPhysics(),
             shrinkWrap: true,
               itemCount: 2,
               itemBuilder: (context, index) {
             return  Row(
               children: [
                 ClipRRect(
                   borderRadius: BorderRadius.circular(20.r),
                   child: Obx(
                         () => GestureDetector(
                       onTap: () {
                         // if (controller.cartData.value.cart!
                         //     .decodedAttribute![index].status ==
                         //     "1") {
                         //   specific_product_controllerontroller
                         //       .specific_Product_Api(
                         //       productId: controller
                         //           .cartData
                         //           .value
                         //           .cart!
                         //           .decodedAttribute![index]
                         //           .productId
                         //           .toString(),
                         //       categoryId: controller
                         //           .cartData
                         //           .value
                         //           .cart!
                         //           .decodedAttribute![index]
                         //           .categoryId
                         //           .toString());
                         //   // controller.isCartScreen.value = true;
                         //   // print("is cart screen : ${controller.isCartScreen.value }");
                         //
                         //   // Get.removeRoute("/ProductDetailsScreen");
                         //   Get.to(() => ProductDetailsScreen(
                         //     productId: controller.cartData.value.cart!
                         //         .decodedAttribute![index].productId
                         //         .toString(),
                         //     categoryId: controller
                         //         .cartData
                         //         .value
                         //         .cart!
                         //         .decodedAttribute![index]
                         //         .categoryId
                         //         .toString(),
                         //     categoryName: controller
                         //         .cartData
                         //         .value
                         //         .cart!
                         //         .decodedAttribute![index]
                         //         .categoryName
                         //         .toString(),
                         //     fromCart: true,
                         //   ));
                         // } else if (controller.cartData.value.cart!
                         //     .decodedAttribute![index].status ==
                         //     "0") {
                         //   Utils.showToast("Product not available.");
                         // }
                       },
                       child: CachedNetworkImage(
                         memCacheHeight: memCacheHeight,
                         imageUrl: controller.cartData.value.cart!
                             .decodedAttribute![0].productImage
                             .toString(),
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
                 ),
                 wBox(10.h),
                 Expanded(
                   flex: 6,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                               controller.cartData.value.cart!
                                   .decodedAttribute![0].productName
                                   .toString(),
                               overflow: TextOverflow.ellipsis,
                               maxLines: 2,
                               style: AppFontStyle.text_16_400(
                                   AppColors.darkText,family: AppFontFamily.gilroyMedium),
                             ),
                           ),
                           // Obx(
                           //   () =>
                           // deleteProductController
                           //                 .rxRequestStatus.value ==
                           //             Status.LOADING &&
                           //         controller
                           //                 .cartData
                           //                 .value
                           //                 .cart!
                           //                 .decodedAttribute![index]
                           //                 .isDelete
                           //                 .value ==
                           //             true
                           //     ? Center(
                           //         child: Row(
                           //           children: [
                           //             circularProgressIndicator(size: 15.h),
                           //             wBox(2.h),
                           //           ],
                           //         ),
                           //       )
                           //     :
                           // ),
                         ],
                       ),
                       hBox(5.h),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
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
                             "\$${controller.cartData.value.cart!.decodedAttribute![0].totalPrice.toString()}",
                             overflow: TextOverflow.ellipsis,
                             style: AppFontStyle.text_15_600(
                                 AppColors.primary,family: AppFontFamily.gilroyRegular),
                           ),
                           wBox(8.w),
                           Text(
                               "\$${controller.cartData.value.cart!.decodedAttribute![0].totalPrice.toString()}",
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle( color: AppColors.lightText,fontSize: 15.sp,fontFamily: AppFontFamily.gilroyRegular,fontWeight: FontWeight.w400,decoration: TextDecoration.lineThrough,decorationColor: AppColors.lightText)
                             // AppFontStyle.text_15_600(
                             //     AppColors.primary,family: AppFontFamily.gilroyRegular),
                           ),
                         ],
                       ),
                       hBox(10.h),
                       CustomElevatedButton(
                         height: 36.h,
                         width: 110.w,
                         onPressed: () {},
                         child: Text("Add to cart",
                           style: AppFontStyle.text_12_400(
                               AppColors.white,family: AppFontFamily.gilroyMedium),
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             );
           }, separatorBuilder: (context, index) => hBox(25.h)),
            hBox(8.h),
        ],
        ),
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
                  'type': "RestaurantCart",
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
        hBox(8.h),
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
                controller.cartData.value.address!.addressType
                    .toString()
                    .capitalizeFirst
                    .toString(),
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
      itemCount: controller.cartData.value.cart!.decodedAttribute!.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        bool isLoading = checkedUncheckedController.rxRequestStatus.value == Status.LOADING &&
            controller.cartData.value.cart!.decodedAttribute?[index].isSelectedLoading.value == true;
        return Column(
          children: [
            Row(
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
                                bool newCheckedStatus = !(controller
                                        .cartData
                                        .value
                                        .cart!
                                        .decodedAttribute![index]
                                        .checked ==
                                    'true');

                                checkedUncheckedController.checkedUncheckedApi(
                                    productId: controller.cartData.value.cart!
                                        .decodedAttribute![index].productId
                                        .toString(),
                                    cartId: controller.cartData.value.cart!.id
                                        .toString(),
                                    status: newCheckedStatus.toString(),
                                    countId: controller.cartData.value.cart!
                                        .decodedAttribute![index].count
                                        .toString());
                              }
                            },
                          ),
                  ),
                ),
                wBox(10.h),
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
                      : Obx(
                          () => GestureDetector(
                            onTap: () {
                              if (controller.cartData.value.cart!
                                      .decodedAttribute![index].status ==
                                  "1") {
                                specific_product_controllerontroller
                                    .specific_Product_Api(
                                        productId: controller
                                            .cartData
                                            .value
                                            .cart!
                                            .decodedAttribute![index]
                                            .productId
                                            .toString(),
                                        categoryId: controller
                                            .cartData
                                            .value
                                            .cart!
                                            .decodedAttribute![index]
                                            .categoryId
                                            .toString());
                                // controller.isCartScreen.value = true;
                                // print("is cart screen : ${controller.isCartScreen.value }");

                                // Get.removeRoute("/ProductDetailsScreen");
                                Get.to(() => ProductDetailsScreen(
                                      productId: controller.cartData.value.cart!
                                          .decodedAttribute![index].productId
                                          .toString(),
                                      categoryId: controller
                                          .cartData
                                          .value
                                          .cart!
                                          .decodedAttribute![index]
                                          .categoryId
                                          .toString(),
                                      categoryName: controller
                                          .cartData
                                          .value
                                          .cart!
                                          .decodedAttribute![index]
                                          .categoryName
                                          .toString(),
                                      fromCart: true,
                                    ));
                              } else if (controller.cartData.value.cart!
                                      .decodedAttribute![index].status ==
                                  "0") {
                                Utils.showToast("Product not available.");
                              }
                            },
                            child: CachedNetworkImage(
                              memCacheHeight: memCacheHeight,
                              imageUrl: controller.cartData.value.cart!
                                  .decodedAttribute![index].productImage
                                  .toString(),
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
                                    style: AppFontStyle.text_14_600(
                                        AppColors.darkText,family: AppFontFamily.gilroyRegular),
                                  ),
                                ),
                          // Obx(
                          //   () =>
                          // deleteProductController
                          //                 .rxRequestStatus.value ==
                          //             Status.LOADING &&
                          //         controller
                          //                 .cartData
                          //                 .value
                          //                 .cart!
                          //                 .decodedAttribute![index]
                          //                 .isDelete
                          //                 .value ==
                          //             true
                          //     ? Center(
                          //         child: Row(
                          //           children: [
                          //             circularProgressIndicator(size: 15.h),
                          //             wBox(2.h),
                          //           ],
                          //         ),
                          //       )
                          //     :
                          GestureDetector(
                            onTap: () {
                              showDeleteProductDialog(
                                  productId: controller.cartData.value.cart!
                                      .decodedAttribute![index].productId
                                      .toString(),
                                  countId: controller.cartData.value.cart!
                                      .decodedAttribute![index].count
                                      .toString());
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
                                  style: AppFontStyle.text_14_600(
                                      AppColors.primary,family: AppFontFamily.gilroyRegular),
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
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () {
                                                  if (controller
                                                          .cartData
                                                          .value
                                                          .cart!
                                                          .decodedAttribute![
                                                              index]
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
                                                          .decodedAttribute![
                                                              index]
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
                                                        countId: controller
                                                            .cartData
                                                            .value
                                                            .cart!
                                                            .decodedAttribute![
                                                                index]
                                                            .count
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
                                                        "First select product",
                                                        gravity: ToastGravity
                                                            .CENTER);
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
                                                    AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () {
                                                  if (controller
                                                          .cartData
                                                          .value
                                                          .cart!
                                                          .decodedAttribute![
                                                              index]
                                                          .checked !=
                                                      "false") {
                                                    controller
                                                        .cartData
                                                        .value
                                                        .cart!
                                                        .decodedAttribute![
                                                            index]
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
                                                      countId: controller
                                                          .cartData
                                                          .value
                                                          .cart!
                                                          .decodedAttribute![
                                                              index]
                                                          .count
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
                    ],
                  ),
                ),
              ],
            ),
            hBox(5.h),
            hBox(10.h),
            if (controller.cartData.value.cart!.decodedAttribute![index]
                    .attribute!.isNotEmpty &&
                controller.cartData.value.cart!.decodedAttribute![index]
                        .checked ==
                    "true")
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: SizedBox(
                  width: Get.width,
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 2.w,
                    runSpacing: 2.w,
                    children: List.generate(
                      controller.cartData.value.cart!.decodedAttribute![index]
                          .attribute!.length,
                      (addonIndex) {
                        bool isLast = addonIndex ==
                            controller
                                    .cartData
                                    .value
                                    .cart!
                                    .decodedAttribute![index]
                                    .attribute!
                                    .length -
                                1;
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${controller.cartData.value.cart!.decodedAttribute![index].attribute![addonIndex].itemDetails!.itemName}',
                              style:
                                  AppFontStyle.text_12_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              ' - ',
                              style:
                                  AppFontStyle.text_12_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text(
                              '\$${controller.cartData.value.cart!.decodedAttribute![index].attribute![addonIndex].itemDetails!.itemPrice}',
                              style:
                                  AppFontStyle.text_12_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            if (!isLast)
                              Text(
                                ',',
                                style:
                                    AppFontStyle.text_12_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (controller.cartData.value.cart!.decodedAttribute![index].addons!
                    .isNotEmpty &&
                controller.cartData.value.cart!.decodedAttribute![index]
                        .checked ==
                    "true")
              SizedBox(
                width: Get.width,
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 2.w,
                  runSpacing: 2.w,
                  children: List.generate(
                    controller.cartData.value.cart!.decodedAttribute![index]
                        .addons!.length,
                    (addonIndex) {
                      bool isLast = addonIndex ==
                          controller.cartData.value.cart!
                                  .decodedAttribute![index].addons!.length -
                              1;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${controller.cartData.value.cart!.decodedAttribute![index].addons![addonIndex].name}',
                            style:
                                AppFontStyle.text_12_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            ' - ',
                            style:
                                AppFontStyle.text_12_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            '\$${controller.cartData.value.cart!.decodedAttribute![index].addons![addonIndex].price}',
                            style:
                                AppFontStyle.text_12_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          if (!isLast)
                            Text(
                              ',',
                              style:
                                  AppFontStyle.text_12_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return hBox(15.h);
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
            borderPadding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              height: Get.height * 0.065,
              width: Get.width,
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
                        hintStyle:AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
                        textStyle:AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
                                    .toString(),
                                grandTotal: controller
                                    .cartData.value.cart!.grandTotalPrice
                                    .toString(),
                              );
                            } else {
                              Utils.showToast("Please Enter Coupon Code");
                            }
                          },
                          child: Text(
                            "Apply",
                            style: AppFontStyle.text_16_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
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
                                  grandTotal: controller
                                      .cartData.value.cart!.grandTotalPrice
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
                        hBox(2.h),
                        Text(
                          "-\$${controller.cartData.value.cart!.couponDiscount}",
                          style: AppFontStyle.text_15_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
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
          style: AppFontStyle.text_18_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(10.h),
        if (isLoading) ...[
          shimmerItem("Regular Price"),
          shimmerItem("Save Amount"),
          if (controller.cartData.value.cart!.couponApplied != null)
            shimmerItem("Coupon Discount"),
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
          if (controller.cartData.value.cart!.couponApplied != null)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coupon Discount",
                    style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                  ),
                  Text(
                    "- \$${controller.cartData.value.cart!.couponDiscount.toString()}",
                    style: AppFontStyle.text_14_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
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
              style: AppFontStyle.text_14_500(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
            ),
            isLoading
                ? shimmerItem('\$0.00',
                    width: 70, height: 40, secondShimmer: false)
                : Text(
                    "\$${controller.cartData.value.cart!.totalPrice.toString()}",
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

                            Get.toNamed(
                              AppRoutes.checkoutScreen,
                              arguments: {
                                'address_id': controller
                                    .cartData.value.address!.id
                                    .toString(),
                                'coupon_id': controller
                                    .cartData.value.cart!.couponApplied?.id
                                    .toString(),
                                'vendor_id': controller
                                    .cartData.value.cart!.restoId
                                    .toString(),
                                'total': controller
                                    .cartData.value.cart!.totalPrice
                                    .toString(),
                                'regular_price': controller
                                    .cartData.value.cart!.regularPrice
                                    .toString(),
                                'coupon_discount': controller
                                    .cartData.value.cart!.couponDiscount
                                    .toString(),
                                'save_amount': controller
                                    .cartData.value.cart!.saveAmount
                                    .toString(),
                                'delivery_charge': controller
                                    .cartData.value.cart!.deliveryCharge
                                    .toString(),
                                'cart_id': controller.cartData.value.cart!.id
                                    .toString(),
                                'wallet':
                                    controller.cartData.value.wallet.toString(),
                                'cartType': "restaurant",
                                'imagePath': [],
                              },
                            );
                          });
                        } else {
                          Utils.showToast(
                              "Please select product to proceed to checkout");
                        }
                      },
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
                          'type': "RestaurantCart",
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
                            style: AppFontStyle.text_28_600(Colors.white,
                                height: 1.h,family: AppFontFamily.gilroyMedium),
                          ),
                          Text(
                            controller.cartData.value.coupons![index]
                                        .discountType
                                        .toString() ==
                                    "percent"
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
                      controller.cartData.value.coupons![index].couponType
                          .toString().capitalize.toString(),
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
                    FittedBox(
                      child: Text(
                        daysRemaining,
                        // overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppFontStyle.text_12_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
                      ),
                    ),
                    hBox(8),
                    if (controller.cartData.value.coupons![index].expiryStatus
                            .toString() !=
                        "Expired")
                      CustomElevatedButton(
                        textStyle:
                            AppFontStyle.text_14_400(Colors.white, height: 1.0,family: AppFontFamily.gilroyMedium),
                        width: 85.w,
                        height: 36.h,
                        text: "Select",
                        onPressed: () {
                          controller.couponCodeController.value.text = controller.cartData.value.coupons![index].code.toString();
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

  //---------------------------------------------------------
  Future showDeleteProductDialog({
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
                  fontFamily: AppFontFamily.gilroyMedium,
                  fontWeight: FontWeight.w400,
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
                      textStyle: AppFontStyle.text_16_400(AppColors.darkText ,family: AppFontFamily.gilroyMedium,),
                    ),
                  ),
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
                              productId: productId, countId: countId);
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
