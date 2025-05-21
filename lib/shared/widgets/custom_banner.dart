import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/controller/pharma_specific_product_controller.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Product_details/pharmacy_product_details_screen.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_wishlist/Controller/aad_product_wishlist_Controller/add_pharma_product_wishlist.dart';

import '../theme/font_family.dart';

class CustomBanner extends StatelessWidget {
  int index;
  final String? description;
  final String? quantity;
  final String? image;
  final Color? backgroundColor;
  final String? sale_price;
  final String? regular_price;
  final String? title;
  bool? is_in_wishlist;
  final String? shop_name;
  // final String? pharmaId;

  // final String? rating;
  final String? categoryId;
  final String? categoryName;
  final String? product_id;
  final EdgeInsetsGeometry? padding;
  Rx<bool>? isLoading;

  CustomBanner({
    super.key,
    this.index = 0,
    this.image,
    this.padding,
    this.backgroundColor,
    this.description,
    this.quantity,
    this.sale_price,
    this.regular_price,
    this.title,
    this.is_in_wishlist,
    this.shop_name,
    // this.rating,
    this.categoryId,
    this.categoryName,
    this.product_id,
    this.isLoading,
  });

  final AddPharmaProductWishlistController addPharmaProductWishlistController =
      Get.put(AddPharmaProductWishlistController());

  final PharmaSpecificProductController pharmaSpecificProductController =
      Get.put(PharmaSpecificProductController());

  @override
  Widget build(BuildContext context) {
    IconData favorite = Icons.favorite;
    IconData favoriteNot = Icons.favorite_border_outlined;
    return GestureDetector(
      onTap: () {
        pharmaSpecificProductController.pharmaSpecificProductApi(
            productId: product_id.toString(),
            categoryId: categoryId.toString(),
        );
        print("category_id ${categoryId}");
        print("category_id ${product_id}");
        print("category_id ${categoryName}");
        // Get.to(PharmacyProductDetailsScreen(
        //   productId: product_id.toString(),
        //   categoryId: categoryId.toString(),
        //   categoryName: categoryName.toString(),
        // ));

        Get.to(() => PharmacyProductDetailsScreen(  productId: product_id.toString(),
          categoryId: categoryId.toString(),
          categoryName: categoryName.toString(),));


      },
      child: Column(
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
                    memCacheHeight: memCacheHeight,
                    imageUrl: image.toString(),
                    fit: BoxFit.cover,
                    height: 160.h,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
              ),
              Obx(
                () => Container(
                  margin: REdgeInsets.only(top: 10, right: 10),
                  padding: REdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.greyBackground),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () async {
                      is_in_wishlist = !is_in_wishlist!;
                      isLoading?.value = true;
                      await addPharmaProductWishlistController.pharmacy_add_product_wishlist(
                        isRefresh: false,
                        categoryId: categoryId.toString(),
                        product_id: product_id.toString(),
                      );
                      isLoading?.value = false;
                    },
                    child: isLoading!.value
                        ? circularProgressIndicator(size: 18)
                        : Icon(
                            is_in_wishlist! ? favorite : favoriteNot,
                            size: 22,
                          ),
                  ),
                ),
              )
            ],
          ),
          hBox(10),
          Row(
            children: [
              sale_price != "null"
                  ? Text(
                      "\$$sale_price",
                      textAlign: TextAlign.left,
                style: AppFontStyle.text_16_600(
                    AppColors.primary,family: AppFontFamily.gilroyRegular),
              )
                  : Text(
                      "\$$regular_price",
                      textAlign: TextAlign.left,
                      style: AppFontStyle.text_16_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
                    ),
              wBox(5.h),
              if (sale_price != "null")
                Text(
                  "\$$regular_price",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: AppColors.lightText,
                      fontFamily: AppFontFamily.gilroyRegular,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.lightText),
                ),
            ],
          ),
          // hBox(10),
          Text(
            title.toString(),
            textAlign: TextAlign.left,
            style: AppFontStyle.text_16_400(
                AppColors.darkText,family: AppFontFamily.gilroyMedium),
          ),
          // hBox(10),
          if (quantity.toString() != "null")
            Text(
              quantity.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppFontStyle.text_14_400(
                  AppColors.lightText,family: AppFontFamily.gilroyRegular),
            ),

          Flexible(
            child: Text(
              shop_name.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppFontStyle.text_14_300(
                  AppColors.lightText,
                family: AppFontFamily.gilroyRegular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
