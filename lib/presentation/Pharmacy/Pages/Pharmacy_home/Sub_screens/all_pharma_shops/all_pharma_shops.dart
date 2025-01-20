import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_sliver_app_bar.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/all_pharma_shops/controller/all_pharma_shops_controller.dart';
import 'package:woye_user/shared/theme/colors.dart';
import 'package:woye_user/shared/theme/font_style.dart';
import 'package:woye_user/shared/widgets/custom_app_bar.dart';
import '../../../../../../../Core/Utils/sized_box.dart';

class AllPharmaShopsScreen extends StatelessWidget {
  AllPharmaShopsScreen({super.key});

  final AllPharmaShopsController controller =
      Get.put(AllPharmaShopsController());

  // final RestaurantDetailsController restaurantDeatilsController =
  // Get.put(RestaurantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Pharmacy Shops",
          style: AppFontStyle.text_22_600(
            AppColors.darkText,
          ),
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
                  controller.refreshApi();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.refreshApi();
                },
              );
            }
          case Status.COMPLETED:
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  controller.refreshApi();
                },
                child: Padding(
                  padding:
                      REdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                  child: CustomScrollView(
                    slivers: [
                      CustomSliverAppBar(
                        onChanged: (value) {
                          controller.filterCategories(value);
                        },
                        controller: controller.searchController,
                      ),
                      SliverToBoxAdapter(
                        child: Obx(() {
                          final pharma = controller.filteredWishlistData;
                          return ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: pharma.length,
                            itemBuilder: (context, index) {
                              final pharmaShops = pharma[index];
                              return GestureDetector(
                                onTap: () {
                                  // Get.to(RestaurantDetailsScreen(
                                  //   Restaurantid: restaurant.id.toString(),
                                  // ));
                                  // restaurantDeatilsController
                                  //     .restaurant_Details_Api(
                                  //   id: restaurant.id.toString(),
                                  // );
                                },
                                child: pharmaShop(
                                  index: index,
                                  image: pharmaShops.shopimage.toString(),
                                  title: pharmaShops.shopName.toString(),
                                  rating: pharmaShops.rating.toString(),
                                  price: pharmaShops.avgPrice.toString(),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => hBox(20.h),
                          );
                        }),
                      ),
                      SliverToBoxAdapter(
                        child: hBox(20.h),
                      )
                    ],
                  ),
                ),
              ),
            );
        }
      }),
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
