import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Sub_screens/Product_details/product_details_screen.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';

class RestaurantCategoryDetails extends StatelessWidget {
  const RestaurantCategoryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var title = Get.arguments ?? "Your Item";

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          title,
          style: AppFontStyle.text_22_600(
            AppColors.darkText,
          ),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24),
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
                      Get.toNamed(AppRoutes.restaurantCategoriesFilter);
                    },
                  )),
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: hBox(10),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(childCount: 20,
                    (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Get.to(ProductDetailsScreen(
                            image: "assets/images/cat-image${index % 5}.png",
                            title: "McMushroom Pizza"));
                      },
                      child: CustomItemBanner(index: index));
                  //  categoryItem(index);
                }),
                gridDelegate: (SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6.h,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 5.h,
                ))),
            SliverToBoxAdapter(
              child: hBox(50),
            )
          ],
        ),
      ),
    );
  }
}
