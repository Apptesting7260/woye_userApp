import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
  final RestaurantHomeController restaurantHomeController =
      Get.put(RestaurantHomeController());
  final RestaurantNavbarController restaurantNavbarController =
      Get.put(RestaurantNavbarController());

  _getHeight(_) {
    final keyContext = homeWidgetKey.currentContext;

    if (keyContext != null) height = keyContext.size!.height;
  }

  final RestaurantCategoriesDetailsController
      restaurantCategoriesDeatilsController =
      Get.put(RestaurantCategoriesDetailsController());

  final RestaurantDetailsController restaurantDeatilsController =
      Get.put(RestaurantDetailsController());

  final ScrollController _scrollController = ScrollController();
  final RestaurantCartController restaurantCartController =
      Get.put(RestaurantCartController());

  @override
  void initState() {
    super.initState();
    restaurantCartController.getRestaurantCartApi();
    WidgetsBinding.instance.addPostFrameCallback(_getHeight);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (restaurantHomeController.noLoading.value != true) {
          if (!restaurantHomeController.isLoading.value) {
            restaurantHomeController.isLoading.value = true;
            restaurantHomeController.currentPage++;
            print(
                "currentPage value ${restaurantHomeController.currentPage.value}");
            restaurantHomeController
                .homeApi(restaurantHomeController.currentPage.value);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (restaurantHomeController.rxRequestStatus.value) {
        case Status.LOADING:
          return Center(child: circularProgressIndicator());
        case Status.ERROR:
          if (restaurantHomeController.error.value == 'No internet') {
            return InternetExceptionWidget(
              onPress: () {
                restaurantHomeController.homeApiRefresh(1);
              },
            );
          } else {
            return GeneralExceptionWidget(
              onPress: () {
                restaurantHomeController.homeApiRefresh(1);
              },
            );
          }
        case Status.COMPLETED:
          return SafeArea(
            child: Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  restaurantHomeController.homeApiRefresh(1);
                },
                child: Column(
                  children: [
                    HomeScreen(
                      key: homeWidgetKey,
                    ),
                    Expanded(
                      child: CustomScrollView(
                        controller: _scrollController,
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
                                    // GestureDetector(
                                    //     onTap: (){
                                    //       FirebaseCrashlytics.instance.crash();
                                    //     },
                                    //     child: Text("gff")),
                                    if (restaurantHomeController
                                        .homeData.value.banners!.isNotEmpty)
                                      mainBanner(),
                                    if (restaurantHomeController
                                        .homeData.value.category!.isNotEmpty)
                                      catergories(),
                                    if (restaurantHomeController.homeData.value
                                        .restaurants!.data!.isNotEmpty)
                                      popularRestaurant(),
                                    hBox(100)
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
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

  final BannerDetailsController bannerDetailsController =
      Get.put(BannerDetailsController());

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
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Categories",
                    style: AppFontStyle.text_24_600(AppColors.darkText),
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
                          restaurantCategoriesDeatilsController
                              .restaurant_Categories_Details_Api(
                            id: restaurantHomeController
                                .homeData.value.category![index].id
                                .toString(),
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
                        restaurantHomeController
                            .homeData.value.category![index].name
                            .toString(),
                        style: AppFontStyle.text_14_400(AppColors.darkText),
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

  Widget popularRestaurant() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Popular Restaurant",
                style: AppFontStyle.text_24_600(AppColors.darkText),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(All_Restaurant());
                },
                child: Text(
                  "See All",
                  style: AppFontStyle.text_14_600(AppColors.primary),
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
          hBox(20),
          GetBuilder<RestaurantHomeController>(
            init: restaurantHomeController,
            builder: (controller) {
              return Obx(() {
                final restaurants = restaurantHomeController.restaurantList;
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(RestaurantDetailsScreen(
                          Restaurantid: restaurants[index].id.toString(),
                        ));
                        restaurantDeatilsController.restaurant_Details_Api(
                          id: restaurants[index].id.toString(),
                        );
                      },
                      child: restaurantList(
                        index: index,
                        image: restaurant.shopImageUrl,
                        title: restaurant.shopName?.capitalize!,
                        rating: restaurant.rating,
                        price: restaurant.avgPrice,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => hBox(20),
                );
              });
            },
          ),
          if (restaurantHomeController.isLoading.value)
            circularProgressIndicator(),
        ],
      ),
    );
  }

  Widget restaurantList(
      {index, String? image, title, type, isFavourite, rating, price}) {
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
          style: AppFontStyle.text_18_400(AppColors.darkText),
        ),
        // hBox(10),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              price,
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_600(AppColors.primary),
            ),
            Text(
              " • ",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_300(AppColors.lightText),
            ),
            SvgPicture.asset("assets/svg/star-yellow.svg"),
            wBox(4),
            Text(
              "$rating/5",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
          ],
        )
      ],
    );
  }
}
