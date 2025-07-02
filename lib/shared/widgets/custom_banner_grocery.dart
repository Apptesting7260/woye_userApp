import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';
import 'package:woye_user/Core/Utils/login_required_pop_up.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/controller/grocery_specific_product_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/grocery_product_details_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/aad_product_wishlist_Controller/add_grocery_product_wishlist.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';

import '../theme/font_family.dart';

class CustomBannerGrocery extends StatelessWidget {
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

  // final String? rating;
  final String? categoryId;
  final String? categoryName;
  final String? product_id;
  final String? bannerId;
  final EdgeInsetsGeometry? padding;
  Rx<bool>? isLoading;
  final String? quickFilter;
  final String? priceSort;
  final String? priceRange;
  final String? productType;

  CustomBannerGrocery({
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
    this.bannerId,
    this.isLoading,
    this.quickFilter,
    this.priceSort,
    this.priceRange,
    this.productType,
  });

  final AddGroceryProductWishlist addGroceryProductWishlist = Get.put(AddGroceryProductWishlist());

  // final PharmaSpecificProductController pharmaSpecificProductController =
  //     Get.put(PharmaSpecificProductController());

  final GrocerySpecificProductController grocerySpecificProductController = Get.put(GrocerySpecificProductController());

  final GetUserDataController getUserDataController = Get.put(GetUserDataController());

  @override
  Widget build(BuildContext context) {
    IconData favorite = Icons.favorite;
    IconData favoriteNot = Icons.favorite_border_outlined;
    return GestureDetector(
      onTap: () {
        grocerySpecificProductController.pharmaSpecificProductApi(
            productId: product_id.toString(),
            categoryId: categoryId.toString());
        print("category_id ${categoryId}");
        print("category_id ${product_id}");
        print("category_id ${categoryName}");
        // Get.to(PharmacyProductDetailsScreen(
        //   productId: product_id.toString(),
        //   categoryId: categoryId.toString(),
        //   categoryName: categoryName.toString(),
        // ));

        Get.to(() => GroceryProductDetailsScreen(
              bannerId: bannerId,
              productId: product_id.toString(),
              categoryId: categoryId.toString(),
              categoryName: categoryName.toString(),
              priceSort: priceSort,
              priceRange: priceRange,
              productType: productType,
            ),
        );
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
                      if (getUserDataController.userData.value.user?.userType =="guestUser") {
                        showLoginRequired(context);
                      }else{
                      is_in_wishlist = !is_in_wishlist!;
                      isLoading?.value = true;
                      await addGroceryProductWishlist.pharmacy_add_product_wishlist(
                        categoryId: categoryId.toString(),
                        product_id: product_id.toString(),
                        quickFilter:quickFilter ,
                        priceSort: priceSort,
                        priceRange:priceRange ,
                        productType: productType,
                      );
                      isLoading?.value = false;
                    }
                      },
                    child: isLoading!.value ? circularProgressIndicator(size: 18)
                         : Icon(is_in_wishlist! ? favorite : favoriteNot,size: 22),
                  ),
                ),
              ),
              // Positioned(
              //   bottom: 10,right: 10,
              //   child:/* Obx(
              //         ()=>*/ InkWell(
              //     onTap: () {
              //       // if (getUserDataController.userData.value.user?.userType == "guestUser") {
              //       //   showLoginRequired(context);
              //       // } else {
              //       //   controller.restaurant_Data.value.highlights![index].isAddToCart.value = true;
              //       // }
              //     },
              //     child: Container(
              //       height: 30.h,width: 30.w,
              //       decoration: BoxDecoration(color: AppColors.primary,
              //           // shape: BoxShape.circle,
              //           borderRadius: BorderRadius.circular(10.r)
              //       ),
              //       child: Icon(/*controller.restaurant_Data.value.highlights![index].isAddToCart.value ? Icons.done :*/Icons.add,
              //         color: AppColors.white,size: 20,),
              //     ),
              //   ),
              //   // ),
              // ),
            ],
          ),
          hBox(10),
          Row(
            children: [
              sale_price != "null"
                  ? Text(
                      "\$$sale_price",
                      textAlign: TextAlign.left,
                      style: AppFontStyle.text_15_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
                    )
                  : Text(
                      "\$$regular_price",
                      textAlign: TextAlign.left,
                style: AppFontStyle.text_15_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
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
                      fontFamily: AppFontFamily.gilroyRegular,
                      color: AppColors.lightText,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.lightText),
                ),
            ],
          ),
          // hBox(10),
          Text(
            title.toString(),
            textAlign: TextAlign.left,
            style: AppFontStyle.text_15_400(AppColors.darkText,family: AppFontFamily.gilroySemiBold),
          ),
          // hBox(10),
          if (quantity.toString() != "null")
            Text(
              quantity.toString(),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppFontStyle.text_14_400(AppColors.lightText,family: AppFontFamily.gilroyMedium),
            ),

          Flexible(
          child: Text(
            shop_name ?? "",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppFontStyle.text_14_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
          ),
        ),
        ],
      ),
    );
  }
}
