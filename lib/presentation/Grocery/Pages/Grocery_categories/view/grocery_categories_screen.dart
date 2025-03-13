import 'package:cached_network_image/cached_network_image.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/Sub_screens/Categories_details/controller/GroceryCategoriesDetailsController.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_categories/controller/grocery_categories_controller.dart';

class GroceryCategoriesScreen extends StatefulWidget {
  const GroceryCategoriesScreen({super.key});

  @override
  State<GroceryCategoriesScreen> createState() => _GroceryCategoriesScreenState();
}

class _GroceryCategoriesScreenState extends State<GroceryCategoriesScreen> {
  final GroceryCategoriesController controller =
  Get.put(GroceryCategoriesController());

  final Grocerycategoriesdetailscontroller
  grocerycategoriesdetailscontroller =
  Get.put(Grocerycategoriesdetailscontroller());

  void initState() {
    // TODO: implement initState
    print('thjjfr');
    controller.pharmacyCategoriesApi();
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
                  controller.pharmacyCategoriesApiRefresh();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.pharmacyCategoriesApiRefresh();
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.pharmacyCategoriesApiRefresh();
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
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.filteredWishlistData.value.length,
                        // Use the filtered list
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.groceryCategoryDetails,
                                  arguments: {
                                    'name': controller
                                        .filteredWishlistData[index].name
                                        .toString(),
                                    'id': int.parse(controller
                                        .filteredWishlistData[index].id
                                        .toString()),
                                  }
                                  );
                              grocerycategoriesdetailscontroller
                                  .pharmacy_Categories_Details_Api(
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
                                    left: 10.h,
                                    right: 15.h,
                                    top: 10.h,
                                    bottom: 10.h),
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
                                            child: CachedNetworkImage(
                                              imageUrl: controller
                                                  .filteredWishlistData[index]
                                                  .imageUrl
                                                  .toString(),
                                              height: 80.h,
                                              width: 70.w,
                                              fit: BoxFit.fill,
                                              placeholder: (context, url) =>
                                                  circularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                              const Icon(Icons.error),
                                            ),
                                          ),
                                          wBox(20.h),
                                          Flexible(
                                            child: Text(
                                              controller.filteredWishlistData[index].name.toString(),

                                              style: AppFontStyle.text_18_400(
                                                  AppColors.darkText),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_ios,
                                        weight: 1),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return hBox(20.h);
                        },
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: hBox(100.h),
                    )
                  ],
                ),
              ),
            );
        }
      }),);
  }
}
