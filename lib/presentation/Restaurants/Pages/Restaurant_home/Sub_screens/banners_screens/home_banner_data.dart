import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/banners_screens/banner_details_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/search/controller/homeserchcontroller.dart';

class RestaurantHomeBanner extends StatelessWidget {
  final String bannerID;

  RestaurantHomeBanner({super.key, required this.bannerID});

  final BannerDetailsController controller = Get.put(BannerDetailsController());

  final specific_Product_Controller specificProductController =
      Get.put(specific_Product_Controller());
  final RestaurantDetailsController restaurantDeatilsController =
      Get.put(RestaurantDetailsController());

  final RestaurantCategoriesDetailsController
      restaurantCategoriesDeatilsController =
      Get.put(RestaurantCategoriesDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            // title: Text(
            //   "Filter",
            //   style: AppFontStyle.text_22_600(AppColors.darkText),
            // ),
            ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: circularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet') {
                return InternetExceptionWidget(
                  onPress: () {
                    // controller.restaurant_Details_Api(id: Restaurantid);
                  },
                );
              } else {
                return GeneralExceptionWidget(
                  onPress: () {
                    // controller.restaurant_Details_Api(id: Restaurantid);
                  },
                );
              }
            case Status.COMPLETED:
              return Scaffold(
                body: RefreshIndicator(
                  onRefresh: () async {
                    controller.bannerDataApi(bannerId: bannerID);
                  },
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 24.h),
                      child: Column(
                        children: [
                          bannerView(),
                          hBox(10.h),
                          if (controller.bannerData.value.category!.isNotEmpty)
                            categories(),
                          if (controller.bannerData.value.products!.isNotEmpty)
                            products(),
                          if (controller
                              .bannerData.value.restaurants!.isNotEmpty)
                            restaurant(),
                          hBox(10.h),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          }
        }));
  }

  Widget bannerView() {
    final banners = controller.bannerData.value.currentBanner;
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: CachedNetworkImage(
          imageUrl: banners!.imageUrl.toString(),
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
  }

  Widget categories() {
    final banners = controller.bannerData.value.category;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
        hBox(20.h),
        GridView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: banners!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.restaurantCategoriesDetails, arguments: {
                  'name': banners[index].name.toString(),
                  'id': int.parse(banners[index].id.toString()),
                });
                restaurantCategoriesDeatilsController
                    .restaurant_Categories_Details_Api(
                  id: banners[index].id.toString(),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: CachedNetworkImage(
                      imageUrl: banners[index].imageUrl.toString(),
                      fit: BoxFit.cover,
                      height: 100.h,
                      width: 100.h,
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
                    ),
                  ),
                  hBox(15),
                  Text(
                    banners[index].name.toString(),
                    style: AppFontStyle.text_16_400(AppColors.darkText),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget products() {
    final products = controller.bannerData.value.products;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Products",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
        hBox(10.h),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.h,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Get.to(ProductDetailsScreen(
                      productId: products![index].id.toString(),
                      categoryId: products[index].categoryId.toString(),
                      categoryName: products[index].categoryName.toString(),
                    ));

                    specificProductController.specific_Product_Api(
                        productId: products[index].id.toString(),
                        categoryId: products[index].categoryId.toString());
                  },
                  child: CustomItemBanner(
                    index: index,
                    product_id: products?[index].id.toString(),
                    categoryId: products?[index].categoryId.toString(),
                    image: products?[index].urlImage.toString(),
                    title: products?[index].title.toString(),
                    rating: products?[index].rating.toString(),
                    is_in_wishlist: products?[index].isInWishlist,
                    isLoading: products?[index].isLoading,
                    sale_price: products?[index].salePrice.toString(),
                    regular_price: products?[index].regularPrice.toString(),
                    resto_name: products?[index].restoName.toString(),
                  ));
            }),
        hBox(20.h),
      ],
    );
  }

  Widget restaurant() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Restaurant",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
        hBox(5.h),
        GetBuilder<BannerDetailsController>(
          init: controller,
          builder: (controller) {
            return Obx(() {
              final restaurants = controller.bannerData.value.restaurants;
              return ListView.separated(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
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
                      title: restaurant?.shopName,
                      rating: restaurant?.rating,
                      price: restaurant?.avgPrice,
                    ),
                  );
                },
                separatorBuilder: (context, index) => hBox(10.h),
              );
            });
          },
        ),
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
                // height: 150.h,
                // width: 70.w,
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
            // Container(
            //   clipBehavior: Clip.antiAlias,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20.r),
            //   ),
            //   child: Center(
            //     child: CachedNetworkImage(
            //       imageUrl: image.toString(),
            //       fit: BoxFit.cover,
            //       height: 160.h,
            //       errorWidget: (context, url, error) => const Icon(Icons.error),
            //       placeholder: (context, url) => Shimmer.fromColors(
            //         baseColor: AppColors.gray,
            //         highlightColor: AppColors.lightText,
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: AppColors.gray,
            //             borderRadius: BorderRadius.circular(20.r),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
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
