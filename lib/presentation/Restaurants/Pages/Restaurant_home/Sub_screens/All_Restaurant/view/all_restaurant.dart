import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/image_cache_height.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_sliver_app_bar.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/All_Restaurant/controller/all_restaurants_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/controller/RestaurantDetailsController.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Restaurant_details/view/restaurant_details_screen.dart';
import 'package:woye_user/shared/theme/colors.dart';
import 'package:woye_user/shared/theme/font_style.dart';
import 'package:woye_user/shared/widgets/custom_app_bar.dart';
import 'package:woye_user/shared/widgets/custom_no_data_found.dart';
import 'package:woye_user/shared/widgets/shimmer.dart';
import '../../../../../../../Core/Utils/sized_box.dart';

class All_Restaurant extends StatelessWidget {
  All_Restaurant({super.key});

  final AllRestaurantController controller = Get.put(AllRestaurantController());

  final RestaurantDetailsController restaurantDeatilsController =
      Get.put(RestaurantDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Restaurants",
          style: AppFontStyle.text_20_600(
            AppColors.darkText,family: AppFontFamily.gilroyRegular,
          ),
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child: circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet' || controller.error.value == "InternetExceptionWidget") {
              return InternetExceptionWidget(
                onPress: () {
                  controller.seeall_restaurant_Api();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.seeall_restaurant_Api();
                },
              );
            }
          case Status.COMPLETED:
            return Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  controller.refresh_Api();
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
                          final restaurants = controller.filteredWishlistData;
                          return restaurants.isEmpty ?
                            CustomNoDataFound(heightBox: hBox(50.h)) : ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: restaurants.length,
                            itemBuilder: (context, index) {
                              final restaurant = restaurants[index];
                              return GestureDetector(
                                onTap: () {
                                  Get.to(()=>RestaurantDetailsScreen(
                                    Restaurantid: restaurant.id.toString(),
                                  ));
                                  restaurantDeatilsController
                                      .restaurant_Details_Api(
                                    id: restaurant.id.toString(),
                                  );
                                },
                                child: restaurantList(
                                  index: index,
                                  image: restaurant.shopimage.toString(),
                                  title: restaurant.shopName.toString().capitalize!,
                                  rating: restaurant.rating.toString(),
                                  price: restaurant.avgPrice.toString(),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => hBox(20),
                          );
                        }),
                      ),
                      SliverToBoxAdapter(
                        child: hBox(100.h),
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

  Widget restaurantList(
      {index, String? image, title, type, isFavourite, rating, price}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CachedNetworkImage(
                memCacheHeight: memCacheHeight,
                width: Get.width,
                fit: BoxFit.fitWidth,
                imageUrl: image.toString(),
                height: 220.h,
                placeholder: (context, url) =>const ShimmerWidget(),
                errorWidget: (context, url, error) => Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.textFieldBorder),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child:  Icon(Icons.broken_image_rounded,color: AppColors.textFieldBorder)),
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
          title.toString().capitalize ?? "",
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
              style: AppFontStyle.text_16_300(AppColors.lightText,family: AppFontFamily.gilroyRegular),
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
