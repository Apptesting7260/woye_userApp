import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Categories_details/controller/PharmacyCategoriesDetailsController.dart';

class PharmacyCategoryDetails extends StatelessWidget {
  PharmacyCategoryDetails({super.key});

  final PharmacyCategoriesDetailsController controller =
      Get.put(PharmacyCategoriesDetailsController());

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    String categoryTitle = args['name'];
    int categoryId = args['id'];

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          categoryTitle,
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
                  controller.pharmacy_Categories_Details_Api(
                      id: categoryId.toString());
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.pharmacy_Categories_Details_Api(
                      id: categoryId.toString());
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.pharmacy_Categories_Details_Api(
                    id: categoryId.toString());
              },
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 24.h),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: false,
                      snap: true,
                      floating: true,
                      expandedHeight: 70.h,
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      flexibleSpace: FlexibleSpaceBar(
                        titlePadding: REdgeInsets.only(bottom: 15),
                        title: SizedBox(
                          height: 35.h,
                          child: (CustomSearchFilter(
                            onFilterTap: () {
                              Get.toNamed(AppRoutes.pharmacyCategoryFilter);
                            },
                          )),
                        ),
                        centerTitle: true,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: hBox(10.h),
                    ),
                    // categoriesList(),
                    if (controller
                        .categoriesDetailsData.value.categoryProduct!.isEmpty)
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                ImageConstants.noData,
                                height: 300.h,
                                width: 200.h,
                              ),
                            ),
                            Text(
                              "We couldn't find any results",
                              style:
                                  AppFontStyle.text_20_600(AppColors.darkText),
                            ),
                            hBox(5.h),
                            Text(
                              "Explore more and shortlist some items",
                              style: AppFontStyle.text_16_400(
                                  AppColors.mediumText),
                            ),
                          ],
                        ),
                      ),
                    if (controller.categoriesDetailsData.value.categoryProduct!
                        .isNotEmpty)
                      itemGrid(),
                    SliverToBoxAdapter(
                      child: hBox(50.h),
                    )
                  ],
                ),
              ),
            );
        }
      }),
    );
  }

  SliverToBoxAdapter itemGrid() {
    return SliverToBoxAdapter(
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                controller.categoriesDetailsData.value.categoryProduct!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65.h,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return CustomBanner(
                image: controller.categoriesDetailsData.value
                    .categoryProduct![index].urlImage
                    .toString(),
                sale_price: controller.categoriesDetailsData.value
                    .categoryProduct![index].salePrice
                    .toString(),
                regular_price: controller.categoriesDetailsData.value
                    .categoryProduct![index].regularPrice
                    .toString(),
                title: controller
                    .categoriesDetailsData.value.categoryProduct![index].title
                    .toString(),
                quantity: controller.categoriesDetailsData.value
                    .categoryProduct![index].packagingValue
                    .toString(),
                categoryId: controller.categoriesDetailsData.value
                    .categoryProduct![index].categoryId
                    .toString(),
                product_id: controller
                    .categoriesDetailsData.value.categoryProduct![index].id
                    .toString(),
                shop_name: controller.categoriesDetailsData.value
                    .categoryProduct![index].shopName
                    .toString(),
                is_in_wishlist: controller.categoriesDetailsData.value
                    .categoryProduct![index].isInWishlist,
                isLoading: controller.categoriesDetailsData.value
                    .categoryProduct![index].isLoading,
                categoryName: controller.categoriesDetailsData.value
                    .categoryProduct![index].categoryName
                    .toString(),
              );
            }));
  }
}
