import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Core/Utils/login_required_pop_up.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Add_to_Cart/addtocartcontroller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/controller/CategoriesFilter_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/custom_no_data_found.dart';

import '../../../../../../Data/components/GeneralException.dart';
import '../../../../../../Data/components/InternetException.dart';
import '../../../../../../shared/widgets/CircularProgressIndicator.dart';
import '../../../../Restaurants_navbar/Controller/restaurant_navbar_controller.dart';
import 'controller/RestaurantCategoriesDetailsController.dart';

class RestaurantCategoryDetails extends StatelessWidget {
  RestaurantCategoryDetails({super.key});

  final RestaurantCategoriesDetailsController controller = Get.put(RestaurantCategoriesDetailsController());
  final AddToCartController addToCartController = Get.put(AddToCartController());

  final AddProductWishlistController add_Wishlist_Controller = Get.put(AddProductWishlistController());

  final specific_Product_Controller specific_product_controllerontroller = Get.put(specific_Product_Controller());
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());

  final Categories_FilterController categoriesFilterController = Get.put(Categories_FilterController());
  // RestaurantNavbarController navbarController = Get.put(RestaurantNavbarController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String categoryTitle = args['name'] ?? "";
    final int categoryId = args['id'] ?? 0;

    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          // bottomNavigationBar: navBarStatic(navbarItems),
          appBar: CustomAppBar(
            title: Text(
              categoryTitle,
              style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
            ),
          ),
          body: Obx(() {
            switch (controller.rxRequestStatus.value) {
              case Status.LOADING:
                return Center(child: circularProgressIndicator());
              case Status.ERROR:
                if (controller.error.value == 'No internet'  || controller.error.value == 'InternetExceptionWidget') {
                  return InternetExceptionWidget(
                    onPress: () {
                      controller.restaurant_Categories_Details_Api(
                          id: categoryId.toString());
                    },
                  );
                } else {
                  return GeneralExceptionWidget(
                    onPress: () {
                      controller.restaurant_Categories_Details_Api(
                          id: categoryId.toString());
                    },
                  );
                }
              case Status.COMPLETED:
                return RefreshIndicator(
                    onRefresh: () async {
                      categoriesFilterController.resetFilters();
                      controller.restaurant_Categories_Details_Api(id: categoryId.toString());
                    },
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 24),
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            // pinned: false,
                            // snap: true,
                            // floating: true,
                            expandedHeight: 70.h,
                            surfaceTintColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            flexibleSpace: FlexibleSpaceBar(
                              titlePadding: REdgeInsets.only(bottom: 15),
                              title: SizedBox(
                                height: 35.h,
                                child: (CustomSearchFilter(
                                  controller: controller.searchController,
                                  onChanged: (value) {
                                    if (controller.categoriesDetailsData.value
                                        .filterProduct!.isEmpty) {
                                      controller.searchDataFun(value);
                                    } else {
                                      controller.filterSearchDataFun(value);
                                    }
                                  },
                                  onFilterTap: () {
                                    Get.toNamed(
                                      AppRoutes.restaurantCategoriesFilter,
                                      arguments: {
                                        'categoryId': categoryId.toString()
                                      },
                                    );
                                    // Get.toNamed(AppRoutes.restaurantCategoriesNewFilter);
                                    categoriesFilterController.restaurant_get_CategoriesFilter_Api(categoryId.toString());
                                  },
                                )),
                              ),
                              centerTitle: true,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: hBox(10.h),
                          ),
                          if (controller.categoriesDetailsData.value.filterProduct!.isEmpty &&controller.categoriesDetailsData.value.categoryProduct!.isEmpty
                              // ||(controller.categoriesDetailsData.value.filterProduct!.isEmpty  && controller.searchController.text.isNotEmpty)
                              // ||(controller.categoriesDetailsData.value.categoryProduct!.isEmpty && controller.searchController.text.isNotEmpty)
                          )...[
                            SliverToBoxAdapter(
                              child:CustomNoDataFound(heightBox: hBox(50.h))
                            ),
                          ],
                          //------------------------------------------------------------------
                          if (controller.categoriesDetailsData.value.filterProduct!.isEmpty)...[
                            if (controller.searchController.text.isNotEmpty && controller.searchData.isEmpty)...[
                            const SliverToBoxAdapter(
                            child: CustomNoDataFound(),
                            ),
                            ]
                            else...[
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: controller.searchData.length,
                                    (context, index) {
                                  var product = controller.searchData[index];
                                  return GestureDetector(
                                      onTap: () {
                                        specific_product_controllerontroller
                                            .specific_Product_Api(
                                                productId:
                                                    product.id.toString(),
                                                categoryId:
                                                    categoryId.toString());
                                        Get.to(()=>ProductDetailsScreen(
                                          productId: product.id.toString(),
                                          categoryId: categoryId.toString(),
                                          categoryName: categoryTitle,
                                          restaurantId: product.vendorId.toString(),
                                        ));
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:BorderRadius.circular(20.r),
                                                ),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: "${product.image}"
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    height: 160.h,
                                                    width: double.maxFinite,
                                                    errorWidget: (context, url,
                                                            error) => Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(color: AppColors.greyBackground),
                                                        color: AppColors.transparent,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20.r),
                                                      ),
                                                      child: Icon(Icons.broken_image_rounded,color: AppColors.greyImageColor,),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                              baseColor: AppColors.greyBackground,
                                                        highlightColor:
                                                          AppColors.lightText,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors.gray,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Obx(
                                                () => Container(
                                                  margin: REdgeInsets.only(
                                                      top: 10, right: 10),
                                                  padding: REdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: AppColors
                                                        .greyBackground,
                                                  ),
                                                  child: InkWell(
                                                    highlightColor:Colors.transparent,
                                                    splashColor: Colors.transparent,
                                                    onTap: () async {
                                                      if (getUserDataController.userData.value.user?.userType =="guestUser") {
                                                        showLoginRequired(context);
                                                      }else{
                                                      product.isInWishlist = !product.isInWishlist!;
                                                      product.isLoading.value = true;
                                                      await add_Wishlist_Controller.restaurant_add_product_wishlist(categoryId: categoryId.toString(), product_id: product.id.toString(),);
                                                      product.isLoading.value =
                                                          false;
                                                      }
                                                    },
                                                    child: product.isLoading.value
                                                        ? circularProgressIndicator(size: 18)
                                                        : Icon(product.isInWishlist == true
                                                                ? Icons.favorite
                                                                : Icons.favorite_border_outlined,
                                                            size: 22,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              // Positioned(
                                              //   bottom: 10,right: 10,
                                              //   child: Obx(
                                              //     ()=> InkWell(
                                              //       onTap: () {
                                              //         controller.searchData[index].isAddToCart.value = true;
                                              //       },
                                              //       child: Container(
                                              //         height: 30.h,width: 30.w,
                                              //       decoration: BoxDecoration(color: AppColors.primary,
                                              //       // shape: BoxShape.circle,
                                              //       borderRadius: BorderRadius.circular(10.r)
                                              //       ),
                                              //       child: Icon( controller.searchData[index].isAddToCart.value ? Icons.done :Icons.add,
                                              //         color: AppColors.white,size: 20,),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                          hBox(10.h),
                                          Row(
                                            children: [
                                              Text(
                                                product.title.toString(),
                                                textAlign: TextAlign.left,
                                                style: AppFontStyle.text_16_400(
                                                    AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                              ),
                                              const Spacer(),
                                              SvgPicture.asset(
                                                "assets/svg/star-yellow.svg",
                                                height: 15,
                                              ),
                                              wBox(4),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 3.0),
                                                child: Text(
                                                  "${product.rating}",
                                                  style: AppFontStyle.text_14_400(AppColors.darkText,
                                                      family: AppFontFamily.gilroyRegular),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Text(
                                              product.restoName.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppFontStyle.text_14_300(
                                                  AppColors.lightText,family: AppFontFamily.gilroyRegular),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(15.r),
                                                    border: Border.all(
                                                      color: AppColors.primary,
                                                    )
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "\$${product.regularPrice ?? '0'}",
                                                    style: AppFontStyle.text_10_400(AppColors.black,
                                                        family: AppFontFamily.gilroyRegular
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              SvgPicture.asset(
                                                ImageConstants.clockIcon,
                                                height: 10,
                                                colorFilter:
                                                ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
                                              ),
                                              wBox(3.w),
                                              Text(
                                                product.preparationTime.toString(),
                                                style: AppFontStyle.text_10_400(AppColors.darkText,
                                                    family: AppFontFamily.gilroyRegular),
                                              ),
                                              const Spacer(),
                                              /*Obx((){
                                                return GestureDetector(
                                                  onTap: () {
                                                    if (getUserDataController.userData.value.user?.userType =="guestUser") {
                                                      showLoginRequired(context);
                                                    }else{
                                                      addToCartController.addToCartApi(
                                                          productId: product.id.toString(),
                                                          productQuantity: '1',
                                                          productPrice: product.regularPrice,
                                                          restaurantId: product.vendorId.toString(),
                                                          addons: [],
                                                          extrasIds: [],
                                                          extrasItemIds: [],
                                                          extrasItemNames: [],
                                                          extrasItemPrices: [],
                                                          isPopUp: false
                                                      );
                                                    }
                                                  }, child: addToCartController.isCartLoading(product.id.toString())
                                                    ? circularProgressIndicator(size: 30)
                                                    : Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration:  BoxDecoration(
                                                      color: AppColors.black,
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 20,
                                                    color: AppColors.white,
                                                  ),
                                                ),);
                                              })*/
                                              GetBuilder<AddToCartController>(
                                                builder: (cartController) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (getUserDataController.userData.value.user?.userType == "guestUser") {
                                                        showLoginRequired(context);
                                                      } else {
                                                        cartController.addToCartApi(
                                                            productId: product.id.toString(),
                                                            productQuantity: '1',
                                                            productPrice: product.regularPrice,
                                                            restaurantId: product.vendorId.toString(),
                                                            addons: [],
                                                            extrasIds: [],
                                                            extrasItemIds: [],
                                                            extrasItemNames: [],
                                                            extrasItemPrices: [],
                                                            isPopUp: false
                                                        );
                                                      }
                                                    },
                                                    child: cartController.isCartLoading(product.id.toString())
                                                        ? circularProgressIndicator(size: 30)
                                                        : Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.black,
                                                          borderRadius: BorderRadius.circular(20)
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 20,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                         /* Row(
                                            children: [
                                              product.salePrice != null
                                                  ? Text(
                                                      "\$${product.salePrice}",
                                                      textAlign: TextAlign.left,
                                                      style: AppFontStyle
                                                          .text_16_600(AppColors
                                                              .primary,family: AppFontFamily.gilroyRegular),
                                                    )
                                                  : Text(
                                                      "\$${product.regularPrice}",
                                                      textAlign: TextAlign.left,
                                                      style: AppFontStyle
                                                          .text_16_600(AppColors
                                                              .primary,family: AppFontFamily.gilroyRegular),
                                                    ),
                                              wBox(5.h),
                                              if (product.salePrice != null)
                                                Text(
                                                  "\$${product.regularPrice}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.left,

                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color:
                                                          AppColors.lightText,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      decorationColor:
                                                          AppColors.lightText,fontFamily: AppFontFamily.gilroyRegular),

                                                  //  AppFontStyle.text_14_300(AppColors.lightText),
                                                ),
                                            ],
                                          ),*/
                                        ],
                                      ));
                                  //  categoryItem(index);
                                }),
                                gridDelegate:
                                    (SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6.w,
                                  crossAxisSpacing: 14.w,
                                  mainAxisSpacing: 5.h,
                                  // crossAxisCount: 2,
                                  // childAspectRatio: 0.7.w,
                                  // crossAxisSpacing: 16.w,
                                  // mainAxisSpacing: 5.h,
                                ))),
                            ],
                          ],
                          //------------------------------------------------------------------

                          if (controller.categoriesDetailsData.value.filterProduct!.isNotEmpty)...[
                          if (controller.searchController.text.isNotEmpty && controller.filterProductSearchData.isEmpty)...[
                            const SliverToBoxAdapter(
                              child: CustomNoDataFound(),
                            ),
                          ] else...[
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                 childCount: controller.filterProductSearchData.length, (context, index) {
                                  var product =controller.filterProductSearchData[index];
                                  return GestureDetector(
                                      onTap: () {
                                        specific_product_controllerontroller.specific_Product_Api(
                                                productId:product.id.toString(),
                                                categoryId:categoryId.toString());
                                        Get.to(ProductDetailsScreen(
                                          cuisineType: categoriesFilterController.selectedCuisines.join(', '),
                                          priceRange: "${categoriesFilterController.lowerValue.value},${categoriesFilterController.upperValue.value}",
                                          priceSort: categoriesFilterController.priceRadioValue.value == 0 ? ""
                                          : categoriesFilterController.priceRadioValue.value == 1 ? "low to high" : "high to low",
                                          quickFilter: categoriesFilterController.selectedQuickFilters.toString(),
                                          productId: product.id.toString(),
                                          categoryId: categoryId.toString(),
                                          categoryName: categoryTitle,
                                        ));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: product.urlImage.toString(),
                                                    fit: BoxFit.cover,
                                                    height: 160.h,
                                                    errorWidget: (context, url,
                                                        error) => Container(
                                                      width: Get.width,
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(color: AppColors.greyBackground),
                                                        color: AppColors.transparent,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20.r),
                                                      ),
                                                      child: Icon(Icons.broken_image_rounded,color: AppColors.greyImageColor,),
                                                    ),
                                                    placeholder:(context, url) =>Shimmer.fromColors(
                                                      baseColor: AppColors.greyBackground,
                                                      highlightColor:AppColors.lightText,
                                                      child: Container(
                                                        decoration:BoxDecoration(
                                                          color: AppColors.gray,
                                                          borderRadius:BorderRadius.circular(20.r),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Obx(
                                                () => Container(
                                                  margin: REdgeInsets.only(top: 10, right: 10),
                                                  padding: REdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:BorderRadius.circular(10.r),
                                                    color: AppColors.greyBackground,
                                                  ),
                                                  child: InkWell(
                                                    highlightColor:Colors.transparent,
                                                    splashColor:Colors.transparent,
                                                    onTap: () async {
                                                      if (getUserDataController.userData.value.user?.userType =="guestUser") {
                                                        showLoginRequired(context);
                                                      }else{
                                                      product.isInWishlist =!product.isInWishlist!;
                                                      product.isLoading.value =true;
                                                      await add_Wishlist_Controller.restaurant_add_product_wishlist(
                                                        cuisineType: categoriesFilterController.selectedCuisines.join(', '),
                                                        priceRange:categoriesFilterController.priceRadioValue.value == 1 ? ""
                                                            : "${categoriesFilterController.lowerValue.value},${categoriesFilterController.upperValue.value}",
                                                        priceSort: categoriesFilterController.priceRadioValue.value == 0 ? ""
                                                            : categoriesFilterController.priceRadioValue.value == 1 ? "low to high" : "high to low",
                                                        quickFilter:categoriesFilterController.priceRadioValue.value == 1 ? ""
                                                                   : categoriesFilterController.selectedQuickFilters.toString(),
                                                        categoryId: categoryId.toString(),
                                                        product_id: product.id.toString(),
                                                      );
                                                      product.isLoading.value =false;
                                                      }
                                                    },
                                                    child: product.isLoading.value
                                                        ? circularProgressIndicator(size: 18)
                                                        : Icon(
                                                            product.isInWishlist == true
                                                                ? Icons.favorite
                                                                : Icons.favorite_border_outlined,
                                                            size: 22,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              // Positioned(
                                              //   bottom: 10,right: 10,
                                              //   child: Obx(
                                              //         ()=> InkWell(
                                              //       onTap: () {
                                              //         controller.filterProductSearchData[index].isAddToCart.value = true;
                                              //       },
                                              //       child: Container(
                                              //         height: 30.h,width: 30.w,
                                              //         decoration: BoxDecoration(color: AppColors.primary,
                                              //             // shape: BoxShape.circle,
                                              //             borderRadius: BorderRadius.circular(10.r)
                                              //         ),
                                              //         child: Icon( controller.filterProductSearchData[index].isAddToCart.value ? Icons.done :Icons.add,
                                              //           color: AppColors.white,size: 20,),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          hBox(10),
                                          Row(
                                            children: [
                                              Text(
                                                "\$${product.salePrice ?? product.regularPrice}",
                                                textAlign: TextAlign.left,
                                                style: AppFontStyle.text_16_600(
                                                    AppColors.primary,family: AppFontFamily.gilroyRegular),
                                              ),
                                              wBox(5),
                                              Text(
                                                "\$${product.regularPrice}",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: AppColors.lightText,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        AppColors.lightText,
                                                    fontFamily: AppFontFamily.gilroyRegular,
                                                ),

                                                //  AppFontStyle.text_14_300(AppColors.lightText),
                                              ),
                                            ],
                                          ),
                                          // hBox(10),
                                          Text(
                                            product.title.toString(),
                                            textAlign: TextAlign.left,
                                            style: AppFontStyle.text_16_400(
                                                AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                          ),
                                          // hBox(10),

                                          // hBox(10),
                                          // Row(
                                          //   children: [
                                          //     SvgPicture.asset(
                                          //         "assets/svg/star-yellow.svg"),
                                          //     wBox(4),
                                          //     Text(
                                          //       "${product.rating.toString()}/5",
                                          //       style: AppFontStyle.text_14_300(
                                          //           AppColors.lightText),
                                          //     ),
                                          //     wBox(4),
                                          Flexible(
                                            child: Text(
                                              product.restoName.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppFontStyle.text_14_300(
                                                  AppColors.lightText,family: AppFontFamily.gilroyRegular),
                                            ),
                                          ),
                                          //   ],
                                          // )
                                        ],
                                      ));
                                  //  categoryItem(index);
                                }),
                                gridDelegate:(SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6.w,
                                  crossAxisSpacing: 14.w,
                                  mainAxisSpacing: 5.h,
                                  // crossAxisCount: 2,
                                  // childAspectRatio: 0.6.w,
                                  // crossAxisSpacing: 16.w,
                                  // mainAxisSpacing: 5.h,
                                ))),
                            ],
                          ],
                          //------------------------------------------------------------------

                          SliverToBoxAdapter(
                            child: hBox(70.h),
                          ),
                        ],
                      ),
                    ),
                );
            }
          },
         ),
        ),
      ),
    );
  }
  // Container navBarStatic() {
  //   List<String> navbarItems = [
  //     ImageConstants.home,
  //     ImageConstants.categories,
  //     ImageConstants.wishlist,
  //     ImageConstants.cart,
  //     ImageConstants.profileOutlined,
  //   ];
  //   return Container( height: 70.h,
  //         width: Get.width,
  //         decoration: BoxDecoration(
  //           color: AppColors.navbar,
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)
  //           ),
  //         ),
  //         child:  Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: List.generate(navbarItems.length, (index) {
  //               bool isSelected = navbarController.navbarCurrentIndex == index;
  //               // String icon = isSelected ? navbarItemsFilled[index] : navbarItems[index];
  //               return InkWell(
  //                 highlightColor: Colors.transparent,
  //                 splashColor: Colors.transparent,
  //                 onTap: () {
  //                   // Get.to(RestaurantNavbar(navbarInitialIndex: index));
  //                   navbarController.getIndex(index);
  //                   Get.to(RestaurantNavbar(navbarInitialIndex: index));
  //                 },
  //                 child: Padding(
  //                   padding: REdgeInsets.symmetric(horizontal: 12),
  //                   child: AnimatedContainer(
  //                     duration: const Duration(milliseconds: 300),
  //                     curve: Curves.easeInOut,
  //                     width: 44.w,
  //                     child: Stack(
  //                       children: [
  //                         Column(
  //                           children: [
  //                             AnimatedContainer(
  //                               duration: const Duration(milliseconds: 300),
  //                               curve: Curves.linear,
  //                               height: 4.h,
  //                               width: 44.w,
  //                               decoration: BoxDecoration(
  //                                   color:
  //                                   // isSelected
  //                                   //     ? AppColors.primary
  //                                   //     :
  //                                   Colors.transparent,
  //                                   borderRadius: BorderRadius.only(
  //                                       bottomLeft: Radius.circular(10.r),
  //                                       bottomRight: Radius.circular(10.r))),
  //                             ),
  //                             Padding(
  //                               padding:
  //                               REdgeInsets.only(top: 19, bottom: 23),
  //                               child: SvgPicture.asset(
  //                                 navbarItems[index],
  //                                 height: 24.h,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             })
  //           // navbarItems.map((icon) {
  //           //   int index = navbarItems.indexOf(icon);
  //           //   bool isSelected = navbarController.navbarCurrentIndex == index;
  //           //   return GestureDetector(
  //           //     onTap: () {
  //           //       navbarController.getIndex(index);
  //           //     },
  //           //     child: Padding(
  //           //       padding: REdgeInsets.symmetric(horizontal: 12),
  //           //       child: AnimatedContainer(
  //           //         duration: const Duration(milliseconds: 300),
  //           //         curve: Curves.easeInOut,
  //           //         height: 48.h,
  //           //         width: 48.h,
  //           //         child: Column(
  //           //           children: [
  //           //             SvgPicture.asset(
  //           //               icon,
  //           //             ),
  //           //           ],
  //           //         ),
  //           //       ),
  //           //     ),
  //           //   );
  //           // }).toList(),
  //         ),
  //       );
  // }
}


