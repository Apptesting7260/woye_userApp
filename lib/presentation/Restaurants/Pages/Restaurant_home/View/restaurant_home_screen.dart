import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/controller/restaurant_home_controller.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/All_Restaurant/view/all_restaurant.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import '../../../../../Data/components/GeneralException.dart';
import '../../../../../Data/components/InternetException.dart';
import '../../../../../shared/widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';

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

  @override
  void initState() {
    super.initState();
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
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                restaurantHomeController.homeApiRefresh(1);
                print(restaurantHomeController.homeData.value.userdata?.image
                    .toString());
              },
              child: Column(
                children: [
                  HomeScreen(
                    key: homeWidgetKey,
                    profileImage: restaurantHomeController
                        .homeData.value.userdata?.image
                        .toString(),
                  ),
                  Expanded(
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverPadding(
                          padding: REdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          sliver: serchAndFilter(),
                        ),
                        SliverPadding(
                            padding: REdgeInsets.symmetric(horizontal: 24),
                            sliver: SliverToBoxAdapter(
                              child: Column(
                                children: [
                                  mainBanner(),
                                  hBox(20),
                                  catergories(),
                                  hBox(20),
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
          );
      }
    });
  }

  Widget serchAndFilter() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      snap: true,
      floating: true,
      expandedHeight: 80.h,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      flexibleSpace: FlexibleSpaceBar(
        title: SizedBox(
          height: 34.h,
          child: (CustomSearchFilter(
            searchIocnPadding: REdgeInsets.all(8),
            searchIconHeight: 16.h,
            hintStyle: AppFontStyle.text_10_400(AppColors.hintText),
            textStyle: AppFontStyle.text_10_400(AppColors.darkText),
            prefixConstraints: BoxConstraints(
              maxHeight: 18.h,
            ),
            prefix: Padding(
              padding: REdgeInsets.only(left: 15, right: 5, bottom: 1),
              child: SvgPicture.asset(
                "assets/svg/search.svg",
                height: 12,
              ),
            ),
            padding: REdgeInsets.only(top: 10, bottom: 10),
            onFilterTap: () {
              Get.toNamed(AppRoutes.restaurantHomeFilter);
            },
          )),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget mainBanner() {
    return Container(
      // height: 150.h,
      decoration: BoxDecoration(
          color: const Color(0xffBB9A65).withOpacity(0.1),
          borderRadius: BorderRadius.circular(30.r)),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order from these restaurants and save.",
                    overflow: TextOverflow.visible,
                    style: AppFontStyle.text_18_600(AppColors.darkText),
                  ),
                  hBox(16),
                  CustomElevatedButton(
                    height: 40.h,
                    width: 100.w,
                    onPressed: () {},
                    child: Text(
                      "Buy now",
                      style: AppFontStyle.text_12_600(AppColors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Image.asset(
              "assets/images/burger.png",
              height: 160.h,
              // width: 100.w,
            ),
          )
        ],
      ),
    );
  }

  Widget catergories() {
    return Column(
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
                  )
                ],
              ),
            ),
          ],
        ),
        hBox(20),
        SizedBox(
          height: 110.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount:
                restaurantHomeController.homeData.value.category?.length ?? 0,
            itemBuilder: (context, index) {
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
              ).marginOnly(right: 30.w);
            },
            separatorBuilder: (BuildContext context, int index) {
              return wBox(20);
            },
          ),
        )
      ],
    );
  }

  Widget popularRestaurant() {
    return Column(
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
                        id: restaurants[index].id.toString(),
                      ));
                      restaurantDeatilsController.restaurant_Details_Api(
                        id: restaurants[index].id.toString(),
                      );
                    },
                    child: restaurantList(
                      index: index,
                      image: restaurant.shopImageUrl,
                      title: restaurant.shopName,
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
                imageUrl: image.toString(),
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
