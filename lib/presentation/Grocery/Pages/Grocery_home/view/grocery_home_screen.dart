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

import '../../../../../Shared/theme/font_family.dart';
import '../../../../../shared/widgets/shimmer.dart';
import '../../Grocery_categories/Sub_screens/Filter/Grocery_Categories_Filter_controller.dart';

class GroceryHomeScreen extends StatefulWidget {
  GroceryHomeScreen({super.key});

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

  final ScrollController _scrollController = ScrollController();
  final ScrollController _horScrollControllerPopularShop = ScrollController();
  final ScrollController _scrollControllerFreeDeliveryShop = ScrollController();

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

    _horScrollControllerPopularShop.addListener(() {
      if (_horScrollControllerPopularShop.position.pixels >= _horScrollControllerPopularShop.position.maxScrollExtent - 100) {
        if (!groceryHomeController.isLoadingPopular.value && !groceryHomeController.noMoreDataPopularLoading.value) {
          groceryHomeController.isLoadingPopular.value = true;
          groceryHomeController.currentPage.value++;
          groceryHomeController.homeApi(groceryHomeController.currentPage.value);
        }
      }
    });

    _scrollControllerFreeDeliveryShop.addListener(() {
      if (_scrollControllerFreeDeliveryShop.position.pixels >= _scrollControllerFreeDeliveryShop.position.maxScrollExtent - 100) {
        if (!groceryHomeController.isLoadingFree.value && !groceryHomeController.noMoreDataFreeLoading.value) {
          groceryHomeController.isLoadingFree.value = true;
          groceryHomeController.currentPage.value++;
          groceryHomeController.homeApi(groceryHomeController.currentPage.value);
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (groceryHomeController.rxRequestStatus.value) {
        case Status.LOADING:
          return Center(child: circularProgressIndicator());
        case Status.ERROR:
          if (groceryHomeController.error.value == 'No internet') {
            return InternetExceptionWidget(
              onPress: () {
                groceryHomeController.homeApiRefresh(1);
              },
            );
          } else {
            return GeneralExceptionWidget(
              onPress: () {
                groceryHomeController.homeApiRefresh(1);
              },
            );
          }
        case Status.COMPLETED:
          return RefreshIndicator(
            onRefresh: () async {
              groceryHomeController.homeApiRefresh(1);
              groceryCartController.getGroceryAllCartApi();
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
                          SliverPadding(
                              padding: REdgeInsets.symmetric(horizontal: 0),
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    if (groceryHomeController.homeData.value.banners!.isNotEmpty)
                                      mainBanner(),
                                    if (groceryHomeController.homeData.value.category!.isNotEmpty)
                                      catergories(),
                                    if (groceryHomeController.homeData.value.groceryShops!.data!.isNotEmpty)
                                      popularShop(),
                                      freeDeliveryShop(),
                                    hBox(100.h)
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Padding(
                  padding: EdgeInsets.only(bottom: 60.h),
                  child: groceryShowAllCartController.cartData.value.buttonCheck == false
                      ? SizedBox()
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
                                            Text(
                                              groceryShowAllCartController
                                                  .cartData
                                                  .value
                                                  .carts![0]
                                                  .grocery!
                                                  .shopName
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: AppFontStyle.text_14_500(
                                                  AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () {
                                            // Get.back();
                                            Get.to(SingleVendorGroceryCart(
                                              cartId:groceryShowAllCartController.cartData.value.carts![0].id.toString(),
                                              isBack: true,
                                            ));
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                "View Cart",
                                                style: AppFontStyle.text_14_400(
                                                    AppColors.white),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                              Text(
                                                "items",
                                                style: AppFontStyle.text_10_400(
                                                    AppColors.white
                                                        .withOpacity(.5)),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
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
                                              AppColors.primary),
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
                      style: AppFontStyle.text_20_600(AppColors.darkText),
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
                            style: AppFontStyle.text_14_600(AppColors.primary),
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
                                  style: AppFontStyle.text_14_500(
                                      AppColors.darkText),
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
                                // Get.back();
                                Get.to(SingleVendorGroceryCart(
                                  cartId: carts.id.toString(),
                                  isBack: true,
                                ));
                              },
                              child: Column(
                                children: [
                                  Text(
                                    "View Cart",
                                    style: AppFontStyle.text_14_400(
                                        AppColors.white),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    "items",
                                    style: AppFontStyle.text_10_400(
                                        AppColors.white.withOpacity(.5)),
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

  final GroceryBannerDetailsController bannerDetailsController =
      Get.put(GroceryBannerDetailsController());

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
                  Get.to(GroceryHomeBanner(
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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            children: [
              Row(
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
                      groceryCategoriesFilterController.clearData();
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
              hBox(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.groceryCategoryDetails,
                              arguments: {
                                'name': groceryHomeController
                                    .homeData.value.category![index].name
                                    .toString(),
                                'id': int.parse(groceryHomeController
                                    .homeData.value.category![index].id
                                    .toString()),
                              });
                          grocerycategoriesdetailscontroller
                              .groceryCategoriesDetailsApi(
                            id: groceryHomeController
                                .homeData.value.category![index].id
                                .toString(),
                          );
                          groceryCategoriesFilterController.clearData();
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
                  );
                }),
              ),
            ],
          ),
        ),
        hBox(20),
      ],
    );
  }

  Widget popularShop() {
    return Column(
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
                final shops = groceryHomeController.shopsList;
                return ListView.separated(
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  controller: _horScrollControllerPopularShop,
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: shops.length + (groceryHomeController.isLoadingPopular.value ? 1:0),
                  itemBuilder: (context, index) {
                    if (index ==  shops.length) {
                      return Container(
                        width: Get.width*0.78,
                        margin: const EdgeInsets.only(bottom: 102),
                        child: const ShimmerWidget(isRestaurantCard: true),);
                    }
                    final pharmashopsdata = shops[index];
                    return GestureDetector(
                      onTap: () {
                        groceryDetailsController.restaurant_Details_Api(
                          id: pharmashopsdata.id.toString(),
                        );
                        Get.to(GroceryVendorDetailsScreen(
                          groceryId: pharmashopsdata.id.toString(),
                        ));
                      },
                      child: SizedBox(
                        width: Get.width*0.78,
                        child: pharmaShop(
                          index: index,
                          image: pharmashopsdata.shopimage,
                          title: pharmashopsdata.shopName,
                          rating: cleanNumber(pharmashopsdata.avgRating ?? "0"),
                          price: pharmashopsdata.avgPrice,
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
                final shops = groceryHomeController.freeDeliveryShopsList;
                return ListView.separated(
                  controller: _scrollControllerFreeDeliveryShop,
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: shops.length +  (groceryHomeController.isLoadingFree.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index ==  shops.length) {
                      return Container(
                        width: Get.width*0.78,
                        margin: const EdgeInsets.only(bottom: 102),
                        child: const ShimmerWidget(isRestaurantCard: true),);
                    }
                    final pharmashopsdata = shops[index];
                    return GestureDetector(
                      onTap: () {
                        groceryDetailsController.restaurant_Details_Api(
                          id: pharmashopsdata.id.toString(),
                        );
                        Get.to(GroceryVendorDetailsScreen(
                          groceryId: pharmashopsdata.id.toString(),
                        ));
                      },
                      child: SizedBox(
                        width: Get.width*0.78,
                        child: freeDeliveryPharmaShop(
                          index: index,
                          image: pharmashopsdata.shopimage,
                          title: pharmashopsdata.shopName,
                          rating: cleanNumber(pharmashopsdata.avgRating ?? "0"),
                          price: pharmashopsdata.avgPrice,
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

  Widget pharmaShop({index, String? image, title, type, isFavourite, rating, price}) {
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
            Text(
              " • ",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
            ),
            Text(
              "Drink,Juices,Snacks",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_14_400(AppColors.primary,family: AppFontFamily.gilroyRegular),
            ),
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

}
