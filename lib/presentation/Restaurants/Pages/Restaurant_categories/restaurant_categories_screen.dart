import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/restaurant_category_details_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';

class RestaurantCategoriesScreen extends StatelessWidget {
  const RestaurantCategoriesScreen({super.key});

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
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                automaticallyImplyLeading: false,
                snap: true,
                floating: true,
                expandedHeight: 60.h,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(left: 24, right: 24),
                  title: SizedBox(
                    height: 60,
                    child: CustomTextFormField(
                      contentPadding: REdgeInsets.only(bottom: 8),
                      borderRadius: BorderRadius.circular(10),
                      hintText: "Search",
                      hintStyle: AppFontStyle.text_10_400(AppColors.hintText),
                      prefix: Padding(
                        padding: REdgeInsets.only(left: 15, right: 8),
                        child: SvgPicture.asset(
                          "assets/svg/search.svg",
                          height: 14.h,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(minWidth: 30),
                    ),
                  ),
                )),
            // SliverList.separated(
            //     itemCount: 30,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         child: Text("aaaaaaaaaaa"),
            //       );
            //     },
            //     separatorBuilder: (context, index) {
            //       return hBox(20);
            //     })
            SliverFillRemaining(
              child: Expanded(
                child: ListView.separated(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(RestaurantCategoryDetailsScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.8.w, color: AppColors.lightPrimary),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Padding(
                          padding: REdgeInsets.only(left: 10, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 100.h,
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r)),
                                      height: 80.h,
                                      width: 80.w,
                                      child: Image.asset(
                                        "assets/images/pizza.png",
                                        height: 80.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    wBox(20),
                                    Text(
                                      'Pizza',
                                      style: AppFontStyle.text_18_400(
                                          AppColors.darkText),
                                    )
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return hBox(20);
                  },
                ),
              ),
            )
          ],
          //  Padding(
          //   padding: REdgeInsets.all(16.0),
          //   child: Column(
          //     children: [
          //       // CustomTextFormField(
          //       //   hintText: "Search",
          //       //   prefix: SvgPicture.asset(
          //       //     "assets/svg/search.svg",
          //       //     height: 20,
          //       //   ),
          //       // ),
          //       hBox(20),
          //       Expanded(
          //         child: ListView.separated(
          //           itemCount: 20,
          //           itemBuilder: (context, index) {
          //             return GestureDetector(
          //               onTap: () {
          //                 Get.to(RestaurantCategoryDetailsScreen());
          //               },
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                     border: Border.all(
          //                         width: 0.8.w, color: AppColors.lightPrimary),
          //                     borderRadius: BorderRadius.circular(15.r)),
          //                 child: Padding(
          //                   padding: REdgeInsets.only(left: 10, right: 15),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       SizedBox(
          //                         height: 100.h,
          //                         child: Row(
          //                           children: [
          //                             Container(
          //                               decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       BorderRadius.circular(10.r)),
          //                               height: 80.h,
          //                               width: 80.w,
          //                               child: Image.asset(
          //                                 "assets/images/pizza.png",
          //                                 height: 80.h,
          //                                 fit: BoxFit.fill,
          //                               ),
          //                             ),
          //                             wBox(20),
          //                             Text(
          //                               'Pizza',
          //                               style: AppFontStyle.text_18_400(
          //                                   AppColors.darkText),
          //                             )
          //                           ],
          //                         ),
          //                       ),
          //                       Icon(Icons.arrow_forward_ios),
          //                     ],
          //                   ),
          //                 ),
          //               ),
          //             );
          //           },
          //           separatorBuilder: (BuildContext context, int index) {
          //             return hBox(20);
          //           },
          //         ),
          //       ),
          //       hBox(70),
          //     ],
          //   ),
          // ),
        ));
  }
}
