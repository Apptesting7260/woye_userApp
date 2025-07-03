import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Grocery/Grocery_navbar/controller/grocery_navbar_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Controller/grocery_cart_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/Single_Grocery_Vendor_cart/singal_vendor_grocery_cart.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/show_all_grocery_carts/grocery_allCart_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/Sub_screens/Categories_details/controller/GroceryCategoriesDetailsController.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/GroceryDetailsController.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/grocery_vendor_details_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/all_grocery_shops/all_grocery_shops.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/banners/grocery_banner_details_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/banners/grocery_home_banner_data.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/controller/grocery_home_controller.dart';
import 'package:woye_user/shared/widgets/custom_dropdown.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';

import '../../../../../Shared/theme/font_family.dart';
import '../../../../../shared/widgets/shimmer.dart';
import '../../Grocery_categories/Sub_screens/Filter/Grocery_Categories_Filter_controller.dart';

class GroceryHomeScreen extends StatefulWidget {
  const GroceryHomeScreen({super.key});

  @override
  State<GroceryHomeScreen> createState() => _GroceryHomeScreenState();
}

class _GroceryHomeScreenState extends State<GroceryHomeScreen> {
  final GroceryHomeController groceryHomeController = Get.put(GroceryHomeController());
  final GroceryCategoriesFilterController groceryCategoriesFilterController = Get.put(GroceryCategoriesFilterController());

  final GroceryDetailsController groceryDetailsController = Get.put(GroceryDetailsController());
  final GroceryNavbarController navbarController = Get.put(GroceryNavbarController());

  final Grocerycategoriesdetailscontroller grocerycategoriesdetailscontroller = Get.put(Grocerycategoriesdetailscontroller());
  final GroceryCartController groceryCartController = Get.put(GroceryCartController());

  final GroceryShowAllCartController groceryShowAllCartController = Get.put(GroceryShowAllCartController());

  final GroceryBannerDetailsController bannerDetailsController = Get.put(GroceryBannerDetailsController());
  //
  // final ScrollController _scrollControllerAllShops = ScrollController();
  // final ScrollController _horScrollControllerPopularShop = ScrollController();
  // final ScrollController _scrollControllerFreeDeliveryShop = ScrollController();
  // final ScrollController _scrollControllerNearByShop = ScrollController();

  @override
  void initState() {
    super.initState();
    groceryCartController.getGroceryAllCartApi();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     if (groceryHomeController.noLoading.value != true) {
    //       if (!groceryHomeController.isLoading.value) {
    //         groceryHomeController.isLoading.value = true;
    //         groceryHomeController.currentPage++;
    //         print(
    //             "currentPage value ${groceryHomeController.currentPage.value}");
    //         groceryHomeController
    //             .homeApi(groceryHomeController.currentPage.value);
    //       }
    //     }
    //   }
    // });

    // _horScrollControllerPopularShop.addListener(() {
    //   if (_horScrollControllerPopularShop.position.pixels >= _horScrollControllerPopularShop.position.maxScrollExtent - 100) {
    //     if (!groceryHomeController.isLoadingPopular.value && !groceryHomeController.noMoreDataPopularLoading.value) {
    //       groceryHomeController.isLoadingPopular.value = true;
    //       groceryHomeController.currentPage.value++;
    //       groceryHomeController.homeApi(groceryHomeController.currentPage.value);
    //     }
    //   }
    // });
    //
    // _scrollControllerFreeDeliveryShop.addListener(() {
    //   if (_scrollControllerFreeDeliveryShop.position.pixels >= _scrollControllerFreeDeliveryShop.position.maxScrollExtent - 100) {
    //     if (!groceryHomeController.isLoadingFree.value && !groceryHomeController.noMoreDataFreeLoading.value) {
    //       groceryHomeController.isLoadingFree.value = true;
    //       groceryHomeController.currentPage.value++;
    //       groceryHomeController.homeApi(groceryHomeController.currentPage.value);
    //     }
    //   }
    // });
    //
    // _scrollControllerNearByShop.addListener(() {
    //   if (_scrollControllerNearByShop.position.pixels >= _scrollControllerNearByShop.position.maxScrollExtent - 100) {
    //     if (!groceryHomeController.isLoadingNearby.value && !groceryHomeController.noMoreDataNearbyLoading.value) {
    //       groceryHomeController.isLoadingNearby.value = true;
    //       groceryHomeController.currentPage.value++;
    //       groceryHomeController.homeApi(groceryHomeController.currentPage.value);
    //     }
    //   }
    // });
    //
    // _scrollControllerAllShops.addListener(() {
    //   if (_scrollControllerAllShops.position.pixels >= _scrollControllerAllShops.position.maxScrollExtent - 100) {
    //     if (!groceryHomeController.isLoadingGrocery.value && !groceryHomeController.noMoreDataGroceryLoading.value) {
    //       groceryHomeController.isLoadingGrocery.value = true;
    //       groceryHomeController.currentPage.value++;
    //       groceryHomeController.homeApi(groceryHomeController.currentPage.value);
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (groceryHomeController.rxRequestStatus.value) {
        case Status.LOADING:
          return Center(child: circularProgressIndicator());
        case Status.ERROR:
          if (groceryHomeController.error.value == 'No internet' || groceryHomeController.error.value == "InternetExceptionWidget")  {
            return InternetExceptionWidget(
              onPress: () {
                groceryHomeController.homeApiRefresh();
              },
            );
          } else {
            return GeneralExceptionWidget(
              onPress: () {
                groceryHomeController.homeApiRefresh();
              },
            );
          }
        case Status.COMPLETED:
          return RefreshIndicator(
            onRefresh: () async {
              groceryCartController.getGroceryAllCartApi();
              groceryHomeController.homeApiRefresh();
            },
            child: SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    HomeScreen(),
                    Expanded(
                      child: CustomScrollView(
                        // controller: _scrollController,
                        slivers: [
                          SliverPadding(
                            padding: REdgeInsets.symmetric(
                              horizontal: 24.h,
                            ),
                            sliver: serchAndFilter(),
                          ),
                          if (groceryHomeController.homeData.value.category!.isNotEmpty)
                            SliverToBoxAdapter(
                            child: catergories(),
                          ),
                          SliverPadding(
                              padding: REdgeInsets.symmetric(horizontal: 0),
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    if (groceryHomeController.homeData.value.banners!.isNotEmpty)
                                      mainBanner(),

                                    ratingDeliveryFilterBtn(),

                                    if (groceryHomeController.homeData.value.popularGrocery?.isNotEmpty ?? false)
                                      popularShop(),

                                    if (groceryHomeController.homeData.value.freedelGrocery?.isNotEmpty ?? false)
                                      freeDeliveryShop(),

                                    if (groceryHomeController.homeData.value.nearbyGrocery?.isNotEmpty ?? false)
                                      nearbyShop(),

                                    if (groceryHomeController.homeData.value.groceryShops?.isNotEmpty ?? false)
                                      allShop(),

                                    hBox(100.h)
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    if(groceryShowAllCartController.cartData.value.buttonCheck == true)
                    hBox(75.h),
                  ],
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Padding(
                  padding: EdgeInsets.only(bottom:Platform.isIOS ? 28.h : 60.h),
                  child: groceryShowAllCartController.cartData.value.buttonCheck == false
                  /*(groceryShowAllCartController.cartData.value.carts?.isEmpty ?? true)*/ ?
                  const SizedBox()
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: AlignmentDirectional.topCenter,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10.r,
                                      bottom: 10.r,
                                      left: 20.r,
                                      right: 20.r),
                                  width: Get.width,
                                  padding: EdgeInsets.only(
                                      top: 10.r,
                                      bottom: 10.r,
                                      left: 10.r,
                                      right: 10.r),
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(20.r),
                                      border: Border.all(
                                          color: AppColors.hintText)),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 50.h,
                                          height: 50.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100.r),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.r),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    groceryShowAllCartController
                                                        .cartData
                                                        .value
                                                        .carts![0]
                                                        .grocery!
                                                        .shopimage
                                                        .toString(),
                                                placeholder: (context, url) =>
                                                    circularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons.person,
                                                  size: 40.h,
                                                  color: AppColors.lightText
                                                      .withOpacity(0.5),
                                                ),
                                                fit: BoxFit.cover,
                                              ))),
                                      wBox(10.h),
                                      Container(
                                        width: Get.width / 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                          /*  groceryShowAllCartController.cartData.value.carts?.length == 1 ?*/ Text(
                                              groceryShowAllCartController.cartData.value.carts![0].grocery!.shopName.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: AppFontStyle.text_15_500(
                                                  AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                            )/*: Text(
                                              "Your Carts",
                                              overflow: TextOverflow.ellipsis,
                                              style: AppFontStyle.text_16_500(
                                                  AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                            ),*/
                                            // Text(
                                            //   carts.vendorAddress.toString(),
                                            //   style: AppFontStyle.text_12_400(AppColors.lightText),
                                            //   overflow: TextOverflow.ellipsis,
                                            //   maxLines: 1,
                                            // ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            // Get.back();
                                            // navbarController.getIndex(3);
                                            Get.to(()=>SingleVendorGroceryCart(
                                              cartId:groceryShowAllCartController.cartData.value.carts![0].id.toString(),
                                              isBack: true,
                                            ));
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                               /* groceryShowAllCartController.cartData.value.carts?.length == 1 ?  "View Cart" : */"View Cart",
                                                style: AppFontStyle.text_14_400(AppColors.white,family: AppFontFamily.gilroyMedium),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              // Text(
                                              //   "items",
                                              //   style: AppFontStyle.text_10_400(
                                              //     family: AppFontFamily.gilroyMedium,
                                              //       AppColors.white
                                              //           .withOpacity(.5)),
                                              //   overflow: TextOverflow.ellipsis,
                                              //   maxLines: 1,
                                              // ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: -15.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showAllCart();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.all(8.r),
                                      backgroundColor: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                      ),
                                      elevation: 5,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        wBox(2.w),
                                        Text(
                                          "Carts",
                                          style: AppFontStyle.text_12_600(
                                              AppColors.primary,family:AppFontFamily.gilroyRegular),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_up,
                                          color: AppColors.primary,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                ),
              ),
            ),
          );
      }
    });
  }

  showAllCart() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      "Your Carts(${groceryShowAllCartController.cartData.value.carts!.length})",
                      style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                    ),
                    const Spacer(),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.back();
                        navbarController.getIndex(3);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Checkout all",
                            style: AppFontStyle.text_14_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
                          ),
                          wBox(4),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: AppColors.primary,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                hBox(20.h),
                ListView.separated(
                  itemCount:
                      groceryShowAllCartController.cartData.value.carts!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var carts = groceryShowAllCartController.cartData.value.carts![index];
                    return Container(
                      width: Get.width,
                      padding: EdgeInsets.only(
                          top: 10.r, bottom: 10.r, left: 10.r, right: 10.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.hintText)),
                      child: Row(
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
                                    imageUrl:
                                        carts.grocery!.shopimage.toString(),
                                    placeholder: (context, url) =>
                                        circularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.person,
                                      size: 40.h,
                                      color:
                                          AppColors.lightText.withOpacity(0.5),
                                    ),
                                    fit: BoxFit.cover,
                                  ))),
                          wBox(10.h),
                          Container(
                            width: Get.width / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  carts.grocery!.shopName.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: AppFontStyle.text_14_500(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                ),
                                // Text(
                                //   carts.vendorAddress.toString(),
                                //   style: AppFontStyle.text_12_400(AppColors.lightText),
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 1,
                                // ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                                Get.to(()=>SingleVendorGroceryCart(
                                  cartId: carts.id.toString(),
                                  isBack: true,
                                ));
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "View Cart",
                                    style: AppFontStyle.text_14_400(AppColors.white,family: AppFontFamily.gilroyMedium),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "items",
                                    style: AppFontStyle.text_10_400(AppColors.white.withOpacity(.5),family: AppFontFamily.gilroyMedium),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return hBox(20.h);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget serchAndFilter() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      // snap: true,
      // floating: true,
      expandedHeight: 80.h,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: SizedBox(
          height: 34.h,
          child: (CustomSearchFilter(
            // enabled: false,
            readOnly: true,
            onTap: () {
              Get.toNamed(AppRoutes.groceryHomeFilter);
            },
            showfilterIcon: false,
            searchIocnPadding: REdgeInsets.all(8),
            searchIconHeight: 16.h,
            hintStyle: AppFontStyle.text_10_400(AppColors.hintText),
            textStyle: AppFontStyle.text_10_400(AppColors.darkText),
            prefixConstraints: BoxConstraints(
              maxHeight: 18.h,
            ),
            prefix: Padding(
              padding: REdgeInsets.only(left: 15.h, right: 5.h, bottom: 1.h),
              child: SvgPicture.asset(
                "assets/svg/search.svg",
                height: 12.h,
              ),
            ),
            padding: REdgeInsets.only(top: 10, bottom: 10),
            onFilterTap: () {
              // Get.toNamed(AppRoutes.restaurantHomeFilter);
            },
          )),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget mainBanner() {
    return Column(
      children: [
        Obx(() {
          final banners = groceryHomeController.homeData.value.banners;
          return CarouselSlider.builder(
            itemCount: banners!.length,
            options: CarouselOptions(
              height: 150.h,
              autoPlay: groceryHomeController.homeData.value.banners!.length > 1
                  ? true
                  : false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.easeInOut,
              enlargeCenterPage: false,
              viewportFraction: 1.0,
            ),
            itemBuilder: (context, index, realIndex) {
              final banner = banners[index];
              return GestureDetector(
                onTap: () {
                  bannerDetailsController.bannerDataApi(
                      bannerId: banners[index].id.toString());
                  Get.to(()=>GroceryHomeBanner(
                    bannerID: banners[index].id.toString(),
                  ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: CachedNetworkImage(
                    imageUrl: banner.imageUrl.toString(),
                    height: 150.h,
                    width: Get.width * 0.9,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: AppColors.gray,
                      highlightColor: AppColors.lightText,
                      child: Container(
                        color: AppColors.gray,
                        height: 160.h,
                        width: Get.width * 0.9,
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40.w,
                    ),
                  ),
                ),
              );
            },
          );
        }),
        hBox(20.h),
      ],
    );
  }

  Widget catergories() {
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: Row(
                children: [
                  Text(
                    "Categories" ,
                    style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      navbarController.getIndex(1);
                    },
                    child: Row(
                      children: [
                        Text(
                          "See All",
                          style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                        ),
                        wBox(4),
                        Icon(
                          Icons.arrow_forward_sharp,
                          color: AppColors.primary,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            hBox(15.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate( groceryHomeController.homeData.value.category?.length ?? 0, (index) {
                  return Padding(
                    padding: REdgeInsets.only(left: index == 0 ? 22 :18,right :index == groceryHomeController.homeData.value.category!.length - 1 ? 22 : 0  ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            groceryCategoriesFilterController.clearData();
                            Get.toNamed(AppRoutes.groceryCategoryDetails,
                                arguments: {
                                  'name': groceryHomeController
                                      .homeData.value.category![index].name
                                      .toString(),
                                  'id': int.parse(groceryHomeController
                                      .homeData.value.category![index].id
                                      .toString()),
                                });
                            grocerycategoriesdetailscontroller.groceryCategoriesDetailsApi(
                              id: groceryHomeController.homeData.value.category![index].id.toString(),
                            );
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CachedNetworkImage(
                                imageUrl: groceryHomeController
                                    .homeData.value.category![index].imageUrl
                                    .toString(),
                                fit: BoxFit.cover,
                                height: 60.h,
                                width: 60.h,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: AppColors.gray,
                                  highlightColor: AppColors.lightText,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.gray,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        hBox(15),
                        Text(
                          groceryHomeController.homeData.value.category![index].name.toString(),
                          style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
        hBox(20),
      ],
    );
  }

  Widget popularShop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(5.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Row(
            children: [
              Text(
                "Most Popular Shops",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(()=>AllGroceryShops());
                },
                child: Text(
                  "See All",
                  style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                ),
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
        hBox(15.h),
        SizedBox(
          height: 316.h,
          child: GetBuilder<GroceryHomeController>(
            init: groceryHomeController,
            builder: (controller) {
              return Obx(() {
                final shops = groceryHomeController.homeData.value.popularGrocery;
                return ListView.separated(
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  // controller: _horScrollControllerPopularShop,
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: shops?.length ?? 0,
                  itemBuilder: (context, index) {
                    final pharmashopsdata = shops?[index];
                    return GestureDetector(
                      onTap: () {
                        // groceryDetailsController.restaurant_Details_Api(id: pharmashopsdata.id.toString());
                        Get.to(()=>GroceryVendorDetailsScreen(groceryId: pharmashopsdata?.id.toString() ?? ""));
                        // Get.to(()=>GroceryVendorDetailsScreen(groceryId: pharmashopsdata.id.toString()));
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width*0.78,
                          child: controller.rxRequestStatusFilter.value== Status.LOADING
                          ? const ShimmerWidgetHomeScreen() :
                          pharmaShop(
                            index: index,
                            image: pharmashopsdata?.shopimage,
                            title: pharmashopsdata?.shopName,
                            rating: cleanNumber(pharmashopsdata?.avgRating ?? "0"),
                            price: pharmashopsdata?.avgPrice,
                            catIndex: pharmashopsdata?.categoryName?.length ?? 0,
                            catName: pharmashopsdata?.categoryName,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => wBox(15.w),
                );
              });
            },
          ),
        ),
        // if (groceryHomeController.isLoading.value)
        //   circularProgressIndicator(),
      ],
    );
  }

  Widget nearbyShop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Row(
            children: [
              Text(
                "Nearby Shops",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(()=>AllGroceryShops());
                },
                child: Text(
                  "See All",
                  style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                ),
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
        hBox(15.h),
        SizedBox(
          height: 316.h,
          child: GetBuilder<GroceryHomeController>(
            init: groceryHomeController,
            builder: (controller) {
              return Obx(() {
                final shops = groceryHomeController.homeData.value.nearbyGrocery;
                return ListView.separated(
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  // controller: _scrollControllerNearByShop,
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: shops?.length ?? 0,
                  itemBuilder: (context, index) {
                    // if (index ==  shops.length) {
                    //   return Container(
                    //     width: Get.width*0.78,
                    //     margin: const EdgeInsets.only(bottom: 102),
                    //     child: const ShimmerWidget(isRestaurantCard: true),);
                    // }
                    final pharmashopsdata = shops?[index];
                    return GestureDetector(
                      onTap: () {
                        // groceryDetailsController.restaurant_Details_Api(id: pharmashopsdata.id.toString());
                        Get.to(()=>GroceryVendorDetailsScreen(groceryId: pharmashopsdata?.id.toString() ?? ""));
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width*0.78,
                          child:  controller.rxRequestStatusFilter.value== Status.LOADING
                              ? const ShimmerWidgetHomeScreen() : pharmaShop(
                            index: index,
                            image: pharmashopsdata?.shopimage,
                            title: pharmashopsdata?.shopName,
                            rating: cleanNumber(pharmashopsdata?.avgRating ?? "0"),
                            price: pharmashopsdata?.avgPrice,
                            catIndex: pharmashopsdata?.categoryName?.length ?? 0,
                            catName: pharmashopsdata?.categoryName,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => wBox(15.w),
                );
              });
            },
          ),
        ),
        // if (groceryHomeController.isLoading.value)
        //   circularProgressIndicator(),
      ],
    );
  }

  Widget allShop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Row(
            children: [
              Text(
                "All Grocery Shops",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(()=>AllGroceryShops());
                },
                child: Text(
                  "See All",
                  style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                ),
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
        hBox(15.h),
        SizedBox(
          height: 316.h,
          child: GetBuilder<GroceryHomeController>(
            init: groceryHomeController,
            builder: (controller) {
              return Obx(() {
                final shops = groceryHomeController.homeData.value.groceryShops;
                return ListView.separated(
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  // controller: _scrollControllerAllShops,
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: shops?.length ?? 0,
                  itemBuilder: (context, index) {
                    final pharmashopsdata = shops?[index];
                    return GestureDetector(
                      onTap: () {
                        // groceryDetailsController.restaurant_Details_Api(id: pharmashopsdata.id.toString());
                        Get.to(()=>GroceryVendorDetailsScreen(groceryId: pharmashopsdata?.id.toString() ?? ""));
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width*0.78,
                          child: controller.rxRequestStatusFilter.value== Status.LOADING
                            ? const ShimmerWidgetHomeScreen() : pharmaShop(
                            index: index,
                            image: pharmashopsdata?.shopimage,
                            title: pharmashopsdata?.shopName,
                            rating: cleanNumber(pharmashopsdata?.avgRating ?? "0"),
                            price: pharmashopsdata?.avgPrice,
                            catIndex: pharmashopsdata?.categoryName?.length ?? 0,
                            catName: pharmashopsdata?.categoryName,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => wBox(15.w),
                );
              });
            },
          ),
        ),
        // if (groceryHomeController.isLoading.value)
        //   circularProgressIndicator(),
      ],
    );
  }

  Widget freeDeliveryShop() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(30.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Row(
            children: [
              Text(
                "Free Delivery Shops",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(()=>AllGroceryShops());
                },
                child: Text(
                  "See All",
                  style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroyMedium),
                ),
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
        hBox(15.h),
        SizedBox(
          height: 320.h,
          child: GetBuilder<GroceryHomeController>(
            init: groceryHomeController,
            builder: (controller) {
              return Obx(() {
                final shops = groceryHomeController.homeData.value.freedelGrocery;
                return ListView.separated(
                  // controller: _scrollControllerFreeDeliveryShop,
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: shops?.length ?? 0,
                  itemBuilder: (context, index) {
                    final pharmashopsdata = shops?[index];
                    return GestureDetector(
                      onTap: () {
                        // groceryDetailsController.restaurant_Details_Api(
                        //   id: pharmashopsdata.id.toString(),
                        // );
                        Get.to(()=>GroceryVendorDetailsScreen(groceryId: pharmashopsdata?.id.toString() ?? ""));
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width*0.78,
                          child:  controller.rxRequestStatusFilter.value== Status.LOADING
                              ? const ShimmerWidgetHomeScreen() : freeDeliveryPharmaShop(
                            index: index,
                            image: pharmashopsdata?.shopimage,
                            title: pharmashopsdata?.shopName,
                            rating: cleanNumber(pharmashopsdata?.avgRating ?? "0"),
                            price: pharmashopsdata?.avgPrice,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => wBox(15.w),
                );
              });
            },
          ),
        ),
        // if (groceryHomeController.isLoading.value)
        //   circularProgressIndicator(),
      ],
    );
  }

  String cleanNumber(String input) {
    double parsed = double.tryParse(input) ?? 0;
    return parsed == parsed.toInt()
        ? parsed.toInt().toString()
        : parsed.toString();
  }

  Widget pharmaShop({index, String? image, title, type, isFavourite, rating, price,catIndex,List<String>? catName}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CachedNetworkImage(
                memCacheHeight: memCacheHeight,
                imageUrl: image.toString(),
                fit: BoxFit.fill,
                width: double.maxFinite,
                height: 220.h,
                errorWidget: (context, url, error) => Container(
                  height: 220.h,
                  decoration: BoxDecoration(
                    color: AppColors.textFieldBorder.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.textFieldBorder)
                    border: Border.all(color: AppColors.textFieldBorder)
                  ),
                  child: Icon(Icons.broken_image_rounded,color: AppColors.greyImageColor),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: AppColors.gray,
                  highlightColor: AppColors.lightText,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     margin: REdgeInsets.only(top: 15, right: 15),
            //     padding: REdgeInsets.symmetric(horizontal: 6, vertical: 6),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10.r),
            //         color: AppColors.greyBackground),
            //     child: isFavourite != true
            //         ? Icon(
            //             Icons.favorite_border_outlined,
            //             size: 20.w,
            //           )
            //         : Icon(
            //             Icons.favorite,
            //             size: 20.w,
            //           ),
            //
            //     // SvgPicture.asset(
            //     //   "assets/svg/favorite-inactive.svg",
            //     //   height: 15.h,
            //     // ),
            //   ),
            // )
          ],
        ),
        hBox(10),
        Text(
          title.toString().capitalize ?? "",
          textAlign: TextAlign.left,
          style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
        ),
        // hBox(10),
        // Row(
        //   // crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Text(
        //       price,
        //       textAlign: TextAlign.left,
        //       style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroySemiBold),
        //     ),
        //     Text(
        //       " • ",
        //       textAlign: TextAlign.left,
        //       style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
        //     ),
        //     SvgPicture.asset("assets/svg/star-yellow.svg"),
        //     wBox(4),
        //     Text(
        //       "$rating/5",
        //       style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
        //     ),
        //   ],
        // ),
        hBox(2.h),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Text(
            //   price,
            //   textAlign: TextAlign.left,
            //   style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroySemiBold),
            // ),

            SvgPicture.asset("assets/svg/star-yellow.svg",height: 15,),
            wBox(4),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "$rating/5",
                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ),
            if(catIndex != null)...[
              catIndex == 0 ? const SizedBox.shrink() : Text(
                " • ",
                textAlign: TextAlign.left,
                style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
              ) ,
              Row(children: List.generate(catIndex > 3 ? 3 : catIndex, (index) => Text(
                "${catName?[index]}${index < (catIndex > 3 ? 3 : catIndex) - 1 ? ', ' : ''}",
                textAlign: TextAlign.left,
                style: AppFontStyle.text_14_400(AppColors.primary,family: AppFontFamily.gilroyRegular),
              ),
              ),
              ),
            ],
          ],
        ),
        hBox(2.h),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
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
                style: AppFontStyle.text_12_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
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
                style: AppFontStyle.text_12_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ),
            Text(
              " • ",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
            ),
            SvgPicture.asset(ImageConstants.cartIconImage,height: 14,colorFilter: ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),),
            wBox(3.w),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "No min. order",
                style: AppFontStyle.text_12_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget freeDeliveryPharmaShop({index, String? image, title, type, isFavourite, rating, price}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: CachedNetworkImage(
                memCacheHeight: memCacheHeight,
                imageUrl: image.toString(),
                fit: BoxFit.fill,
                width: double.maxFinite,
                height: 220.h,
                placeholder: (context, url) => const ShimmerWidget(),
                errorWidget: (context, url, error) => Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textFieldBorder),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(Icons.broken_image_rounded,color: AppColors.textFieldBorder)),
              ),
            ),
            // GestureDetector(
            //   onTap: () {},
            //   child: Container(
            //     margin: REdgeInsets.only(top: 15, right: 15),
            //     padding: REdgeInsets.symmetric(horizontal: 6, vertical: 6),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10.r),
            //         color: AppColors.greyBackground),
            //     child: isFavourite != true
            //         ? Icon(
            //             Icons.favorite_border_outlined,
            //             size: 20.w,
            //           )
            //         : Icon(
            //             Icons.favorite,
            //             size: 20.w,
            //           ),
            //
            //     // SvgPicture.asset(
            //     //   "assets/svg/favorite-inactive.svg",
            //     //   height: 15.h,
            //     // ),
            //   ),
            // )
          ],
        ),
        hBox(10),
        Text(
          title.toString().capitalize ?? "",
          textAlign: TextAlign.left,
          style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
        ),
        // hBox(10),
        // Row(
        //   // crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Text(
        //       price,
        //       textAlign: TextAlign.left,
        //       style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroySemiBold),
        //     ),
        //     Text(
        //       " • ",
        //       textAlign: TextAlign.left,
        //       style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
        //     ),
        //     SvgPicture.asset("assets/svg/star-yellow.svg"),
        //     wBox(4),
        //     Text(
        //       "$rating/5",
        //       style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
        //     ),
        //   ],
        // ),
        // hBox(2.h),
        // Row(
        //   // crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     // Text(
        //     //   price,
        //     //   textAlign: TextAlign.left,
        //     //   style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroySemiBold),
        //     // ),
        //
        //     SvgPicture.asset("assets/svg/star-yellow.svg",height: 15,),
        //     wBox(4),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 3.0),
        //       child: Text(
        //         "$rating/5",
        //         style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        //       ),
        //     ),
        //     Text(
        //       " • ",
        //       textAlign: TextAlign.left,
        //       style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
        //     ),
        //     Text(
        //       "Drink,Juices,Snacks",
        //       textAlign: TextAlign.left,
        //       style: AppFontStyle.text_14_400(AppColors.primary,family: AppFontFamily.gilroyRegular),
        //     ),
        //   ],
        // ),
        // hBox(2.h),
        // Row(
        //   // crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     // Text(
        //     //   price,
        //     //   textAlign: TextAlign.left,
        //     //   style: AppFontStyle.text_15_400(AppColors.primary,family: AppFontFamily.gilroySemiBold),
        //     // ),
        //
        //     SvgPicture.asset(ImageConstants.clockIcon,height: 14,colorFilter: ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),),
        //     wBox(3.w),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 3.0),
        //       child: Text(
        //         "30-50 mins",
        //         style: AppFontStyle.text_12_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        //       ),
        //     ),
        //     Text(
        //       " • ",
        //       textAlign: TextAlign.left,
        //       style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
        //     ),
        //     SvgPicture.asset(ImageConstants.scooterImage,height: 14,colorFilter: ColorFilter.mode(AppColors.darkText.withOpacity(0.8), BlendMode.srcIn),),
        //     wBox(3.w),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 3.0),
        //       child: Text(
        //         "\$5 Delivery",
        //         style: AppFontStyle.text_12_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        //       ),
        //     ),
        //     Text(
        //       " • ",
        //       textAlign: TextAlign.left,
        //       style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
        //     ),
        //     SvgPicture.asset(ImageConstants.cartIconImage,height: 14,colorFilter: ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),),
        //     wBox(3.w),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 3.0),
        //       child: Text(
        //         "No min. order",
        //         style: AppFontStyle.text_12_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        //       ),
        //     ),
        //   ],
        // ),
        hBox(2.h),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SvgPicture.asset("assets/svg/star-yellow.svg",height: 15,),
            wBox(4),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "$rating/5",
                style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ),
            Text(
              " • ",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
            ),
            SvgPicture.asset(ImageConstants.clockIcon,height: 14,colorFilter: ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),),
            wBox(3.w),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "30-50 mins",
                style: AppFontStyle.text_13_400(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
            ),
          ],
        ),
        hBox(4.h),
        Container(
          padding: REdgeInsets.symmetric(horizontal: 7,vertical: 6),
          // height: 20,
          decoration: BoxDecoration(color: AppColors.primary,borderRadius: BorderRadius.circular(6.r)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(ImageConstants.scooterImage,height: 14,colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),),
              wBox(5.w),
              Text(
                "Free Delivery",
                style: AppFontStyle.text_13_400(AppColors.white,family: AppFontFamily.gilroyRegular),
              ),
            ],
          ),),
      ],
    );
  }

  Widget ratingDeliveryFilterBtn() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: REdgeInsets.only(left: 24, bottom: 20, top: 5, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
                  () => CustomDropDown(
                borderRadius: 100.r,
                borderColor: AppColors.black.withOpacity(0.30),
                btnHeight: 40,
                // btnWidth: 150,
                hintText: "Rating",
                selectedValue: groceryHomeController.rating.value,
                hintStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                textStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                items: const ["High to Low", "Low to high"],
                onChanged: (val) {
                  if (val != null && val.isNotEmpty) {
                    groceryHomeController.rating.value = val;
                    groceryHomeController.getLatLong();
                    groceryHomeController.homeApiFilter();
                    pt(val);
                  }
                },
                cancelTap: () {
                  groceryHomeController.rating.value = "";
                  groceryHomeController.getLatLong();
                  groceryHomeController.homeApiFilter();
                },
              ),
            ),
            wBox(5.w),
            Obx(
                  () => CustomDropDown(
                borderRadius: 100.r,
                borderColor: AppColors.black.withOpacity(0.30),
                btnHeight: 40,
                // btnWidth: 150,
                hintText: "Delivery Fee",
                selectedValue: groceryHomeController.deliveryFee.value,
                hintStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                textStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                items: const ["Free"],
                onChanged: (val) {
                  if (val != null && val.isNotEmpty) {
                    groceryHomeController.deliveryFee.value = val;
                    groceryHomeController.getLatLong();
                    groceryHomeController.homeApiFilter();
                    pt(val);
                  }
                },
                cancelTap: () {
                  groceryHomeController.deliveryFee.value = "";
                  groceryHomeController.getLatLong();
                  groceryHomeController.homeApiFilter();
                },
              ),
            ),
            wBox(5.w),
            Obx(
                  () => CustomDropDown(
                borderRadius: 100.r,
                borderColor: AppColors.black.withOpacity(0.30),
                btnHeight: 40,
                // btnWidth: 150,
                hintText: "Open Now",
                selectedValue: groceryHomeController.openNow.value,
                hintStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                textStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                items: const ["Open", "Closed"],
                onChanged: (val) {
                  if (val != null && val.isNotEmpty) {
                    groceryHomeController.openNow.value = val;
                    // groceryHomeController.getLatLong();
                    // groceryHomeController.homeApiFilter();
                    pt(val);
                  }
                },
                cancelTap: () {
                  groceryHomeController.openNow.value = "";
                  groceryHomeController.latitude.value = "";
                  groceryHomeController.longitude.value = "";
                  // groceryHomeController.homeApiFilter();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
