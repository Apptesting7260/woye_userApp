import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/Sub_screens/Categories_details/controller/GroceryCategoriesDetailsController.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/GroceryDetailsController.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Vendor_details/grocery_vendor_details_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/banners/grocery_banner_details_controller.dart';
import 'package:woye_user/shared/widgets/custom_banner_grocery.dart';

class GroceryHomeBanner extends StatelessWidget {
  final String bannerID;

  GroceryHomeBanner({super.key, required this.bannerID});

  final GroceryBannerDetailsController controller =
      Get.put(GroceryBannerDetailsController());

  final Grocerycategoriesdetailscontroller
  grocerycategoriesdetailscontroller =
  Get.put(Grocerycategoriesdetailscontroller());

  final GroceryDetailsController groceryDetailsController =
  Get.put(GroceryDetailsController());

  @override
  Widget build(BuildContext context) {
    return RestaurantBaseScaffold(
      child: Scaffold(
          appBar: const CustomAppBar(
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
                if (controller.error.value == 'No internet' || controller.error.value == "InternetExceptionWidget") {
                  return InternetExceptionWidget(
                    onPress: () {
                      controller.bannerDataApi(bannerId: bannerID);
                    },
                  );
                } else {
                  return GeneralExceptionWidget(
                    onPress: () {
                      controller.bannerDataApi(bannerId: bannerID);
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
                                .bannerData.value.groceryShops!.isNotEmpty)
                              shops(),
                            hBox(80.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
            }
          })),
    );
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
              height: 150.h,
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
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.onestRegular),
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
                Get.toNamed(AppRoutes.groceryCategoryDetails, arguments: {
                  'name': banners[index].name.toString(),
                  'id': int.parse(banners[index].id.toString()),
                });
                grocerycategoriesdetailscontroller
                    .groceryCategoriesDetailsApi(
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
                    style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestMedium),
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
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.onestRegular),
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
                bannerId: bannerID.toString(),
                image: controller.bannerData.value.products![index].urlImage.toString(),
                sale_price: controller.bannerData.value.products![index].salePrice.toString(),
                regular_price: controller.bannerData.value.products![index].regularPrice.toString(),
                title: controller.bannerData.value.products![index].title.toString(),
                quantity: controller.bannerData.value.products![index].packagingValue.toString(),
                categoryId: controller.bannerData.value.products![index].categoryId.toString(),
                product_id:controller.bannerData.value.products![index].id.toString(),
                shop_name: controller.bannerData.value.products![index].shopName.toString(),
                is_in_wishlist:controller.bannerData.value.products![index].isInWishlist,
                isLoading:controller.bannerData.value.products![index].isLoading,
                categoryName: controller.bannerData.value.products![index].categoryName.toString(),
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
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
        hBox(5.h),
        GetBuilder<GroceryBannerDetailsController>(
          init: controller,
          builder: (controller) {
            return Obx(() {
              return ListView.separated(
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.bannerData.value.groceryShops?.length ?? 0,
                itemBuilder: (context, index) {
                  final pharmaShopdata = controller.bannerData.value.groceryShops![index];
                  return GestureDetector(
                    onTap: () {
                      groceryDetailsController.restaurant_Details_Api(
                        id: pharmaShopdata.id.toString(),
                      );
                      Get.to(GroceryVendorDetailsScreen(
                          groceryId: pharmaShopdata.id.toString()));
                    },
                    child: pharmaShop(
                      index: index,
                      image: pharmaShopdata.shopimage,
                      title: pharmaShopdata.shopName,
                      rating: pharmaShopdata.rating,
                      price: pharmaShopdata.avgPrice,
                    ),
                  );
                },
                separatorBuilder: (context, index) => hBox(12.h),
              );
            });
          },
        ),
      ],
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
          style: AppFontStyle.text_18_400(AppColors.darkText,family: AppFontFamily.onestMedium),
        ),
        // hBox(10),
        Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              price,
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_600(AppColors.primary,family: AppFontFamily.onestRegular),
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
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.onestRegular),
            ),
          ],
        ),

      ],
    );
  }
}
