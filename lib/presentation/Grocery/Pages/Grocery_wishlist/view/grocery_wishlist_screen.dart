import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/grocery_product_details_screen.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class GroceryWishlistScreen extends StatelessWidget {
  const GroceryWishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
        isActions: true,
        title: Text(
          "Wishlist",
          style: AppFontStyle.text_24_600(AppColors.darkText),
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
                      Get.toNamed(AppRoutes.groceryWishlistFilter);
                    },
                  )),
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
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
            )),
            SliverToBoxAdapter(
              child: hBox(100),
            )
          ],
        ),
      ),
    );
  }
}

// Widget categoryItem(index) {
//   RxBool isFavorite = false.obs;
//   IconData favorite = Icons.favorite;
//   IconData favoriteNot = Icons.favorite_border_outlined;
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Stack(
//         alignment: Alignment.topRight,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20.r),
//             ),
//             child: Image.asset(
//               "assets/images/cat-image${index % 5}.png",
//               height: 160,
//               // width: Get.width,
//             ),
//           ),
//           Obx(
//             () => Container(
//                 margin: REdgeInsets.only(top: 10, right: 10),
//                 padding: REdgeInsets.all(6),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.r),
//                     color: AppColors.greyBackground),
//                 child: InkWell(
//                   highlightColor: Colors.transparent,
//                   splashColor: Colors.transparent,
//                   onTap: () {
//                     isFavorite.value = !isFavorite.value;
//                     print("tapped");
//                   },
//                   child: Icon(
//                     isFavorite.value ? favorite : favoriteNot,
//                     // Icons.favorite_border_outlined,
//                     size: 22,
//                   ),
//                 )),
//           )
//         ],
//       ),
//       hBox(5),
//       Row(
//         children: [
//           Text(
//             "\$18.00",
//             textAlign: TextAlign.left,
//             style: AppFontStyle.text_16_600(AppColors.primary),
//           ),
//         ],
//       ),
//       Text(
//         "McMushroom Pizza",
//         textAlign: TextAlign.left,
//         style: AppFontStyle.text_16_400(AppColors.darkText),
//       ),
//     ],
//   );
// }
