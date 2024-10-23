import 'package:flutter/material.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Categories/Category_details/Filter/filter_screen.dart';
import 'package:woye_user/shared/theme/colors.dart';
import 'package:woye_user/shared/widgets/custom_search_filter.dart';
import 'package:woye_user/shared/widgets/customappbar.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            hBox(20),


            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         Navigator.pop(context);
            //       },
            //       child: Container(
            //         width: 44.h,
            //         height: 44.h,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: Colors.grey.shade200,
            //         ),
            //         child: Center(
            //           child: Image.asset("assets/images/back.png", scale: 4),
            //         ),
            //       ),
            //     ),
            //     Text(
            //       "Pizza",
            //       style: TextStyle(
            //         fontSize: 24.sp,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //     wBox(44) // Empty space to balance the layout
            //   ],
            // ),

            CustomAppBar1(title: 'Pizza',),
            hBox(20),

            // Search bar and Filter Icon
            // Row(
            //   children: [
            //     Expanded(
            //       child: Opacity(
            //         opacity: .3,
            //         child: Container(
            //           height: 60.h,
            //           child: TextField(
            //             decoration: InputDecoration(
            //               hintText: "Search",
            //               prefixIcon: Icon(Icons.search),
            //               border: OutlineInputBorder(
            //                   borderRadius: BorderRadius.circular(15.r),
            //                   borderSide: BorderSide(width: 1.w,color: AppColors.hintText)
            //               ),
            //               filled: true,
            //               fillColor: Colors.white
            //             ),
            //           ),
            //         ),
            //       ),
            //     ),
            //     wBox(8),
            //     Opacity(
            //       opacity: .3,
            //       child: InkWell(
            //         onTap: (){
            //           Get.to(FilterScreen());
            //         },
            //         child: Container(
            //           width: 60.h,
            //           height: 60.h,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15.r),
            //             border: Border.all(width: 1.w,color: AppColors.hintText)
            //           ),
            //           child: Center(
            //             child: Image.asset("assets/images/filter.png", scale: 4),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            SearchBarWithFilter(onFilterTap: () {  Get.to(FilterScreen()); },),

           hBox(20),

            // Pizza listing
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 6, // Dummy item count
                itemBuilder: (context, index) {
                  return PizzaItem();
                },
              ),
            ),
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
                    Text("\$18.00", style: TextStyle(fontWeight: FontWeight.bold)),
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
