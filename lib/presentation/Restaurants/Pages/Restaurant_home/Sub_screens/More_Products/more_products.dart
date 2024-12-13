import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/More_Products/controller/more_products_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';

class MoreProducts extends StatelessWidget {
  MoreProducts({super.key});

  final seeAll_Product_Controller controller =
      Get.put(seeAll_Product_Controller());

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    final restaurant_id = arguments['restaurant_id'];
    final category_id = arguments['category_id'];
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "More Products",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
      ),
      // body: SingleChildScrollView(
      //     padding: EdgeInsets.symmetric(horizontal: 24.r),
      //     child: productList()),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child: circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet') {
              return InternetExceptionWidget(
                onPress: () {
                  controller.seeAll_Product_Api(
                      category_id: category_id, restaurant_id: restaurant_id);
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.seeAll_Product_Api(
                      category_id: category_id, restaurant_id: restaurant_id);
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
                onRefresh: () async {
                  controller.seeAll_Product_Api(
                      category_id: category_id, restaurant_id: restaurant_id);
                },
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 24.r),
                    child: productList()));
        }
      }),
    );
  }

  GridView productList() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.seeAll_Data.value.moreProducts!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6.h,
          crossAxisSpacing: 14.w,
          mainAxisSpacing: 5.h,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                Get.to(ProductDetailsScreen(
                  product_id: controller.seeAll_Data.value.moreProducts![index].id
                      .toString(),
                  category_id: controller.seeAll_Data.value.moreProducts![index].categoryId
                      .toString(),
                  category_name: controller.seeAll_Data.value.moreProducts![index].categoryName
                      .toString(),
                ));
              },
              child: CustomItemBanner(
                index: index,
                title: controller.seeAll_Data.value.moreProducts![index].title
                    .toString(),
                categoryId: controller
                    .seeAll_Data.value.moreProducts![index].categoryId
                    .toString(),
                image: controller.seeAll_Data.value.moreProducts![index].urlImage
                    .toString(),
                is_in_wishlist: controller
                    .seeAll_Data.value.moreProducts![index].isInWishlist,
                product_id: controller.seeAll_Data.value.moreProducts![index].id
                    .toString(),
                sale_price: controller
                    .seeAll_Data.value.moreProducts![index].salePrice
                    .toString(),
                resto_name: controller
                    .seeAll_Data.value.moreProducts![index].restoName
                    .toString(),
                regular_price: controller
                    .seeAll_Data.value.moreProducts![index].regularPrice
                    .toString(),
                rating: controller.seeAll_Data.value.moreProducts![index].rating
                    .toString(),
                isLoading:
                    controller.seeAll_Data.value.moreProducts![index].isLoading,
              ));
        });
  }
}
