import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/controller/grocery_specific_product_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/grocery_product_details_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/Controller/grocery_wishlist_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_wishlist/aad_product_wishlist_Controller/add_grocery_product_wishlist.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';
import 'package:woye_user/shared/widgets/custom_no_data_found.dart';

import '../../../../../Shared/theme/font_family.dart';

class GroceryWishlistScreen extends StatefulWidget {
  const GroceryWishlistScreen({super.key});

  @override
  State<GroceryWishlistScreen> createState() => _GroceryWishlistScreenState();
}

class _GroceryWishlistScreenState extends State<GroceryWishlistScreen> {
  void initState() {
    // TODO: implement initState
    print('thjjfrioey irt mt2');
    controller.pharmacy_product_wishlist_api();
    super.initState();
  }

  final GroceryWishlistController controller = Get.put(GroceryWishlistController());

  final AddGroceryProductWishlist addGroceryProductWishlist = Get.put(AddGroceryProductWishlist());

  final GrocerySpecificProductController grocerySpecificProductController = Get.put(GrocerySpecificProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        isActions: true,
        title: Text(
          "Wishlist",
          style: AppFontStyle.text_23_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child: circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet') {
              return InternetExceptionWidget(
                onPress: () {
                  controller.pharmacyProductWishlistRefreshApi();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.pharmacyProductWishlistRefreshApi();
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.pharmacyProductWishlistRefreshApi();
              },
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 24.w),
                child: controller.wishlistData.value.allWishlist!.isEmpty
                    ? Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          hBox(Get.height / 3),
                          Center(
                            child: Image.asset(
                              ImageConstants.wishlistEmpty,
                              height: 70.h,
                              width: 100.h,
                            ),
                          ),
                          hBox(10.h),
                          Text(
                            "Your wishlist is empty!",
                            style: AppFontStyle.text_20_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
                          ),
                          hBox(5.h),
                          Text(
                            "Explore more and shortlist some items",
                            style:
                                AppFontStyle.text_16_400(AppColors.mediumText,family: AppFontFamily.gilroyMedium),
                          ),
                        ],
                      )
                    : CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            pinned: false,
                            snap: false,
                            floating: false,
                            expandedHeight: 70.h,
                            surfaceTintColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            flexibleSpace: FlexibleSpaceBar(
                              titlePadding: REdgeInsets.only(bottom: 15),
                              title: SizedBox(
                                height: 35.h,
                                child: CustomSearchFilter(
                                  onChanged: (value) {
                                    controller.filterWishlistData(value);
                                  },
                                  controller: controller.searchController,
                                  showfilterIcon: false,
                                ),
                              ),
                              centerTitle: true,
                            ),
                          ),
                          if (controller
                              .wishlistData.value.allWishlist!.isNotEmpty)...[

                            controller.filteredWishlistData.isNotEmpty?
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: controller.filteredWishlistData
                                        .length, (context, index) {
                                  var product =
                                      controller.filteredWishlistData[index];
                                  return GestureDetector(
                                    onTap: () {
                                      grocerySpecificProductController.pharmaSpecificProductApi(
                                            productId:product.id.toString(),
                                            categoryId: product.categoryId.toString(),
                                      );

                                      Get.to(()=>GroceryProductDetailsScreen(
                                          isWishList: true,
                                          productId: product.id.toString(),
                                          categoryId: product.categoryId.toString(),
                                          categoryName: product.categoryName.toString(),
                                      ),);
                                    },
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Center(
                                              child: CachedNetworkImage(
                                                memCacheHeight: memCacheHeight,
                                                imageUrl:
                                                    product.urlImage.toString(),
                                                fit: BoxFit.cover,
                                                height: 160.h,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                placeholder: (context, url) =>
                                                    Shimmer.fromColors(
                                                  baseColor: AppColors.gray,
                                                  highlightColor:
                                                      AppColors.lightText,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.gray,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Obx(
                                            () => Container(
                                              margin: REdgeInsets.only(
                                                  top: 10, right: 10),
                                              padding: REdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: AppColors.greyBackground,
                                              ),
                                              child: InkWell(
                                                highlightColor:
                                                    Colors.transparent,
                                                splashColor: Colors.transparent,
                                                onTap: () {
                                                  product.isLoading.value =
                                                      true;
                                                  addGroceryProductWishlist
                                                      .pharmacy_add_product_wishlist(
                                                    categoryId: "",
                                                    product_id:
                                                        product.id.toString(),
                                                  );
                                                  print(
                                                      "product_id ${product.id.toString()}");
                                                },
                                                child: product.isLoading.value
                                                    ? circularProgressIndicator(
                                                        size: 18)
                                                    : Icon(
                                                        product.isInWishlist ==
                                                                true
                                                            ? Icons.favorite
                                                            : Icons
                                                                .favorite_border_outlined,
                                                        size: 22,
                                                      ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      hBox(10.h),
                                      Row(
                                        children: [
                                          product.salePrice != null
                                              ? Text(
                                                  "\$${product.salePrice}",
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      AppFontStyle.text_15_600(
                                                          AppColors.primary,family: AppFontFamily.gilroyRegular),
                                                )
                                              : Text(
                                                  "\$${product.regularPrice}",
                                                  textAlign: TextAlign.left,
                                                  style:
                                                      AppFontStyle.text_15_600(
                                                          AppColors.primary,family: AppFontFamily.gilroyRegular),
                                                ),
                                          wBox(5.h),
                                          if (product.salePrice != null)
                                            Text(
                                              "\$${product.regularPrice}",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,

                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w300,
                                                  color: AppColors.lightText,
                                                  decoration: TextDecoration.lineThrough,
                                                  decorationColor:AppColors.lightText,
                                                  fontFamily: AppFontFamily.gilroyMedium),

                                              //  AppFontStyle.text_14_300(AppColors.lightText),
                                            ),
                                        ],
                                      ),
                                      Text(
                                        product.title.toString(),
                                        textAlign: TextAlign.left,
                                        style: AppFontStyle.text_16_400(
                                            AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/svg/star-yellow.svg"),
                                          wBox(4),
                                          Text(
                                            "${product.rating ?? 0}/5",
                                            style: AppFontStyle.text_14_300(
                                                AppColors.lightText,family: AppFontFamily.gilroyRegular),
                                          ),
                                          wBox(4),
                                          // Text(
                                          //   controller
                                          //       .wishlistData
                                          //       .value
                                          //       .categoryProduct![index].restoName
                                          //       .toString(),
                                          //   overflow: TextOverflow.ellipsis,
                                          //   textAlign: TextAlign.left,
                                          //   style: AppFontStyle.text_14_300(
                                          //       AppColors.lightText),
                                          // ),
                                        ],
                                      )
                                    ],
                                  ));
                                  //  categoryItem(index);
                                }),
                                gridDelegate:
                                    (SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6.w,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 5.h,
                                ))):
                            SliverToBoxAdapter(
                              child:CustomNoDataFound(heightBox: hBox(15.h),),
                            ),
                          SliverToBoxAdapter(
                            child: hBox(100),
                          )
                        ],
                      ],
              ),
            ));
        }
      }),
    );
  }
}
