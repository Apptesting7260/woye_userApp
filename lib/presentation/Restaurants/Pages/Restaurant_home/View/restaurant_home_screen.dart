import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/controller/restaurant_home_controller.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/All_Restaurant/view/all_restaurant.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/banners_screens/banner_details_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/banners_screens/home_banner_data.dart';
import 'package:woye_user/presentation/common/Home/home_controller.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/custom_dropdown.dart';
import 'package:woye_user/shared/widgets/custom_print.dart';
import 'package:woye_user/shared/widgets/shimmer.dart';
import '../../../../../Data/components/GeneralException.dart';
import '../../../../../Data/components/InternetException.dart';
import '../../../../../shared/widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../Restaurant_cart/Controller/restaurant_cart_controller.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key});

  @override
  State<RestaurantHomeScreen> createState() => _HomeRestaurantScreenState();
}

class _HomeRestaurantScreenState extends State<RestaurantHomeScreen> {
  GlobalKey homeWidgetKey = GlobalKey();
  double? height;
  final RestaurantHomeController restaurantHomeController = Get.put(RestaurantHomeController());
  final RestaurantNavbarController restaurantNavbarController = Get.put(RestaurantNavbarController());


  _getHeight(_) {
    final keyContext = homeWidgetKey.currentContext;
    if (keyContext != null) height = keyContext.size!.height;
  }

  final RestaurantCategoriesDetailsController  restaurantCategoriesDetailsController =    Get.put(RestaurantCategoriesDetailsController());

  final RestaurantDetailsController restaurantDetailsController = Get.put(RestaurantDetailsController());

  // final ScrollController _horScrollControllerAllRestaurant = ScrollController();
  // final ScrollController _horizontalScrollControllerPopularRes = ScrollController();
  // final ScrollController _horScrollControllerFreeDeliveryRes = ScrollController();
  // final ScrollController _horScrollControllerNearByRes = ScrollController();
  // final ScrollController _scrollController = ScrollController();

  final RestaurantCartController restaurantCartController = Get.put(RestaurantCartController());
  // var storage = GetStorage();

  @override
  void initState() {
    restaurantCartController.getRestaurantCartApi();
    // latitude.value = storage.read('latitude') ?? 0.0;
    // longitude.value = storage.read('longitude') ?? 0.0;
    // restaurantHomeController.latitude.value = storage.read('latitude').toString();
    // restaurantHomeController.longitude.value =storage.read('longitude').toString();
    // pt("lat long >> ${restaurantHomeController.latitude.value} ::: ${restaurantHomeController.longitude.value}");
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_getHeight);
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     if (restaurantHomeController.noLoading.value != true) {
    //       if (!restaurantHomeController.isLoading.value) {
    //         restaurantHomeController.isLoading.value = true;
    //         restaurantHomeController.currentPage++;
    //         print(
    //             "currentPage value ${restaurantHomeController.currentPage.value}");
    //         restaurantHomeController
    //             .homeApi(restaurantHomeController.currentPage.value);
    //       }
    //     }
    //   }
    // });
// ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//     _horScrollControllerAllRestaurant.addListener(() {
//       if (_horScrollControllerAllRestaurant.position.pixels >= _horScrollControllerAllRestaurant.position.maxScrollExtent - 100) {
//         if (!restaurantHomeController.isLoadingRestaurant.value && !restaurantHomeController.noMoreDataRestaurant.value) {
//           restaurantHomeController.isLoadingRestaurant.value = true;
//           restaurantHomeController.currentPage.value++;
//           restaurantHomeController.homeApi(restaurantHomeController.currentPage.value);
//         }
//       }
//     });
//
//     _horizontalScrollControllerPopularRes.addListener(() {
//       if (_horizontalScrollControllerPopularRes.position.pixels >= _horizontalScrollControllerPopularRes.position.maxScrollExtent - 100) {
//         if (!restaurantHomeController.isLoadingPopular.value && !restaurantHomeController.noMoreDataPopular.value) {
//           restaurantHomeController.isLoadingPopular.value = true;
//           restaurantHomeController.currentPage.value++;
//           restaurantHomeController.homeApi(restaurantHomeController.currentPage.value);
//         }
//       }
//     });
//
//     _horScrollControllerFreeDeliveryRes.addListener(() {
//       if (_horScrollControllerFreeDeliveryRes.position.pixels >=_horScrollControllerFreeDeliveryRes.position.maxScrollExtent - 100) {
//         if (!restaurantHomeController.isLoadingFree.value && !restaurantHomeController.noMoreDataFree.value) {
//           restaurantHomeController.isLoadingFree.value = true;
//           restaurantHomeController.currentPage.value++;
//           restaurantHomeController.homeApi(restaurantHomeController.currentPage.value);
//         }
//       }
//     });
//
//     _horScrollControllerNearByRes.addListener(() {
//       if (_horScrollControllerNearByRes.position.pixels >=_horScrollControllerNearByRes.position.maxScrollExtent - 100) {
//         if (!restaurantHomeController.isLoadingNearby.value && !restaurantHomeController.noMoreDataNearby.value) {
//           restaurantHomeController.isLoadingNearby.value = true;
//           restaurantHomeController.currentPage.value++;
//           restaurantHomeController.homeApi(restaurantHomeController.currentPage.value);
//         }
//       }
//     });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (restaurantHomeController.rxRequestStatus.value) {
        case Status.LOADING:
          return Center(child: circularProgressIndicator());
        case Status.ERROR:
          if (restaurantHomeController.error.value == 'No internet' || restaurantHomeController.error.value == 'InternetExceptionWidget') {
            return InternetExceptionWidget(
              isAppbar: false,
              onPress: () {
                restaurantHomeController.homeApiRefresh();
              },
            );
          } else {
            return GeneralExceptionWidget(
              onPress: () {
                restaurantHomeController.homeApiRefresh();
              },
            );
          }
        case Status.COMPLETED:
          return SafeArea(
            child: Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  restaurantHomeController.homeApiRefresh();
                },
                child: Column(
                  children: [
                    HomeScreen(
                      key: homeWidgetKey,
                    ),
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
                          SliverToBoxAdapter(
                              child: ratingDeliveryFilterBtn(),
                          ),
                          SliverPadding(
                              padding: REdgeInsets.symmetric(horizontal: 0),
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    // GestureDetector(
                                    //     onTap: (){
                                    //       FirebaseCrashlytics.instance.crash();
                                    //     },
                                    //     child: Text("Crash")),
                                    if (restaurantHomeController.homeData.value.banners!.isNotEmpty)
                                      mainBanner(),
                                    if (restaurantHomeController.homeData.value.category!.isNotEmpty)
                                      catergories(),
                                    // if (restaurantHomeController.popularRestaurantList.isNotEmpty)
                                    if (restaurantHomeController.homeData.value.popularResto?.isNotEmpty ?? false)
                                      mostPopularRestaurant(),
                                    // if (restaurantHomeController.freeDeliveryRestaurantList.isNotEmpty)
                                    if (restaurantHomeController.homeData.value.freedelResto?.isNotEmpty ?? false)
                                      freeDeliveryRestaurant(),
                                    // if (restaurantHomeController.nearByRestaurantList.isNotEmpty)
                                      if (restaurantHomeController.homeData.value.nearbyResto?.isNotEmpty ?? false)
                                      nearByRestaurant(),
                                    // if (restaurantHomeController.restaurantList.isNotEmpty)
                                      if (restaurantHomeController.homeData.value.restaurants?.isNotEmpty ?? false)
                                      allRestaurant(),
                                    hBox(75.h)
                                  ],
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                    // hBox(75.h)
                  ],
                ),
              ),
            ),
          );
      }
    });
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
                selectedValue: restaurantHomeController.rating.value,
                hintStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                textStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                items: const ["High to Low", "Low to high"],
                onChanged: (val) {
                  if (val != null && val.isNotEmpty) {
                    restaurantHomeController.rating.value = val;
                    restaurantHomeController.getLatLong();
                    restaurantHomeController.homeApiForFilter();
                    pt(val);
                  }
                },
                cancelTap: () {
                  restaurantHomeController.rating.value = "";
                  restaurantHomeController.getLatLong();
                  restaurantHomeController.homeApiForFilter();
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
                selectedValue: restaurantHomeController.deliveryFee.value,
                hintStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                textStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                items: const ["Free"],
                onChanged: (val) {
                  if (val != null && val.isNotEmpty) {
                    restaurantHomeController.deliveryFee.value = val;
                    restaurantHomeController.getLatLong();
                    restaurantHomeController.homeApiForFilter();
                    pt(val);
                  }
                },
                cancelTap: () {
                  restaurantHomeController.deliveryFee.value = "";
                  restaurantHomeController.getLatLong();
                  restaurantHomeController.homeApiForFilter();
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
                selectedValue: restaurantHomeController.openNow.value,
                hintStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                textStyle: AppFontStyle.text_15_400(AppColors.black,
                    family: AppFontFamily.gilroyMedium),
                items: const ["Open", "Closed"],
                onChanged: (val) {
                  if (val != null && val.isNotEmpty) {
                    restaurantHomeController.openNow.value = val;
                    restaurantHomeController.getLatLong();
                    restaurantHomeController.homeApiForFilter();
                    pt(val);
                  }
                },
                cancelTap: () {
                  restaurantHomeController.openNow.value = "";
                  restaurantHomeController.getLatLong();
                  restaurantHomeController.homeApiForFilter();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget serchAndFilter() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      // snap: false,
      // floating: false,
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
              Get.toNamed(AppRoutes.restaurantHomeFilter);
            },
            showfilterIcon: false,
            searchIocnPadding: REdgeInsets.all(8),
            searchIconHeight: 16.h,
            hintStyle: AppFontStyle.text_10_400(AppColors.hintText,family: AppFontFamily.gilroyRegular),
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

  final BannerDetailsController bannerDetailsController = Get.put(BannerDetailsController());

  Widget mainBanner() {
    return Column(
      children: [
        Obx(() {
          final banners = restaurantHomeController.homeData.value.banners;
          return CarouselSlider.builder(
            itemCount: banners!.length,
            options: CarouselOptions(
              height: 150.h,
              autoPlay:
                  restaurantHomeController.homeData.value.banners!.length > 1
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
                  Get.to(RestaurantHomeBanner(
                    bannerID: banners[index].id.toString(),
                  ));
                  bannerDetailsController.bannerDataApi(
                      bannerId: banners[index].id.toString());
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
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Row(
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
                      restaurantNavbarController.getIndex(1);
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
              hBox(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.restaurantCategoriesDetails,
                              arguments: {
                                'name': restaurantHomeController
                                    .homeData.value.category![index].name
                                    .toString(),
                                'id': int.parse(restaurantHomeController
                                    .homeData.value.category![index].id
                                    .toString()),
                              });
                          restaurantCategoriesDetailsController.restaurant_Categories_Details_Api(
                            id: restaurantHomeController.homeData.value.category![index].id.toString(),
                          );
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: CachedNetworkImage(
                              imageUrl: restaurantHomeController
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
                        restaurantHomeController.homeData.value.category![index].name.toString(),
                        style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
        hBox(20.h),
      ],
    );
  }

  // Widget catergories() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 24.h),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //               "Categories",
  //               style: AppFontStyle.text_24_600(AppColors.darkText),
  //             ),
  //             const Spacer(),
  //             InkWell(
  //               splashColor: Colors.transparent,
  //               highlightColor: Colors.transparent,
  //               onTap: () {
  //                 restaurantNavbarController.getIndex(1);
  //               },
  //               child: Row(
  //                 children: [
  //                   Text(
  //                     "See All",
  //                     style: AppFontStyle.text_14_600(AppColors.primary),
  //                   ),
  //                   wBox(4),
  //                   Icon(
  //                     Icons.arrow_forward_sharp,
  //                     color: AppColors.primary,
  //                     size: 18,
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //         hBox(20),
  //         SizedBox(
  //           height: 110.h,
  //           child: ListView.separated(
  //             scrollDirection: Axis.horizontal,
  //             shrinkWrap: true,
  //             // itemCount:
  //             //     restaurantHomeController.homeData.value.category?.length ?? 0,
  //             itemCount: 4,
  //             itemBuilder: (context, index) {
  //               return Column(
  //                 children: [
  //                   GestureDetector(
  //                     onTap: () {
  //                       Get.toNamed(AppRoutes.restaurantCategoriesDetails,
  //                           arguments: {
  //                             'name': restaurantHomeController
  //                                 .homeData.value.category![index].name
  //                                 .toString(),
  //                             'id': int.parse(restaurantHomeController
  //                                 .homeData.value.category![index].id
  //                                 .toString()),
  //                           });
  //                       restaurantCategoriesDeatilsController
  //                           .restaurant_Categories_Details_Api(
  //                         id: restaurantHomeController
  //                             .homeData.value.category![index].id
  //                             .toString(),
  //                       );
  //                     },
  //                     child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(50.r),
  //                         child: CachedNetworkImage(
  //                           imageUrl: restaurantHomeController
  //                               .homeData.value.category![index].imageUrl
  //                               .toString(),
  //                           fit: BoxFit.cover,
  //                           height: 60.h,
  //                           width: 60.h,
  //                           errorWidget: (context, url, error) =>
  //                               const Icon(Icons.error),
  //                           placeholder: (context, url) => Shimmer.fromColors(
  //                             baseColor: AppColors.gray,
  //                             highlightColor: AppColors.lightText,
  //                             child: Container(
  //                               decoration: BoxDecoration(
  //                                 color: AppColors.gray,
  //                                 borderRadius: BorderRadius.circular(100),
  //                               ),
  //                             ),
  //                           ),
  //                         )),
  //                   ),
  //                   hBox(15),
  //                   Text(
  //                     restaurantHomeController
  //                         .homeData.value.category![index].name
  //                         .toString(),
  //                     style: AppFontStyle.text_16_400(AppColors.darkText),
  //                   ),
  //                 ],
  //               ).marginOnly(right: 0.w);
  //             },
  //             separatorBuilder: (BuildContext context, int index) {
  //               return wBox(20);
  //             },
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget mostPopularRestaurant() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                "Most Popular Restaurant",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(()=>All_Restaurant());
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
          height: 315.h,
          child: GetBuilder<RestaurantHomeController>(
            init: restaurantHomeController,
            builder: (controller) {
              return Obx(() {
                final restaurants = restaurantHomeController.homeData.value.popularResto;
                // final restaurants = restaurantHomeController.popularRestaurantList;
                return ListView.separated(
                  padding: REdgeInsets.only(left:22,right: 20),
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // controller: _horizontalScrollControllerPopularRes,
                  scrollDirection: Axis.horizontal,
                  // itemCount: restaurants.length,
                  itemCount: restaurantHomeController.homeData.value.popularResto?.length ?? 0,
                      // + (restaurantHomeController.isLoadingPopular.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    // if (index == restaurantHomeController.popularRestaurantList.length) {
                    //   return Container(
                    //     width: Get.width*0.78,
                    //     margin: const EdgeInsets.only(bottom: 102),
                    //   child: const ShimmerWidget(isRestaurantCard: true),);
                    // }
                    final restaurant = restaurants?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(RestaurantDetailsScreen(
                          Restaurantid: restaurants?[index].id.toString() ?? "",
                        ));
                        restaurantDetailsController.restaurant_Details_Api(
                          id: restaurants?[index].id.toString() ?? "",
                        );
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width*0.78,
                          child: restaurantHomeController.isLoadingFilter.value == true ?
                          const ShimmerWidgetHomeScreen() :
                          popularRestaurantList(
                            index: index,
                            image: restaurant?.shopimage,
                            title: restaurant?.shopName?.capitalize!,
                            rating: restaurant?.rating,
                            price: restaurant?.avgPrice,
                            // image: restaurant?.shopImageUrl,
                            // title: restaurant.shopName?.capitalize!,
                            // rating: restaurant.rating,
                            // price: restaurant.avgPrice,
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
      ],
    );
  }

  Widget popularRestaurantList({index, String? image, title, type, isFavourite, rating, price,bool? isFreeDelivery}) {
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
                height: 210/*220*/.h,
                placeholder: (context, url) =>const ShimmerWidget(),
                // placeholder: (context, url) => Shimmer.fromColors(
                //   baseColor: AppColors.gray,
                //   highlightColor: AppColors.lightText,
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: AppColors.gray,
                //       borderRadius: BorderRadius.circular(20.r),
                //     ),
                //   ),
                // ),
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
              "Pizza, Burger, Cake",
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

  Widget nearByRestaurant() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(22.h),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                "Nearby Restaurants",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(All_Restaurant());
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
          height: 315.h,
          child: GetBuilder<RestaurantHomeController>(
            init: restaurantHomeController,
            builder: (controller) {
              return Obx(() {
                final restaurants = restaurantHomeController.homeData.value.nearbyResto;
                return ListView.separated(
                  padding: REdgeInsets.only(left:22,right: 20),
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // controller: _horScrollControllerNearByRes,
                  scrollDirection: Axis.horizontal,
                  // itemCount: restaurants.length,
                  itemCount: restaurantHomeController.homeData.value.nearbyResto?.length ?? 0,
                  // restaurantHomeController.nearByRestaurantList.length + (restaurantHomeController.isLoadingNearby.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    // if (index == restaurantHomeController.nearByRestaurantList.length) {
                    //   return Container(
                    //     width: Get.width*0.78,
                    //     margin: const EdgeInsets.only(bottom: 102),
                    //     child: const ShimmerWidget(),);
                    // }
                    final restaurant = restaurants?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(RestaurantDetailsScreen(
                          Restaurantid: restaurants?[index].id.toString() ?? "",
                        ));
                        restaurantDetailsController.restaurant_Details_Api(
                          id: restaurants?[index].id.toString() ?? "",
                        );
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width*0.78,
                          child: restaurantHomeController.isLoadingFilter.value == true ?
                          const ShimmerWidgetHomeScreen() : popularRestaurantList(
                            index: index,
                            image: restaurant?.shopimage,
                            title: restaurant?.shopName?.capitalize!,
                            rating: restaurant?.rating,
                            price: restaurant?.avgPrice,
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
      ],
    );
  }

  Widget allRestaurant() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(15.h),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                "All Restaurants",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(()=>All_Restaurant());
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
          height: 315.h,
          child: GetBuilder<RestaurantHomeController>(
            init: restaurantHomeController,
            builder: (controller) {
              return Obx(() {
                final restaurants = restaurantHomeController.homeData.value.restaurants;
                return ListView.separated(
                  padding: REdgeInsets.only(left:22,right: 20),
                  // physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // controller: _horScrollControllerAllRestaurant,
                  scrollDirection: Axis.horizontal,
                  // itemCount: restaurants.length,
                  itemCount: restaurantHomeController.homeData.value.restaurants?.length ?? 0,
                      // .restaurantList.length + (restaurantHomeController.isLoadingRestaurant.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    // if (index == restaurantHomeController.restaurantList.length) {
                    //   return Container(
                    //     width: Get.width*0.78,
                    //     margin: const EdgeInsets.only(bottom: 102),
                    //     child: const ShimmerWidget(isRestaurantCard: true,),);
                    // }
                    final restaurant = restaurants?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(RestaurantDetailsScreen(
                          Restaurantid: restaurants?[index].id.toString() ?? "",
                        ));
                        restaurantDetailsController.restaurant_Details_Api(
                          id: restaurants?[index].id.toString() ?? "",
                        );
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width*0.78,
                          child: restaurantHomeController.isLoadingFilter.value == true ?
                          const ShimmerWidgetHomeScreen() : popularRestaurantList(
                            index: index,
                            image: restaurant?.shopimage ,
                            title: restaurant?.shopName?.capitalize!,
                            rating: restaurant?.rating,
                            price: restaurant?.avgPrice,
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
      ],
    );
  }

  // Free Delivery Restaurant

  Widget freeDeliveryRestaurant() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(10.h),
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Text(
                "Free Delivery",
                style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(()=>All_Restaurant());
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
          height: 315.h,
          child: GetBuilder<RestaurantHomeController>(
            init: restaurantHomeController,
            builder: (controller) {
              return Obx(() {
                final restaurants = restaurantHomeController.homeData.value.freedelResto;
                return ListView.separated(
                  padding: REdgeInsets.only(left:22,right: 20),
                  // physics: caonst NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  // controller: _horScrollControllerFreeDeliveryRes,
                  scrollDirection: Axis.horizontal,
                  // itemCount: restaurants.length,
                  itemCount: restaurantHomeController.homeData.value.freedelResto?.length ?? 0,
                      // +(restaurantHomeController.isLoadingFree.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    // if (index == restaurantHomeController.freeDeliveryRestaurantList.length) {
                    //   return Container(
                    //     width: Get.width*0.78,
                    //     margin: const EdgeInsets.only(bottom: 102),
                    //   child: const ShimmerWidget(isRestaurantCard: true,),);
                    // }
                    final restaurant = restaurants?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(RestaurantDetailsScreen(
                          Restaurantid: restaurants?[index].id.toString() ?? "",
                        ));
                        restaurantDetailsController.restaurant_Details_Api(
                          id: restaurants?[index].id.toString() ?? "",
                        );
                      },
                      child: Obx(
                        ()=> SizedBox(
                          width: Get.width*0.78,
                          child: restaurantHomeController.isLoadingFilter.value == true ?
                          const ShimmerWidgetHomeScreen() : freeDeliveryRestaurantList(
                            index: index,
                            image: restaurant?.shopimage,
                            title: restaurant?.shopName?.capitalize!,
                            rating: restaurant?.rating,
                            price: restaurant?.avgPrice,
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
      ],
    );
  }

  Widget freeDeliveryRestaurantList({index, String? image, title, type, isFavourite, rating, price}) {
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
                height: 210.h,
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
}
