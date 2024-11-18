import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/grocery_product_details_screen.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class GroceryCategoryDetails extends StatelessWidget {
  GroceryCategoryDetails({super.key});

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
                      Get.toNamed(AppRoutes.pharmacyCategoryFilter);
                    },
                  )),
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: hBox(10),
            ),
            itemGrid(),
            SliverToBoxAdapter(
              child: hBox(50),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter itemGrid() {
    return SliverToBoxAdapter(
        child: CustomGridView(
      itemCount: 10,
      imageAddress: "assets/images/grocery-item.png",
      title: "Arla DANO Full Cream Milk Powder Instant",
      quantity: "50gm",
      onTap: () {
        Get.to(() => const GroceryProductDetailsScreen(
            image: "assets/images/grocery-item.png",
            title: "Arla DANO Full Cream Milk Powder Instant"));
      },
    ));
  }
}
