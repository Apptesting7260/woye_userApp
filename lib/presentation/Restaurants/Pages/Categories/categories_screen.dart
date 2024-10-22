import 'package:woye_user/Presentation/Restaurants/Pages/Categories/Category_details/category_details_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/shared/widgets/custom_app_bar.dart';
import 'package:woye_user/shared/widgets/custom_header_notification.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Column(
          children: [
            hBox(20),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text("Categories", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28.sp,fontFamily: 'Gilroy')),
            //     Container(
            //       padding: REdgeInsets.all(9),
            //       height: 44.h,
            //       width: 44.h,
            //       decoration: BoxDecoration(
            //           color: AppColors.greyBackground,
            //           borderRadius: BorderRadius.circular(12.r)),
            //       child: SvgPicture.asset(
            //         ImageConstants.notification,
            //       ),
            //     ),
            //   ],
            // ),

            CustomHeaderWithNotification(title: 'Categories',),

            hBox(20),

            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                    borderSide: BorderSide(
                        width: 1.w, color: AppColors.textFieldBorder)),
              ),
            ),

            hBox(20),

            // Category list
            Expanded(
              child: ListView.separated(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(CategoryDetailsScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1.w, color: AppColors.lightPrimary),
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Padding(
                        padding: REdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100.h,
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/burger.png",
                                      scale: 10,
                                      fit: BoxFit.fill,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    height: 80.h,
                                    width: 80.w,
                                  ),
                                  wBox(10),
                                  Text('Pizza')
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
            hBox(70),
          ],
        ),
      ),
    );
  }
}
