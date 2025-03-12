import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Grocery/Grocery_navbar/controller/grocery_navbar_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/controller/grocery_home_controller.dart';

class GroceryHomeScreen extends StatefulWidget {
   GroceryHomeScreen({super.key});



  @override
  State<GroceryHomeScreen> createState() => _GroceryHomeScreenState();
}



class _GroceryHomeScreenState extends State<GroceryHomeScreen> {
  final GroceryHomeController groceryHomeController =
  Get.put(GroceryHomeController());

  final GroceryNavbarController navbarController =
  Get.put(GroceryNavbarController());
  @override
  void initState() {
    super.initState();
    // homeController.getPharmacyCartApi();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (groceryHomeController.noLoading.value != true) {
          if (!groceryHomeController.isLoading.value) {
            groceryHomeController.isLoading.value = true;
            groceryHomeController.currentPage++;
            print(
                "currentPage value ${groceryHomeController.currentPage.value}");
            groceryHomeController
                .homeApi(groceryHomeController.currentPage.value);
          }
        }
      }
    });
  }
  final ScrollController _scrollController = ScrollController();

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
            },
            child: SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    HomeScreen(),
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
                                    if (groceryHomeController
                                        .homeData.value.banners!.isNotEmpty)
                                      mainBanner(),
                                    if (groceryHomeController
                                        .homeData.value.category!.isNotEmpty)
                                      catergories(),
                                    if (groceryHomeController.homeData.value
                                        .groceryShops!.data!.isNotEmpty)
                                      popularShop(),
                                    hBox(100.h)
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

  Widget mainBanner() {
    return Column(
      children: [
        Obx(() {
          final banners = groceryHomeController.homeData.value.banners;
          return CarouselSlider.builder(
            itemCount: banners!.length,
            options: CarouselOptions(
              height: 150.h,
              autoPlay:
              groceryHomeController.homeData.value.banners!.length > 1
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
                  // bannerDetailsController.bannerDataApi(
                  //     bannerId: banners[index].id.toString());
                  // Get.to(PharmacyHomeBanner(
                  //   bannerID: banners[index].id.toString(),
                  // ));
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
                      navbarController.getIndex(1);
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
              hBox(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return Column(
                    children: [
                      GestureDetector(
                        // onTap: () {
                        //   Get.toNamed(AppRoutes.pharmacyCategoryDetails,
                        //       arguments: {
                        //         'name': pharmacyHomeController
                        //             .homeData.value.category![index].name
                        //             .toString(),
                        //         'id': int.parse(pharmacyHomeController
                        //             .homeData.value.category![index].id
                        //             .toString()),
                        //       });
                        //   pharmacyCategoriesDetailsController
                        //       .pharmacy_Categories_Details_Api(
                        //     id: pharmacyHomeController
                        //         .homeData.value.category![index].id
                        //         .toString(),
                        //   );
                        // },
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
                        groceryHomeController
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
        hBox(20),
      ],
    );
  }

  Widget popularShop() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Popular Shops",
                style: AppFontStyle.text_24_600(AppColors.darkText),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  //Get.to(AllPharmaShopsScreen());
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
          GetBuilder<GroceryHomeController>(
            init: groceryHomeController,
            builder: (controller) {
              return Obx(() {
                final shops = groceryHomeController.shopsList;
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: shops.length,
                  itemBuilder: (context, index) {
                    final pharmashopsdata = shops[index];
                    return GestureDetector(
                      // onTap: () {
                      //   pharmacyDetailsController.restaurant_Details_Api(
                      //     id: pharmashopsdata.id.toString(),
                      //   );
                      //   Get.to(PharmacyVendorDetailsScreen(
                      //       pharmacyId: pharmashopsdata.id.toString()));
                      // },
                      child: pharmaShop(
                        index: index,
                        image: pharmashopsdata.shopimage,
                        title: pharmashopsdata.shopName,
                        rating: pharmashopsdata.rating,
                        price: pharmashopsdata.avgPrice,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => hBox(20.h),
                );
              });
            },
          ),
          if (groceryHomeController.isLoading.value)
            circularProgressIndicator(),
        ],
      ),
    );
  }

  Widget pharmaShop(
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
          title,
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
