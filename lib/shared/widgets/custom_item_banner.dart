import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';

import 'CircularProgressIndicator.dart';

class CustomItemBanner extends StatelessWidget {
  int? index;
  final String? image;
  final double? imageHeight;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final String? sale_price;
  final String? regular_price;
  final String? title;
  bool? is_in_wishlist;
  final String? resto_name;
  // final String? rating;
  final String? categoryId;
  final String? product_id;
  Rx<bool>? isLoading;

  CustomItemBanner(
      {super.key,
      this.index,
      this.image,
      this.imageHeight,
      this.padding,
      this.backgroundColor,
      this.sale_price,
      this.regular_price,
      this.title,
      this.is_in_wishlist,
      this.resto_name,
      // this.rating,
      this.categoryId,
      this.product_id,
      this.isLoading});

  final AddProductWishlistController add_Wishlist_Controller =
      Get.put(AddProductWishlistController());

  @override
  Widget build(BuildContext context) {
    // RxBool isFavorite = false.obs;
    IconData favorite = Icons.favorite;
    IconData favoriteNot = Icons.favorite_border_outlined;
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
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                    await add_Wishlist_Controller
                        .restaurant_add_product_wishlist(
                      categoryId: categoryId.toString(),
                      product_id: product_id.toString(),
                    );
                    isLoading?.value = false;

                    print("object$sale_price");
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
        // Row(
        //   children: [
        //     Text(
        //       "\$${sale_price}",
        //       textAlign: TextAlign.left,
        //       style: AppFontStyle.text_16_600(AppColors.primary),
        //     ),
        //     wBox(5),
        //     Text(
        //       "\$${regular_price}",
        //       overflow: TextOverflow.ellipsis,
        //       textAlign: TextAlign.left,
        //
        //       style: TextStyle(
        //           fontSize: 14.sp,
        //           fontWeight: FontWeight.w300,
        //           color: AppColors.lightText,
        //           decoration: TextDecoration.lineThrough,
        //           decorationColor: AppColors.lightText),
        //
        //       //  AppFontStyle.text_14_300(AppColors.lightText),
        //     ),
        //   ],
        // ),
        Row(
          children: [
            sale_price != "null"
                ? Text(
                    "\$$sale_price",
                    textAlign: TextAlign.left,
                    style: AppFontStyle.text_16_600(AppColors.primary),
                  )
                : Text(
                    "\$$regular_price",
                    textAlign: TextAlign.left,
                    style: AppFontStyle.text_16_600(AppColors.primary),
                  ),
            wBox(5.h),
            sale_price != "null"
                ? Text(
                    "\$$regular_price",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,

                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                        color: AppColors.lightText,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: AppColors.lightText),

                    //  AppFontStyle.text_14_300(AppColors.lightText),
                  )
                : const SizedBox(),
          ],
        ),
        // hBox(10),
        Text(
          title.toString(),
          textAlign: TextAlign.left,
          style: AppFontStyle.text_16_400(AppColors.darkText),
        ),
        // hBox(10),
        Text(
          resto_name.toString(),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppFontStyle.text_14_300(AppColors.lightText),
        ),
        // hBox(10),
        // Row(
        //   children: [
        //     SvgPicture.asset("assets/svg/star-yellow.svg"),
        //     wBox(4),
        //     Text(
        //       "${rating}/5",
        //       style: AppFontStyle.text_14_300(AppColors.lightText),
        //     ),
        //   ],
        // )
      ],
    );
  }
}
