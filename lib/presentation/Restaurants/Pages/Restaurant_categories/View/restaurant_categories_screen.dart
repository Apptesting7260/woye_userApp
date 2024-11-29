import 'package:woye_user/core/utils/app_export.dart';
import '../../../../../Data/components/GeneralException.dart';
import '../../../../../Data/components/InternetException.dart';
import '../../../../../shared/widgets/CircularProgressIndicator.dart';
import '../Sub_screens/Categories_details/controller/RestaurantCategoriesDetailsController.dart';
import '../controller/restaurant_categories_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RestaurantCategoriesScreen extends StatelessWidget {
  RestaurantCategoriesScreen({super.key});

  final RestaurantCategoriesController controller =
      Get.put(RestaurantCategoriesController());

  final RestaurantCategoriesDetailsController
      restaurantCategoriesDeatilsController =
      Get.put(RestaurantCategoriesDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        isActions: true,
        title: Text(
          "Categories",
          style: AppFontStyle.text_28_600(AppColors.darkText),
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
                    const CustomSliverAppBar(),
                    SliverToBoxAdapter(
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            controller.categoriesData.value.allcategory!.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.restaurantCategoriesDetails,
                                  arguments: {
                                    'name': controller.categoriesData.value
                                        .allcategory![index].name
                                        .toString(),
                                    'id': int.parse(controller.categoriesData
                                        .value.allcategory![index].id
                                        .toString()),
                                  });
                              restaurantCategoriesDeatilsController
                                  .restaurant_Categories_Details_Api(
                                id: controller
                                    .categoriesData.value.allcategory![index].id
                                    .toString(),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.8.w,
                                      color: AppColors.lightPrimary),
                                  borderRadius: BorderRadius.circular(15.r)),
                              child: Padding(
                                padding: REdgeInsets.only(
                                    left: 10, right: 15, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            height: 70.w,
                                            width: 70.w,
                                            child: CachedNetworkImage(
                                              imageUrl: controller
                                                  .categoriesData
                                                  .value
                                                  .allcategory![index]
                                                  .imageUrl
                                                  .toString(),
                                              height: 80.h,
                                              width: 70.w,
                                              // Set width here to maintain the size
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) =>
                                                  circularProgressIndicator(),

                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            )),
                                        wBox(20),
                                        Text(
                                          controller.categoriesData.value
                                              .allcategory![index].name
                                              .toString(),
                                          style: AppFontStyle.text_18_400(
                                              AppColors.darkText),
                                        )
                                      ],
                                    ),
                                    const Icon(Icons.arrow_forward_ios),
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
