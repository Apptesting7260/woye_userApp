import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/login_required_pop_up.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/error_widget.dart';

import '../../Core/Utils/image_cache_height.dart';
import 'CircularProgressIndicator.dart';

class UpdatedCustomItemBanner extends StatelessWidget {
  // String? restaurantId;
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
  bool? isRefresh;
  String? productIdAllProducts;

  UpdatedCustomItemBanner(
      {super.key,
        // this.restaurantId,
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
        this.isLoading,
        this.isRefresh,
        this.productIdAllProducts,
      });

  final AddProductWishlistController add_Wishlist_Controller = Get.put(AddProductWishlistController());
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());

  @override
  Widget build(BuildContext context) {
    IconData favorite = Icons.favorite;
    IconData favoriteNot = Icons.favorite_border_outlined;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Section
        Stack(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: CachedNetworkImage(
                memCacheHeight: memCacheHeight,
                imageUrl: image.toString(),
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Container(
                  color: AppColors.gray.withOpacity(0.2),
                  child: Icon(Icons.image, color: AppColors.lightText),
                ),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: AppColors.gray,
                  highlightColor: AppColors.lightText,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.gray,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        wBox(16),

        // Product Details Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name
              Row(
                children: [
                  Text(
                    title?.toString() ?? "Product Name",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontFamily: AppFontFamily.onestSemiBold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Obx(
                        () => Container(
                      margin: REdgeInsets.only(left: 8),
                      child: InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () async {
                          if (getUserDataController.userData.value.user?.userType == "guestUser") {
                            showLoginRequired(context);
                          } else {
                            is_in_wishlist = !is_in_wishlist!;
                            isLoading?.value = true;
                            await add_Wishlist_Controller.restaurant_add_product_wishlist(
                              productIdAllProducts: productIdAllProducts,
                              isRefresh: isRefresh,
                              categoryId: categoryId.toString(),
                              product_id: product_id.toString(),
                            );
                            isLoading?.value = false;
                          }
                        },
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: isLoading!.value
                                ? circularProgressIndicator(size: 18)
                                : Icon(
                              is_in_wishlist! ? favorite : favoriteNot,
                              size: 22,
                              color: is_in_wishlist! ? Colors.black : Colors.grey[600],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              hBox(6),

              // Price
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.navbar
                    ),
                    child: Center(
                      child: Text(
                        "\$${sale_price != "null" && sale_price != regular_price ? sale_price : regular_price}",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: AppFontFamily.onestRegular,
                        ),
                      ),
                    ),
                  ),
                  wBox(5),
                  if (sale_price != "null" && sale_price != regular_price)
                    Text(
                      "\$$regular_price",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightText,
                        fontFamily: AppFontFamily.onestRegular,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),

              hBox(2),

              // Rating and Order Button Row
              Row(
                children: [
                  // Rating
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 16,
                        color: Colors.amber[700],
                      ),
                      wBox(4),
                      Text(
                        "4.5", // Hardcoded as per image
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        "/5",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Order Button
                  GestureDetector(
                    onTap: () {
                      // Add order functionality here
                      print("Order button pressed for: $title");
                    },
                    child: Container(
                      width: 60.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          "Order",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: AppFontFamily.onestRegular,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
