import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/common/discover/discover_controller.dart';
import 'package:woye_user/shared/theme/colors.dart';
import 'package:woye_user/shared/theme/font_style.dart';
import 'package:woye_user/shared/widgets/custom_app_bar.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';

import '../../../Core/Utils/app_export.dart';
import '../../../shared/widgets/shimmer.dart';
import '../../Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import '../../Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';

class DiscoverScreen extends StatefulWidget{
  final bool isBack;
  const DiscoverScreen({super.key,  this.isBack = false});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  GlobalKey homeWidgetKey = GlobalKey();
  double? height;
  final DiscoverRestaurentController restaurantDiscoverController =
  Get.put(DiscoverRestaurentController());
  final TextEditingController _searchController = TextEditingController();

  final RestaurantDetailsController restaurantDetailsController =
  Get.put(RestaurantDetailsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          isLeading: widget.isBack,
          title: Text(
            "Discover",
            style: AppFontStyle.text_24_600(AppColors.darkText,family: AppFontFamily.onestMedium),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            // Add refresh logic here
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar with Filter
                  Container(
                    margin: REdgeInsets.only(top: 5, bottom: 24),
                    child: Row(
                      children: [
                        // Search Bar
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: AppColors.lightText.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: REdgeInsets.only(left: 16, right: 12),
                                  child: Icon(
                                    Icons.search,
                                    color: AppColors.lightText.withOpacity(0.5),
                                    size: 24,
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: _searchController,
                                    decoration: InputDecoration(
                                      hintText: "Search",
                                      hintStyle: AppFontStyle.text_14_400(
                                        AppColors.lightText.withOpacity(0.5),
                                        family: AppFontFamily.onestMedium,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding: REdgeInsets.only(top: 16, bottom: 16),
                                    ),
                                    style: AppFontStyle.text_14_400(
                                      AppColors.darkText,
                                      family: AppFontFamily.onestRegular,
                                    ),
                                    onChanged: (value) {
                                      // Add search logic here
                                    },
                                  ),
                                ),
                                if (_searchController.text.isNotEmpty)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _searchController.clear();
                                      });
                                    },
                                    child: Padding(
                                      padding: REdgeInsets.only(right: 16),
                                      child: Icon(
                                        Icons.clear,
                                        color: AppColors.darkText.withOpacity(0.5),
                                        size: 18,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // Filter Button
                        const SizedBox(width: 12),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          child: Container(
                            height: 50,
                            padding: REdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: AppColors.lightText.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: Image.asset(
                                    "assets/images/filter.png",
                                    height: 20.h,
                                  ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // Categories Section
                  const SizedBox(height: 5),
                  // Categories Horizontal Scroll
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryChip("All", isSelected: true),
                        const SizedBox(width: 8),
                        _buildCategoryChip("Starters", isSelected: false),
                        const SizedBox(width: 8),
                        _buildCategoryChip("Soups"),
                        const SizedBox(width: 8),
                        _buildCategoryChip("Main Dishes"),
                        const SizedBox(width: 8),
                        _buildCategoryChip("Sides"),
                        const SizedBox(width: 8),
                        _buildCategoryChip("Desserts"),
                        const SizedBox(width: 8),
                        _buildCategoryChip("Drinks"),
                      ],
                    ),
                  ),

                  // Most Popular Section
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Most Popular",
                        style: AppFontStyle.text_18_600(
                          AppColors.darkText,
                          family: AppFontFamily.onestRegular,
                        ),
                      ),
                    ],
                  ),
                  // Add your recipes list here
                  const SizedBox(height: 10),
                  mostPopularRestaurant(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Free Delivery",
                        style: AppFontStyle.text_18_600(
                          AppColors.darkText,
                          family: AppFontFamily.onestRegular,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'See All',
                            style:  AppFontStyle.text_12_600(
                              AppColors.primary,
                              family: AppFontFamily.onestRegular,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            size: 15,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // freeDeliveryList(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Promotion",
                        style: AppFontStyle.text_18_600(
                          AppColors.darkText,
                          family: AppFontFamily.onestRegular,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'See All',
                            style:  AppFontStyle.text_12_600(
                              AppColors.primary,
                              family: AppFontFamily.onestRegular,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            size: 15,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  promotionData(),
                  const SizedBox(height: 10),
                  Text(
                    "Fast Delivery",
                    style: AppFontStyle.text_18_600(
                      AppColors.darkText,
                      family: AppFontFamily.onestRegular,
                    ),
                  ),
                  const SizedBox(height: 10),
                  fastDeliveryData(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Our Recommendation",
                        style: AppFontStyle.text_18_600(
                          AppColors.darkText,
                          family: AppFontFamily.onestRegular,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'See All',
                            style:  AppFontStyle.text_12_600(
                              AppColors.primary,
                              family: AppFontFamily.onestRegular,
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            size: 15,
                            color: AppColors.primary,
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String text, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        // Add category selection logic here
      },
      child: Container(
        padding: REdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.black : AppColors.lightText.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.black : AppColors.lightText.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Text(
          text,
          style: AppFontStyle.text_16_500(
            isSelected ? Colors.white : AppColors.darkText,
            family: AppFontFamily.onestMedium,
          ),
        ),
      ),
    );
  }

  Widget mostPopularRestaurant() {
  return Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
  Padding(
  padding: REdgeInsets.symmetric(horizontal: 24),
  ),
  hBox(15.h),
  SizedBox(
  height: 315.h,
  child: GetBuilder<DiscoverRestaurentController>(
  init: restaurantDiscoverController,
  builder: (controller) {
  return Obx(() {
  final restaurants = restaurantDiscoverController.homeData.value.popularResto;
  return ListView.separated(
  padding: REdgeInsets.only(left: 22, right: 20),
  shrinkWrap: true,
  scrollDirection: Axis.horizontal,
  itemCount: restaurantDiscoverController
      .homeData.value.popularResto?.length ?? 0,
  itemBuilder: (context, index) {
  final restaurant = restaurants?[index];
  return GestureDetector(
  onTap: () {
  Get.to(RestaurantBaseScaffold(
  child: RestaurantDetailsScreen(
  Restaurantid: restaurants?[index].id.toString() ?? "",
  ),
  ));
  restaurantDetailsController.restaurant_Details_Api(
  id: restaurants?[index].id.toString() ?? "",
  );
  },
  child: Obx(
  () => SizedBox(
  width: Get.width * 0.78,
  child: restaurantDiscoverController
      .isLoadingFilter.value ==
  true
  ? const ShimmerWidgetHomeScreen()
      : popularRestaurantList(
  index: index,
  image: restaurant?.shopimage,
  title: restaurant?.shopName?.capitalize!,
  rating: restaurant?.rating,
  price: restaurant?.avgPrice,
  catIndex:
  restaurant?.categoryNames?.length ?? 0,
  catName: restaurant?.categoryNames
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

  Widget popularRestaurantList(
      {index,
        String? image,
        title,
        type,
        isFavourite,
        rating,
        price,
        bool? isFreeDelivery,
        catIndex,
        List<String>? catName}) {
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
                height: 210 /*220*/ .h,
                placeholder: (context, url) => const ShimmerWidget(),
                errorWidget: (context, url, error) => Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textFieldBorder),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(Icons.broken_image_rounded,
                        color: AppColors.textFieldBorder)),
              ),
            ),
          ],
        ),
        hBox(10.h),
        Row(
          children: [
            Text(
              'Pizza',
              textAlign: TextAlign.left,
              style: AppFontStyle.text_17_400(AppColors.darkText,
                  family: AppFontFamily.onestSemiBold
              ),
              overflow: TextOverflow.ellipsis,
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
                "$rating/5",
                style: AppFontStyle.text_14_400(AppColors.darkText,
                    family: AppFontFamily.onestRegular),
              ),
            ),
          ],
        ),
        hBox(2.h),
        Row(
          children: [
            Text(
              "The Pizza hub and Restaurent",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_14_400(AppColors.primary,
                  family: AppFontFamily.onestRegular),
            )
          ],
        ),
        hBox(2.h),
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
                  price.toString(),
                  style: AppFontStyle.text_10_400(AppColors.black,
                      family: AppFontFamily.onestRegular
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset(
              ImageConstants.clockIcon,
              height: 15,
              colorFilter:
              ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
            ),
            wBox(3.w),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Text(
                "30-50 mins",
                style: AppFontStyle.text_15_400(AppColors.darkText,
                    family: AppFontFamily.onestRegular),
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
             'assets/svg/add_icon.svg',
              height: 40,
            )
          ],
        ),
      ],
    );
  }

  Widget freeDeliveryList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
        ),
        SizedBox(height: 15.h),
        GetBuilder<DiscoverRestaurentController>(
          init: restaurantDiscoverController,
          builder: (controller) {
            return Obx(() {
              final restaurants =
                  restaurantDiscoverController.homeData.value.popularResto;
              return GridView.builder(
                padding: REdgeInsets.only(left: 22, right: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.h,
                  crossAxisSpacing: 15.w,
                  mainAxisExtent: 260.h, // Fixed height for each grid item
                ),
                itemCount: restaurantDiscoverController
                    .homeData.value.popularResto?.length ??
                    0,
                itemBuilder: (context, index) {
                  final restaurant = restaurants?[index];
                  return _buildFreeDeliveryItem(
                    index: index,
                    image: restaurant?.shopimage,
                    title: restaurant?.shopName?.capitalize!,
                    rating: restaurant?.rating,
                    price: restaurant?.avgPrice,
                  );
                },
              );
            });
          },
        ),
      ],
    );
  }

  Widget _buildFreeDeliveryItem({
    index,
    String? image,
    title,
    rating,
    price,
    bool? isFreeDelivery,
    catIndex,
    List<String>? catName
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: AppColors.lightText.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Container with fixed height
          Container(
            height: 140.h,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            child: CachedNetworkImage(
              memCacheHeight: memCacheHeight,
              imageUrl: image.toString(),
              fit: BoxFit.cover,
              placeholder: (context, url) => const ShimmerWidget(),
              errorWidget: (context, url, error) =>
                  Container(
                    color: AppColors.textFieldBorder.withOpacity(0.1),
                    child: Icon(
                      Icons.broken_image_rounded,
                      color: AppColors.textFieldBorder,
                      size: 40,
                    ),
                  ),
            ),
          ),

          // Content Container with fixed padding and constraints
          Padding(
            padding: REdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title and Restaurant name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Pizza',
                          style: AppFontStyle.text_14_600(
                            AppColors.darkText,
                            family: AppFontFamily.onestSemiBold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svg/star-yellow.svg",
                              height: 12.h,
                            ),
                            wBox(4.w),
                            Text(
                              "${rating ?? "4.5"}/5",
                              style: AppFontStyle.text_10_400(
                                AppColors.darkText,
                                family: AppFontFamily.onestRegular,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    hBox(4.h),
                    Text(
                      "The Pizza Hub And...",
                      style: AppFontStyle.text_10_400(
                        AppColors.lightText,
                        family: AppFontFamily.onestRegular,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),

                // Price and Rating Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.lightText.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        price.toString(),
                        style: AppFontStyle.text_14_600(
                          AppColors.darkText,
                          family: AppFontFamily.onestSemiBold,
                        ),
                      ),
                    ),
                    // Price
                    Text(
                      '45 min',
                      style: AppFontStyle.text_14_600(
                        AppColors.darkText,
                        family: AppFontFamily.onestSemiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fastDeliveryData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
        ),
        hBox(15.h),
        SizedBox(
          height: 315.h,
          child: GetBuilder<DiscoverRestaurentController>(
            init: restaurantDiscoverController,
            builder: (controller) {
              return Obx(() {
                final restaurants =
                    restaurantDiscoverController.homeData.value.popularResto;
                return ListView.separated(
                  padding: REdgeInsets.only(left: 22, right: 20),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: restaurantDiscoverController
                      .homeData.value.popularResto?.length ??
                      0,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(RestaurantBaseScaffold(
                          child: RestaurantDetailsScreen(
                            Restaurantid: restaurants?[index].id.toString() ?? "",
                          ),
                        ));
                        restaurantDetailsController.restaurant_Details_Api(
                          id: restaurants?[index].id.toString() ?? "",
                        );
                      },
                      child: Obx(
                            () => SizedBox(
                          width: Get.width * 0.78,
                          child: restaurantDiscoverController
                              .isLoadingFilter.value ==
                              true
                              ? const ShimmerWidgetHomeScreen()
                              : popularRestaurantList(
                              index: index,
                              image: restaurant?.shopimage,
                              title: restaurant?.shopName?.capitalize!,
                              rating: restaurant?.rating,
                              price: restaurant?.avgPrice,
                              catIndex:
                              restaurant?.categoryNames?.length ?? 0,
                              catName: restaurant?.categoryNames
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => wBox(15.h),
                );
              });
            },
          ),
        ),
      ],
    );
  }

  Widget promotionData() {
    // Mock data for food items
    final List<Map<String, dynamic>> foodItems = [
      {
        'name': 'Onion Rings',
        'currentPrice': '\$56.00',
        'originalPrice': '\$64.00',
        'discount': '12% OFF',
        'rating': '4.5/5',
      },
      {
        'name': 'Spring Rolls',
        'currentPrice': '\$56.00',
        'originalPrice': '\$64.00',
        'discount': '12% OFF',
        'rating': '4.5/5',
      },
      {
        'name': 'Stuffed Bell Peppers',
        'currentPrice': '\$56.00',
        'originalPrice': '\$64.00',
        'discount': '12% OFF',
        'rating': '4.5/5',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            // Food Items List
            ListView.separated(
              padding: EdgeInsets.all(16.r),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foodItems.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final item = foodItems[index];
                return _buildFoodItem(
                  name: item['name'],
                  currentPrice: item['currentPrice'],
                  originalPrice: item['originalPrice'],
                  discount: item['discount'],
                  rating: item['rating'],
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFoodItem({
    required String name,
    required String currentPrice,
    required String originalPrice,
    required String discount,
    required String rating,
  }) {
    return Row(
      children: [
        // Food Image
        Container(
          width: 70.w,
          height: 70.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            image: const DecorationImage(
              image: AssetImage('assets/images/food_image.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.favorite_border,
                    size: 20.sp,
                    color: Colors.grey.shade400,
                  ),
                ],
              ),

              SizedBox(height: 4.h),

              // Price and Discount Row
              Row(
                children: [
                  // Current Price
                  Text(
                    currentPrice,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Original Price
                  Text(
                    originalPrice,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Discount Badge
                  Text(
                    discount,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF0000), // Red text
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 14.sp,
                        color: AppColors.goldStar, // Amber color
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        rating,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.goldStar,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: REdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'Order',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}