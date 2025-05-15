import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import '../../../../../Data/components/GeneralException.dart';
import '../../../../../Data/components/InternetException.dart';
import '../../../../../shared/widgets/CircularProgressIndicator.dart';
import '../../../../../shared/widgets/custom_no_data_found.dart';
import '../Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import '../controller/restaurant_categories_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RestaurantCategoriesScreen extends StatefulWidget {
  RestaurantCategoriesScreen({super.key});

  @override
  State<RestaurantCategoriesScreen> createState() =>
      _RestaurantCategoriesScreenState();
}

class _RestaurantCategoriesScreenState
    extends State<RestaurantCategoriesScreen> {
  final RestaurantCategoriesController controller =
      Get.put(RestaurantCategoriesController());

  final RestaurantCategoriesDetailsController
      restaurantCategoriesDeatilsController =
      Get.put(RestaurantCategoriesDetailsController());

  void initState() {
    // TODO: implement initState
    print('thjjfr');
    controller.restaurant_Categories_Api();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        isActions: true,
        title: Text(
          "Categories",
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
                  controller.restaurant_Categories_Api();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.restaurant_Categories_Api();
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.restaurant_Categories_Api();
              },
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 24),
                child: CustomScrollView(
                  slivers: [
                    CustomSliverAppBar(
                      onChanged: (value) {
                        controller.filterCategories(value);
                      },
                      controller: controller.searchController,
                    ),
                    SliverToBoxAdapter(
                      child: controller.filteredWishlistData.value.length == 0  ?
                      CustomNoDataFound(heightBox:hBox(15.h) ) :   ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredWishlistData.value.length,
                        // Use the filtered list
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.restaurantCategoriesDetails,
                                  arguments: {
                                    'name': controller
                                        .filteredWishlistData[index].name
                                        .toString(),
                                    'id': int.parse(controller
                                        .filteredWishlistData[index].id
                                        .toString()),
                                  });
                              restaurantCategoriesDeatilsController
                                  .restaurant_Categories_Details_Api(
                                id: controller.filteredWishlistData[index].id
                                    .toString(),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.8.w,
                                    color: AppColors.lightPrimary),
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                              child: Padding(
                                padding: REdgeInsets.only(
                                    left: 10, right: 15, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: Get.width * .72,
                                      // color: Colors.red,
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r)),
                                            height: 70.w,
                                            width: 70.w,
                                            child: ClipRRect(
                                                borderRadius:BorderRadius.circular(10.r),
                                              child: CachedNetworkImage(
                                                imageUrl: controller
                                                    .filteredWishlistData[index]
                                                    .imageUrl
                                                    .toString(),
                                                height: 80.h,
                                                width: 70.w,
                                                fit: BoxFit.fill,
                                                placeholder: (context, url) =>circularProgressIndicator(),
                                                errorWidget:(context, url, error) =>const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                          wBox(20),
                                          Text(
                                            controller.filteredWishlistData[index].name.toString(),
                                            style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_ios,size: 20,),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return hBox(20);
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: hBox(100),
                    )
                  ],
                ),
              ),
            );
        }
      }),
    );
  }
}
