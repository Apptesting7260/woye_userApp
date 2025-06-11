import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Categories_details/controller/PharmacyCategoriesDetailsController.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_categories/Sub_screens/Filter/Pharma_Categories_Filter_controller.dart';
import 'package:woye_user/shared/widgets/custom_no_data_found.dart';

import '../../../../../../../Shared/theme/font_family.dart';

class PharmacyCategoryDetails extends StatelessWidget {
  PharmacyCategoryDetails({super.key});

  final PharmacyCategoriesDetailsController controller = Get.put(PharmacyCategoriesDetailsController());

  final PharmaCategoriesFilterController categoriesFilterController = Get.put(PharmaCategoriesFilterController());

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments ?? {};
    String categoryTitle = args['name'] ?? "";
    int categoryId = args['id'] ?? 0;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        categoriesFilterController.resetFilters();
      },
      child: Scaffold(
        appBar: CustomAppBar(
          leadingOnTap: () {
            categoriesFilterController.resetFilters();
            Get.back();
          },
          title: Text(
            categoryTitle,
            style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
          ),
        ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: circularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet' || controller.error.value == 'InternetExceptionWidget') {
                return InternetExceptionWidget(
                  onPress: () {
                    categoriesFilterController.resetFilters();
                    controller.pharmacy_Categories_Details_Api(
                        id: categoryId.toString());
                  },
                );
              } else {
                return GeneralExceptionWidget(
                  onPress: () {
                    categoriesFilterController.resetFilters();
                    controller.pharmacy_Categories_Details_Api(
                        id: categoryId.toString());
                  },
                );
              }
            case Status.COMPLETED:
              return RefreshIndicator(
                onRefresh: () async {
                  categoriesFilterController.resetFilters();
                  controller.pharmacy_Categories_Details_Api(id: categoryId.toString());
                },
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 24.h),
                  child: CustomScrollView(
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
                            child: (CustomSearchFilter(
                              controller: controller.searchController,
                              onChanged: (value) {
                                if (controller.categoriesDetailsData.value
                                    .filterProduct!.isEmpty) {
                                  controller.searchDataFun(value);
                                } else {
                                  controller.filterSearchDataFun(value);
                                }
                              },
                              onFilterTap: () {
                                Get.toNamed(
                                  AppRoutes.pharmacyCategoryFilter,
                                  arguments: {
                                    'categoryId': categoryId.toString()
                                  },
                                );
                                categoriesFilterController
                                    .pharmacy_get_CategoriesFilter_Api();
                              },
                            )),
                          ),
                          centerTitle: true,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: hBox(10.h),
                      ),
                      if (controller.categoriesDetailsData.value.filterProduct!.isEmpty &&controller.categoriesDetailsData.value.categoryProduct!.isEmpty
                          // ||(controller.categoriesDetailsData.value.filterProduct!.isEmpty  && controller.searchController.text.isNotEmpty)
                          // ||(controller.categoriesDetailsData.value.categoryProduct!.isEmpty && controller.searchController.text.isNotEmpty)
                      )
                      SliverToBoxAdapter(child: CustomNoDataFound(heightBox: hBox(50.h)),
                        ),
                      if (controller.categoriesDetailsData.value.filterProduct!.isEmpty)
                        productList(),
                      if (controller.categoriesDetailsData.value.filterProduct!.isNotEmpty)
                        filterProductList(),
                      SliverToBoxAdapter( //{product_id: 5103, category_id: 87}{product_id: 5100, category_id: 87}
                        child: hBox(50.h),
                      )
                    ],
                  ),
                ),
              );
          }
        }),
      ),
    );
  }

  SliverToBoxAdapter productList() {
    return SliverToBoxAdapter(
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:controller.searchData.length,
            // itemCount:controller.categoriesDetailsData.value.categoryProduct!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.w,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 5.h,
              // crossAxisCount: 2,
              // childAspectRatio: 0.65.h,
              // crossAxisSpacing: 16.w,
              // mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return CustomBanner(
                image: controller.searchData[index].urlImage
                    .toString(),
                sale_price:  controller.searchData[index].salePrice
                    .toString(),
                regular_price:  controller.searchData[index].regularPrice
                    .toString(),
                title:  controller.searchData[index].title
                    .toString(),
                quantity: controller.searchData[index].packagingValue
                    .toString(),
                categoryId:  controller.searchData[index].categoryId
                    .toString(),
                product_id:  controller.searchData[index].id
                    .toString(),
                shop_name:  controller.searchData[index].shopName
                    .toString(),
                is_in_wishlist:  controller.searchData[index].isInWishlist,
                isLoading:  controller.searchData[index].isLoading,
                categoryName:  controller.searchData[index].categoryName.toString(),
              );
              // return CustomBanner(
              //   image: controller.categoriesDetailsData.value
              //       .categoryProduct![index].urlImage
              //       .toString(),
              //   sale_price: controller.categoriesDetailsData.value
              //       .categoryProduct![index].salePrice
              //       .toString(),
              //   regular_price: controller.categoriesDetailsData.value
              //       .categoryProduct![index].regularPrice
              //       .toString(),
              //   title: controller
              //       .categoriesDetailsData.value.categoryProduct![index].title
              //       .toString(),
              //   quantity: controller.categoriesDetailsData.value
              //       .categoryProduct![index].packagingValue
              //       .toString(),
              //   categoryId: controller.categoriesDetailsData.value
              //       .categoryProduct![index].categoryId
              //       .toString(),
              //   product_id: controller
              //       .categoriesDetailsData.value.categoryProduct![index].id
              //       .toString(),
              //   shop_name: controller.categoriesDetailsData.value
              //       .categoryProduct![index].shopName
              //       .toString(),
              //   is_in_wishlist: controller.categoriesDetailsData.value
              //       .categoryProduct![index].isInWishlist,
              //   isLoading: controller.categoriesDetailsData.value
              //       .categoryProduct![index].isLoading,
              //   categoryName: controller.categoriesDetailsData.value
              //       .categoryProduct![index].categoryName
              //       .toString(),
              // );
            }));
  }

  SliverToBoxAdapter filterProductList() {
    return SliverToBoxAdapter(
        child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.filterProductSearchData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.w,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 5.h,
              // crossAxisCount: 2,
              // childAspectRatio: 0.65.h,
              // crossAxisSpacing: 16.w,
              // mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              var product = controller.filterProductSearchData[index];
              return CustomBanner(
                image: product.urlImage ?? "",
                sale_price: product.salePrice ?? product.regularPrice ?? "",
                regular_price: product.regularPrice ?? "",
                title: product.title ?? "",
                quantity: product.packagingValue ?? "",
                categoryId: product.categoryId.toString(),
                product_id: product.id.toString(),
                shop_name: product.shopName ?? "",
                is_in_wishlist: product.isInWishlist,
                isLoading: product.isLoading,
                categoryName: product.categoryName ?? "",
                productType: categoriesFilterController.selectedCuisines.join(', '),
                priceRange:categoriesFilterController.priceRadioValue.value == 1 ? ""
                    : "${categoriesFilterController.lowerValue.value},${categoriesFilterController.upperValue.value}",
                priceSort: categoriesFilterController.priceRadioValue.value == 0 ? ""
                    : categoriesFilterController.priceRadioValue.value == 1 ? "low to high" : "high to low",
                quickFilter:categoriesFilterController.priceRadioValue.value == 1 ? ""
                    : categoriesFilterController.selectedQuickFilters.toString(),
              );
            },
        ),
    );
  }
}
