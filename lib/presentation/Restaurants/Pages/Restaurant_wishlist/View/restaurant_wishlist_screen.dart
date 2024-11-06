import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/product_details_screen.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';

class RestaurantWishlistScreen extends StatelessWidget {
  const RestaurantWishlistScreen({super.key});

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
                      Get.toNamed(AppRoutes.restaurantCategoriesFilter);
                    },
                  )),
                ),
                centerTitle: true,
              ),
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
                }),
                gridDelegate: (SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6.h,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 5.h,
                ))),
            SliverToBoxAdapter(
              child: hBox(100),
            )
          ],
        ),
      ),
    );
  }
}

Widget categoryItem(index) {
  RxBool isFavorite = false.obs;
  IconData favorite = Icons.favorite;
  IconData favoriteNot = Icons.favorite_border_outlined;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Image.asset(
              "assets/images/cat-image${index % 5}.png",
              height: 160,
              // width: Get.width,
            ),
          ),
          Obx(
            () => Container(
                margin: REdgeInsets.only(top: 10, right: 10),
                padding: REdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.greyBackground),
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: () {
                    isFavorite.value = !isFavorite.value;
                    print("tapped");
                  },
                  child: Icon(
                    isFavorite.value ? favorite : favoriteNot,
                    // Icons.favorite_border_outlined,
                    size: 22,
                  ),
                )
                //  SvgPicture.asset(
                //   "assets/svg/wishlist.svg",
                //   height: 15.h,
                // ),
                ),
          )
        ],
      ),
      hBox(5),
      Row(
        children: [
          Text(
            "\$18.00",
            textAlign: TextAlign.left,
            style: AppFontStyle.text_16_600(AppColors.primary),
          ),
        ],
      ),
      Text(
        "McMushroom Pizza",
        textAlign: TextAlign.left,
        style: AppFontStyle.text_16_400(AppColors.darkText),
      ),
    ],
  );
}



// import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
// import 'package:woye_user/core/utils/app_export.dart';
// import 'package:woye_user/shared/widgets/custom_header_notification.dart';

// class RestaurantWishlistScreen extends StatelessWidget {
//   const RestaurantWishlistScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: REdgeInsets.symmetric(horizontal: 12),
//         child: Column(
//           children: [
//             hBox(20),
//             CustomHeaderWithNotification(
//               title: 'Wishlist',
//             ),
//             hBox(20),
//             CustomSearchFilter(
//               onFilterTap: () {
//                 Get.toNamed(AppRoutes.restaurantWishlistFilter);
//               },
//             ),
//             hBox(20),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.85,
//                   crossAxisSpacing: 8,
//                   mainAxisSpacing: 8,
//                 ),
//                 itemCount: 8, // Dummy item count
//                 itemBuilder: (context, index) {
//                   return PizzaItem();
//                 },
//               ),
//             ),
//             hBox(70),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PizzaItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.asset(
//                   "assets/images/burger.png",
//                   fit: BoxFit.cover, // Ensure image scales properly
//                   height: 120.h, // Adjust based on your design
//                   width: double.infinity,
//                 ),
//               ),
//               Positioned(
//                 top: 5.h,
//                 right: 5.w,
//                 child: Container(
//                   padding: REdgeInsets.all(4),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.favorite_border, size: 16.h),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text("\$18.00",
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     wBox(5),
//                     Text(
//                       "\$20.00",
//                       style: TextStyle(
//                         decoration: TextDecoration.lineThrough,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 hBox(4),
//                 Text("McMushroom Pizza"),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
