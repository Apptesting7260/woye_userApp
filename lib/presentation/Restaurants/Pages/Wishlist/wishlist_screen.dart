import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Wishlist/Filter/filter_screen.dart';
import 'package:woye_user/shared/widgets/custom_header_notification.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            hBox(20),
            CustomHeaderWithNotification(
              title: 'Wishlist',
            ),
            hBox(20),
            CustomSearchFilter(
              onFilterTap: () {
                Get.to(FilterWishScreen());
              },
            ),
            hBox(20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 8, // Dummy item count
                itemBuilder: (context, index) {
                  return PizzaItem();
                },
              ),
            ),
            hBox(70),
          ],
        ),
      ),
    );
  }
}

class PizzaItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/burger.png",
                  fit: BoxFit.cover, // Ensure image scales properly
                  height: 120.h, // Adjust based on your design
                  width: double.infinity,
                ),
              ),
              Positioned(
                top: 5.h,
                right: 5.w,
                child: Container(
                  padding: REdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite_border, size: 16.h),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("\$18.00",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    wBox(5),
                    Text(
                      "\$20.00",
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                hBox(4),
                Text("McMushroom Pizza"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
