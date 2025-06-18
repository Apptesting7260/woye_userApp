import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/search/controller/homeserchcontroller.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/custom_no_data_found.dart';

class RestaurantHomeFilter extends StatelessWidget {
  RestaurantHomeFilter({super.key});

  final RestaurantHomeSearchController controller = Get.put(RestaurantHomeSearchController());
  final specific_Product_Controller specificProductController = Get.put(specific_Product_Controller());
  final RestaurantDetailsController restaurantDeatilsController = Get.put(RestaurantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Filter",
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24.0),
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              autofocus: true,
              onChanged: (value) {
                if (controller.stopLottie.value != true) {
                  controller.showLottie.value = true;
                }
                if (value.length >= 2) {
                  controller.restaurantHomeSearchApi(search: value.trim());
                }
              },
              controller: controller.homeSearchController,
            ),
            Obx(() {
              if (controller.showLottie.value == true) {
                return SliverToBoxAdapter(
                    child: Lottie.asset(
                        'assets/lottieJson/Animation - 1734688929473.json'));
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            }),
            Obx(() {
              if (controller.stopLottie.value == true &&
                  controller.searchData.value.restaurants!.isEmpty &&
                  controller.searchData.value.products!.isEmpty) {
                return SliverToBoxAdapter(
                  child: CustomNoDataFound(heightBox: hBox(Get.height*.08.h),),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            }),
            Obx(() {
              if (controller.searchData.value.restaurants!.isNotEmpty) {
                return SliverToBoxAdapter(child: restaurant());
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            }),
            Obx(() {
              if (controller.searchData.value.products!.isNotEmpty) {
                return SliverToBoxAdapter(child: products());
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget restaurant() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Restaurant",
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(10.h),
        SizedBox(
          height: Get.height / 3.6,
          child: GetBuilder<RestaurantHomeSearchController>(
            init: controller,
            builder: (controller) {
              return Obx(() {
                final restaurants = controller.searchData.value.restaurants;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: restaurants?.length ?? 0,
                  itemBuilder: (context, index) {
                    final restaurant = restaurants?[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(RestaurantDetailsScreen(
                          Restaurantid: restaurant!.id.toString(),
                        ));
                        restaurantDeatilsController.restaurant_Details_Api(
                          id: restaurant.id.toString(),
                        );
                      },
                      child: restaurantList(
                        index: index,
                        image: restaurant?.shopimage,
                        title: restaurant?.shopName.toString().capitalize.toString(),
                        rating: restaurant?.rating,
                        price: restaurant?.avgPrice,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => wBox(20),
                );
              });
            },
          ),
        ),
      ],
    );
  }

  Widget products() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(5.h),
        Text(
          "Products",
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(10.h),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.searchData.value.products?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.w,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Get.to(ProductDetailsScreen(
                      productId: controller.searchData.value.products![index].id
                          .toString(),
                      categoryId: controller
                          .searchData.value.products![index].categoryId
                          .toString(),
                      categoryName: controller
                          .searchData.value.products![index].categoryName
                          .toString(),
                    ));

                    specificProductController.specific_Product_Api(
                        productId: controller
                            .searchData.value.products![index].id
                            .toString(),
                        categoryId: controller
                            .searchData.value.products![index].categoryId
                            .toString());
                  },
                  child: CustomItemBanner(
                    index: index,
                    product_id: controller.searchData.value.products?[index].id
                        .toString(),
                    categoryId: controller
                        .searchData.value.products?[index].categoryId
                        .toString(),
                    image: controller.searchData.value.products?[index].urlImage
                        .toString(),
                    title: controller.searchData.value.products?[index].title
                        .toString(),
                    // rating: controller.searchData.value.products?[index].rating
                    //     .toString(),
                    is_in_wishlist: controller
                        .searchData.value.products?[index].isInWishlist,
                    isLoading:
                        controller.searchData.value.products?[index].isLoading,
                    sale_price: controller
                        .searchData.value.products?[index].salePrice
                        .toString(),
                    regular_price: controller
                        .searchData.value.products?[index].regularPrice
                        .toString(),
                    resto_name: controller
                        .searchData.value.products?[index].restoName
                        .toString(),
                  ));
            }),
        hBox(20.h),
      ],
    );
  }

  Widget restaurantList(
      {index, String? image, title, type, isFavourite, rating, price}) {
    return Container(
      width: Get.width / 1.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              // Container(
              //   clipBehavior: Clip.antiAlias,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20.r),
              //   ),
              //   child: CachedNetworkImage(
              //     imageUrl: image.toString(),
              //     // height: 220.h,
              //     height: 150.h,
              //     width: 70.w,
              //     placeholder: (context, url) => Shimmer.fromColors(
              //       baseColor: AppColors.gray,
              //       highlightColor: AppColors.lightText,
              //       child: Container(
              //         decoration: BoxDecoration(
              //           color: AppColors.gray,
              //           borderRadius: BorderRadius.circular(20.r),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: image.toString(),
                    fit: BoxFit.cover,
                    height: 160.h,
                    width: Get.width / 1.6,
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: AppColors.gray,
                      highlightColor: AppColors.gray,
                      child: Container(
                        height: 160.h,
                        width: Get.width / 1.6,
                        decoration: BoxDecoration(
                          color: AppColors.gray,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
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
            style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
          ),
          // hBox(10),
          Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                textAlign: TextAlign.left,
                style: AppFontStyle.text_15_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
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
                style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
              ),
            ],
          )
        ],
      ),
    );
  }
}
