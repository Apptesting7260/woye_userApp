import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Filter/groceryhomeserchcontroller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/GroceryDetailsController.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/grocery_vendor_details_screen.dart';
import 'package:woye_user/shared/widgets/custom_banner_grocery.dart';

class GroceryHomeFilter extends StatelessWidget {
  GroceryHomeFilter({super.key});

  final GroceryHomeSearchController controller =
      Get.put(GroceryHomeSearchController());

  final GroceryDetailsController groceryDetailsController =
      Get.put(GroceryDetailsController());

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
        padding: REdgeInsets.symmetric(horizontal: 24.h),
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              autofocus: true,
              onChanged: (value) {
                if (controller.stopLottie.value != true) {
                  controller.showLottie.value = true;
                }
                if (value.length >= 3) {
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
                  controller.searchData.value.pharmaShop!.isEmpty &&
                  controller.searchData.value.products!.isEmpty) {
                return SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // hBox(Get.height / 4),
                      Center(
                        child: SvgPicture.asset(
                          ImageConstants.noData,
                          height: 300.h,
                          width: 200.h,
                        ),
                      ),
                      Text(
                        "We couldn't find any results",
                        style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                      ),
                      hBox(5.h),
                      Text(
                        "Explore more and shortlist some items",
                        style: AppFontStyle.text_16_400(AppColors.mediumText,family: AppFontFamily.gilroyMedium),
                      ),
                    ],
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            }),
            Obx(() {
              if (controller.searchData.value.pharmaShop!.isNotEmpty) {
                return SliverToBoxAdapter(child: shops());
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

  Widget products() {
    final products = controller.searchData.value.products;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hBox(10.h),
        Text(
          "Products",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(10.h),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: products?.length ?? 0,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.w,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return CustomBannerGrocery(
                image: products![index].urlImage.toString(),
                sale_price: products[index].salePrice.toString(),
                regular_price: products[index].regularPrice.toString(),
                title: products[index].title.toString(),
                quantity: products[index].packagingValue.toString(),
                categoryId: products[index].categoryId.toString(),
                product_id: products[index].id.toString(),
                shop_name: products[index].shopName.toString(),
                is_in_wishlist: products[index].isInWishlist,
                isLoading: products[index].isLoading,
                categoryName: products[index].categoryName.toString(),
              );
            }),
        hBox(20.h),
      ],
    );
  }

  Widget shops() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Grocery Shops",
          style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
        hBox(5.h),
        SizedBox(
          height: Get.height / 3.6,
          child: GetBuilder<GroceryHomeSearchController>(
            init: controller,
            builder: (controller) {
              return Obx(() {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount:
                      controller.searchData.value.pharmaShop?.length ?? 0,
                  itemBuilder: (context, index) {
                    final pharmaShopdata =
                        controller.searchData.value.pharmaShop?[index];
                    return GestureDetector(
                      onTap: () {
                        groceryDetailsController.restaurant_Details_Api(
                          id: pharmaShopdata!.id.toString(),
                        );
                        Get.to(GroceryVendorDetailsScreen(
                          groceryId: pharmaShopdata.id.toString(),
                        ));
                      },
                      child: pharmaShop(
                        index: index,
                        image: pharmaShopdata?.shopimage,
                        title: pharmaShopdata?.shopName.toString().capitalize.toString(),
                        rating: pharmaShopdata?.rating,
                        price: pharmaShopdata?.avgPrice,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => wBox(18.w),
                );
              });
            },
          ),
        ),
      ],
    );
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
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: image.toString(),
                  fit: BoxFit.cover,
                  height: 160.h,
                  width: Get.width / 1.6,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: AppColors.gray,
                    highlightColor: AppColors.lightText,
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
        hBox(8.h),
        Text(
          title,
          textAlign: TextAlign.left,
          style: AppFontStyle.text_17_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
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
              style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            ),
            SvgPicture.asset("assets/svg/star-yellow.svg"),
            wBox(4),
            Text(
              "$rating/5",
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyRegular),
            ),
          ],
        )
      ],
    );
  }
}
