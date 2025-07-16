import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/Controller/pharma_cart_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_cart/view/pharmacy_single_cart_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Categories_details/controller/PharmacyCategoriesDetailsController.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Filter/Pharma_Categories_Filter_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/PharmacyDetailsController.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/pharmacy_vendor_details_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/all_pharma_shops/all_pharma_shops.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/banner_screens/Pharma_home_banner_data.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/banner_screens/pharma_banner_details_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/controller/pharmacy_home_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pharmacy_navbar/controller/pharmacy_navbar_controller.dart';
import 'package:woye_user/shared/widgets/custom_dropdown.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';
import 'package:woye_user/shared/widgets/shimmer.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';
import '../../../../../Core/Utils/image_cache_height.dart';
import '../../../../../Shared/theme/font_family.dart';

class PharmacyHomeScreen extends StatefulWidget {
  const PharmacyHomeScreen({super.key});

  @override
  State<PharmacyHomeScreen> createState() => _PharmacyHomeScreenState();
}

class _PharmacyHomeScreenState extends State<PharmacyHomeScreen> {
  final PharmacyHomeController pharmacyHomeController =Get.put(PharmacyHomeController());

  final PharmacyNavbarController pharmacyNavbarController =Get.put(PharmacyNavbarController());
  final PharmacyDetailsController pharmacyDetailsController = Get.put(PharmacyDetailsController());
  final RestaurantNavbarController restaurantNavbarController =   Get.put(RestaurantNavbarController());

  final PharmacyCategoriesDetailsController pharmacyCategoriesDetailsController = Get.put(PharmacyCategoriesDetailsController());
  final PharmaCategoriesFilterController categoriesFilterController = Get.put(PharmaCategoriesFilterController());

  final PharmacyCartController pharmacyCartController = Get.put(PharmacyCartController());
  // final ScrollController _scrollControllerFreeDel = ScrollController();
  // final ScrollController _horScrollControllerPopularShop = ScrollController();
  // final ScrollController _horScrollControllerAllPharmacy = ScrollController();
  // final ScrollController _horScrollControllerNearBy = ScrollController();

  @override
  void initState() {
    super.initState();
    // getApiData();
    // // pharmacyCartController.getPharmacyCartApi();
    // // pharmacyCartController.getAllPharmacyCartData();
    // // _scrollController.addListener(() {
    // //   if (_scrollController.position.pixels ==
    // //       _scrollController.position.maxScrollExtent) {
    // //     if (pharmacyHomeController.noLoading.value != true) {
    // //       if (!pharmacyHomeController.isLoading.value) {
    // //         pharmacyHomeController.isLoading.value = true;
    // //         pharmacyHomeController.currentPage++;
    // //         print(
    // //             "currentPage value ${pharmacyHomeController.currentPage.value}");
    // //         pharmacyHomeController
    // //             .homeApi(pharmacyHomeController.currentPage.value);
    // //       }
    // //     }
    // //   }
    // // });
    // _horScrollControllerPopularShop.addListener(() {
    //   if (_horScrollControllerPopularShop.position.pixels >= _horScrollControllerPopularShop.position.maxScrollExtent - 100) {
    //     if (!pharmacyHomeController.isLoadingPopular.value && !pharmacyHomeController.noMoreDataPopularLoading.value) {
    //       pharmacyHomeController.isLoadingPopular.value = true;
    //       pharmacyHomeController.currentPage.value++;
    //       pharmacyHomeController.homeApi(pharmacyHomeController.currentPage.value);
    //     }
    //   }
    // });
    //
    // _scrollControllerFreeDel.addListener(() {
    //   if (_scrollControllerFreeDel.position.pixels >= _scrollControllerFreeDel.position.maxScrollExtent - 100) {
    //     if (!pharmacyHomeController.isLoadingFree.value && !pharmacyHomeController.noMoreDataFreeLoading.value) {
    //       pharmacyHomeController.isLoadingFree.value = true;
    //       pharmacyHomeController.currentPage.value++;
    //       pharmacyHomeController.homeApi(pharmacyHomeController.currentPage.value);
    //     }
    //   }
    // });
    //
    //
    // _horScrollControllerNearBy.addListener(() {
    //   if (_horScrollControllerNearBy.position.pixels >= _horScrollControllerNearBy.position.maxScrollExtent - 100) {
    //     if (!pharmacyHomeController.isLoadingNearby.value && !pharmacyHomeController.noMoreDataNearbyLoading.value) {
    //       pharmacyHomeController.isLoadingNearby.value = true;
    //       pharmacyHomeController.currentPage.value++;
    //       pharmacyHomeController.homeApi(pharmacyHomeController.currentPage.value);
    //     }
    //   }
    // });
    //
    //
    // _horScrollControllerAllPharmacy.addListener(() {
    //   if (_horScrollControllerAllPharmacy.position.pixels >= _horScrollControllerAllPharmacy.position.maxScrollExtent - 100) {
    //     if (!pharmacyHomeController.isLoadingPharmacy.value && !pharmacyHomeController.noMoreDataPharmacyLoading.value) {
    //       pharmacyHomeController.isLoadingPharmacy.value = true;
    //       pharmacyHomeController.currentPage.value++;
    //       pharmacyHomeController.homeApi(pharmacyHomeController.currentPage.value);
    //     }
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((_)async {
      await pharmacyCartController.getAllPharmacyCartData();
    },);
  }

  // getApiData()async{

    // await pharmacyCartController.getPharmacyCartApi(cartId:pharmacyCartController.cartDataAll.value.carts?.map((val)=>val.id.toString()).toList().toString() ?? "");
  // }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (pharmacyHomeController.rxRequestStatus.value) {
        case Status.LOADING:
          return Center(child: circularProgressIndicator());
        case Status.ERROR:
          if (pharmacyHomeController.error.value == 'No internet'  || pharmacyHomeController.error.value == 'InternetExceptionWidget') {
            return InternetExceptionWidget(
              onPress: () {
                pharmacyHomeController.homeApiRefresh();
              },
            );
          } else {
            return GeneralExceptionWidget(
              onPress: () {
                pharmacyHomeController.homeApiRefresh();
              },
            );
          }
        case Status.COMPLETED:
          return RefreshIndicator(
            onRefresh: () async {
              pharmacyHomeController.homeApiRefresh();
              await pharmacyCartController.getAllPharmacyCartData();
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
                          if (pharmacyHomeController.homeData.value.category?.isNotEmpty ?? false)
                            SliverToBoxAdapter(
                            child: catergories(),
                            // child: ratingDeliveryFilterBtn(),
                          ),
                          SliverPadding(
                              padding: REdgeInsets.symmetric(horizontal: 0),
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    if (pharmacyHomeController.homeData.value.banners!.isNotEmpty)
                                      mainBanner(),
                                      ratingDeliveryFilterBtn(),
                                    if (pharmacyHomeController.homeData.value.popularPharma?.isNotEmpty ?? false)...[
                                      popularShop(),
                                    ],
                                    if (pharmacyHomeController.homeData.value.freedelPharma?.isNotEmpty ?? false)...[
                                      freeDeliveryShops(),
                                    ],
                                    if (pharmacyHomeController.homeData.value.nearbyPharma?.isNotEmpty ?? false)...[
                                    nearByShops(),
                                    ],
                                    if (pharmacyHomeController.homeData.value.pharmaShops?.isNotEmpty ?? false)...[
                                      allPharmacyShops(),
                                    ],
                                    hBox(100.h)
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    if(pharmacyCartController.cartDataAll.value.buttonCheck == true)
                      hBox(75.h),
                  ],
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: Padding(
                  padding: EdgeInsets.only(bottom:60.h),
                    child: pharmacyCartController.cartDataAll.value.buttonCheck == false
/*
                    (pharmacyCartController.cartDataAll.value.carts?.isEmpty ?? true)
*/
                        ? const SizedBox()
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
                                            imageUrl: pharmacyCartController.cartDataAll.value.carts?[0].pharmacy?.shopimage.toString() ?? "",
                                            placeholder: (context, url) =>
                                                circularProgressIndicator(),
                                            errorWidget:(context, url, error) =>
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
                                        /*pharmacyCartController.cartDataAll.value.carts?.length == 1 ?*/
                                        Text(
                                          pharmacyCartController.cartDataAll.value.carts?[0].pharmacy?.shopName.toString() ?? "",
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.text_14_500(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                        )
                                        /*:Text(
                                          "Your Carts",
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFontStyle.text_16_500(AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
                                        // pharmacyNavbarController.getIndex(3);
                                        Get.to(()=>RestaurantBaseScaffold(
                                          child: PharmacySingleCartScreen(
                                            cartId:pharmacyCartController.cartDataAll.value.carts?[0].id.toString() ?? "",
                                            isBack: true,
                                          ),
                                        ));
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                           /* pharmacyCartController.cartDataAll.value.carts?.length == 1 ?*/ "View Cart" /*: "View Carts"*/,
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
                            ),
                            Positioned(
                              top: -15.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  print(pharmacyCartController.cartDataAll.value.carts?.length);
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
              Get.toNamed(AppRoutes.pharmcayHomeFilter);
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

  final PharmaBannerDetailsControllerController bannerDetailsController = Get.put(PharmaBannerDetailsControllerController());

  Widget mainBanner() {
    return Column(
      children: [
        Obx(() {
          final banners = pharmacyHomeController.homeData.value.banners;
          return CarouselSlider.builder(
            itemCount: banners!.length,
            options: CarouselOptions(
              height: 150.h,
              autoPlay:
                  pharmacyHomeController.homeData.value.banners!.length > 1
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
                  Get.to(()=>RestaurantBaseScaffold(
                    child: PharmacyHomeBanner(
                      bannerID: banners[index].id.toString(),
                    ),
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
                    "Categories",
                    style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                  ),
                  const Spacer(),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      pharmacyNavbarController.getIndex(1);
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
            hBox(20.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  pharmacyHomeController.homeData.value.category?.length ?? 0,
                  (index) {
                  return Padding(
                    padding: REdgeInsets.only(left: index == 0 ? 22 :10,right :index == pharmacyHomeController.homeData.value.category!.length - 1 ? 22 : 0  ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            categoriesFilterController.resetFilters();
                            Get.toNamed(AppRoutes.pharmacyCategoryDetails,
                                arguments: {
                                  'name': pharmacyHomeController
                                      .homeData.value.category![index].name
                                      .toString(),
                                  'id': int.parse(pharmacyHomeController
                                      .homeData.value.category![index].id
                                      .toString()),
                                });
                            pharmacyCategoriesDetailsController.pharmacy_Categories_Details_Api(
                              id: pharmacyHomeController.homeData.value.category![index].id.toString(),
                            );
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CachedNetworkImage(
                                imageUrl: pharmacyHomeController
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
                          pharmacyHomeController
                              .homeData.value.category![index].name
                              .toString(),
                          style: AppFontStyle.text_14_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
        hBox(10.h),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                "Most Popular Shops",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to( ()=> RestaurantBaseScaffold(child: AllPharmaShopsScreen()));
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
        hBox(20.h),
        SizedBox(
          // color: AppColors.primary,
          height: 315.h,
          child: GetBuilder<PharmacyHomeController>(
            init: pharmacyHomeController,
            builder: (controller) {
              return Obx(() {
                final shops = pharmacyHomeController.homeData.value.popularPharma;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  // controller: _horScrollControllerPopularShop,
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: pharmacyHomeController.homeData.value.popularPharma?.length ?? 0,
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
                        // pharmacyDetailsController.restaurant_Details_Api(
                        //   id: pharmashopsdata.id.toString(),
                        // );
                        // print("object ${pharmashopsdata?.categoryNames?.length}");
                        Get.to(()=>RestaurantBaseScaffold(child: PharmacyVendorDetailsScreen(pharmacyId: pharmashopsdata?.id.toString() ?? "")));
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width * 0.78,
                          child: controller.rxRequestStatusFilter.value == Status.LOADING
                            ? const ShimmerWidgetHomeScreen() : pharmaShop(
                            index: index,
                            image: pharmashopsdata?.shopimage,
                            title: pharmashopsdata?.shopName,
                            rating:cleanNumber(pharmashopsdata?.avgRating ?? "0") ,
                            price: pharmashopsdata?.rating,
                            catIndex: pharmashopsdata?.categoryNames?.length ?? 0,
                            catName: pharmashopsdata?.categoryNames
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
        // if (pharmacyHomeController.isLoading.value)
        //   circularProgressIndicator(),
      ],
    );
  }

  Widget freeDeliveryShops() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(25.h),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                "Free Delivery Shops",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to( ()=> RestaurantBaseScaffold(child: AllPharmaShopsScreen()));
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
              ),
            ],
          ),
        ),
        hBox(20.h),
        SizedBox(
          // color: AppColors.primary,
          height: 315.h,
          child: GetBuilder<PharmacyHomeController>(
            init: pharmacyHomeController,
            builder: (controller) {
              return Obx(() {
                final shops = pharmacyHomeController.homeData.value.freedelPharma;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  // controller: _scrollControllerFreeDel,
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: shops?.length  ?? 0,
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
                        pharmacyDetailsController.restaurant_Details_Api(id: pharmashopsdata?.id.toString() ?? "");
                        Get.to(()=>RestaurantBaseScaffold(child: PharmacyVendorDetailsScreen(pharmacyId: pharmashopsdata?.id.toString() ?? "")));
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width * 0.78,
                          child:controller.rxRequestStatusFilter.value == Status.LOADING
                              ? const ShimmerWidgetHomeScreen() : freeDeliveryPharmacyShopList(
                            index: index,
                            image: pharmashopsdata?.shopimage,
                            title: pharmashopsdata?.shopName,
                            rating:cleanNumber(pharmashopsdata?.avgRating ?? "0") ,
                            price: pharmashopsdata?.rating,

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
        // if (pharmacyHomeController.isLoading.value)
        //   circularProgressIndicator(),
      ],
    );
  }

  Widget nearByShops() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(25.h),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                "Nearby Shops",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to( ()=> RestaurantBaseScaffold(child: AllPharmaShopsScreen()));
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
              ),
            ],
          ),
        ),
        hBox(20.h),
        SizedBox(
          // color: AppColors.primary,
          height: 315.h,
          child: GetBuilder<PharmacyHomeController>(
            init: pharmacyHomeController,
            builder: (controller) {
              return Obx(() {
                final shops = pharmacyHomeController.homeData.value.nearbyPharma;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  // controller: _horScrollControllerNearBy,
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: shops?.length ?? 0,
                  itemBuilder: (context, index) {
                    final pharmashopsdata = shops?[index];
                    return GestureDetector(
                      onTap: () {
                        pharmacyDetailsController.restaurant_Details_Api(id: pharmashopsdata?.id.toString() ?? "");
                        Get.to(()=>RestaurantBaseScaffold(child: PharmacyVendorDetailsScreen(pharmacyId: pharmashopsdata?.id.toString() ?? "")));
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width * 0.78,
                          child: controller.rxRequestStatusFilter.value == Status.LOADING
                              ? const ShimmerWidgetHomeScreen() : pharmaShop(
                            index: index,
                            image: pharmashopsdata?.shopimage,
                            title: pharmashopsdata?.shopName,
                            rating:cleanNumber(pharmashopsdata?.avgRating ?? "0") ,
                            price: pharmashopsdata?.rating,
                            catIndex: pharmashopsdata?.categoryNames?.length ?? 0,
                            catName: pharmashopsdata?.categoryNames
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
        // if (pharmacyHomeController.isLoading.value)
        //   circularProgressIndicator(),
      ],
    );
  }

  Widget allPharmacyShops() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(25.h),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                "All Pharmacy Shops",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to( ()=> RestaurantBaseScaffold(child: AllPharmaShopsScreen()));
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
              ),
            ],
          ),
        ),
        hBox(20.h),
        SizedBox(
          // color: AppColors.primary,
          height: 315.h,
          child: GetBuilder<PharmacyHomeController>(
            init: pharmacyHomeController,
            builder: (controller) {
              return Obx(() {
                final shops = pharmacyHomeController.homeData.value.pharmaShops;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  // controller: _horScrollControllerAllPharmacy,
                  padding: REdgeInsets.only(left:22,right: 20,top: 1),
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: shops?.length ?? 0,
                  itemBuilder: (context, index) {
                    final pharmashopsdata = shops?[index];
                    return GestureDetector(
                      onTap: () {
                        pharmacyDetailsController.restaurant_Details_Api(id: pharmashopsdata?.id.toString() ?? "");
                        Get.to(RestaurantBaseScaffold(child: PharmacyVendorDetailsScreen(pharmacyId: pharmashopsdata?.id.toString() ?? "")));
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width * 0.78,
                          child: controller.rxRequestStatusFilter.value == Status.LOADING
                              ? const ShimmerWidgetHomeScreen() : pharmaShop(
                            index: index,
                            image: pharmashopsdata?.shopimage,
                            title: pharmashopsdata?.shopName,
                            rating:cleanNumber(pharmashopsdata?.avgRating ?? "0") ,
                            price: pharmashopsdata?.rating,
                            catIndex: pharmashopsdata?.categoryNames?.length ?? 0,
                            catName: pharmashopsdata?.categoryNames
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
        // if (pharmacyHomeController.isLoading.value)
        //   circularProgressIndicator(),
      ],
    );
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
              child:image != null ? CachedNetworkImage(
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
              ):Container(
                  height: 220.h,
                  width: Get.width * 0.78,


                  clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.textFieldBorder),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(Icons.broken_image_rounded,color: AppColors.textFieldBorder)),
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
          style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
        ),
        // hBox(10),
        // Row(
        //   // crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Text(
        //       price ?? "",
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
        // )
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
              catIndex != 0 ? Text(
                " • ",
                textAlign: TextAlign.left,
                style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
              ) : const SizedBox.shrink(),
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
                      "Your Carts(${pharmacyCartController.cartDataAll.value.carts?.length})",
                      style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                    ),
                    const Spacer(),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Get.back();
                        // pharmacyNavbarController.getIndex(3);
                        restaurantNavbarController.getIndex(3);
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
                  itemCount:pharmacyCartController.cartDataAll.value.carts?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var carts = pharmacyCartController.cartDataAll.value.carts?[index];
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
                                    carts?.pharmacy?.shopimage.toString() ?? "",
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
                                  carts?.pharmacy?.shopName.toString() ?? "",
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
                                Get.to(()=>RestaurantBaseScaffold(
                                  child: PharmacySingleCartScreen(
                                    cartId: carts?.id.toString() ?? "",
                                    isBack: true,
                                    ),
                                ),
                                );
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
                                    style: AppFontStyle.text_10_400(AppColors.white.withOpacity(.5),family: AppFontFamily.gilroyMedium),                                    overflow: TextOverflow.ellipsis,
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

  String cleanNumber(String input) {
    double parsed = double.tryParse(input) ?? 0;
    return parsed == parsed.toInt()
        ? parsed.toInt().toString()
        : parsed.toString();
  }

  Widget freeDeliveryPharmacyShopList({index, String? image, title, type, isFavourite, rating, price}) {
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
              child: image != null ? CachedNetworkImage(
                memCacheHeight: memCacheHeight,
                imageUrl: image.toString(),
                fit: BoxFit.fill,
                width: double.maxFinite,
                height: 210.h,
                placeholder: (context, url) => const ShimmerWidget(),
                errorWidget: (context, url, error) => Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textFieldBorder),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(Icons.broken_image_rounded,color: AppColors.textFieldBorder)),
              ):Container(
                  height: 220.h,
                  width: Get.width * 0.78,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.textFieldBorder),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Icon(Icons.broken_image_rounded,color: AppColors.textFieldBorder)),
            ),
          ],
        ),
        hBox(10.h),
        Text(
          title.toString().capitalize ?? "",
          textAlign: TextAlign.left,
          style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
        ),
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
        padding: REdgeInsets.only(left: 24, bottom: 10, top: 5, right: 24),
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
                selectedValue: pharmacyHomeController.rating.value,
                hintStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                textStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                items: const ["High to Low", "Low to high"],
                onChanged: (val) {
                  if (val != null && val.isNotEmpty) {
                    pharmacyHomeController.rating.value = val;
                    pharmacyHomeController.getLatLong();
                    pharmacyHomeController.setRxRequestStatusFilter(Status.LOADING);
                    pharmacyHomeController.homeApi();
                    pt(val);
                  }
                },
                cancelTap: () {
                  pharmacyHomeController.rating.value = "";
                  pharmacyHomeController.getLatLong();
                  pharmacyHomeController.setRxRequestStatusFilter(Status.LOADING);
                  pharmacyHomeController.homeApi();
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
                selectedValue: pharmacyHomeController.deliveryFee.value,
                hintStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                textStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                items: const ["Free"],
                onChanged: (val) {
                  if (val != null && val.isNotEmpty) {
                    pharmacyHomeController.deliveryFee.value = val;
                    pharmacyHomeController.getLatLong();
                    pharmacyHomeController.setRxRequestStatusFilter(Status.LOADING);
                    pharmacyHomeController.homeApi();
                    pt(val);
                  }
                },
                cancelTap: () {
                  pharmacyHomeController.deliveryFee.value = "";
                  pharmacyHomeController.getLatLong();
                  pharmacyHomeController.setRxRequestStatusFilter(Status.LOADING);
                  pharmacyHomeController.homeApi();
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
                selectedValue: pharmacyHomeController.openNow.value,
                hintStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                textStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                items: const ["Open", "Closed"],
                onChanged: (val) {
                  if (val != null && val.isNotEmpty) {
                    pharmacyHomeController.openNow.value = val;
                    // pharmacyHomeController.setRxRequestStatusFilter(Status.LOADING);
                    // pharmacyHomeController.getLatLong();
                    // pharmacyHomeController.homeApi();
                    pt(val);
                  }
                },
                cancelTap: () {
                  pharmacyHomeController.openNow.value = "";
                  pharmacyHomeController.latitude.value = "";
                  pharmacyHomeController.longitude.value = "";
                  // pharmacyHomeController.setRxRequestStatusFilter(Status.LOADING);
                  // pharmacyHomeController.homeApi();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
