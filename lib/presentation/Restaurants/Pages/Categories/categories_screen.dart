import 'package:woye_user/Presentation/Restaurants/Pages/Categories/Category_details/category_details_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
      body: Padding(
        padding: REdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFormField(
              hintText: "Search",
              prefix: SvgPicture.asset(
                "assets/svg/search.svg",
                height: 20,
              ),
            ),
            hBox(20),
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
                                    child: Image.asset(
                                      "assets/images/pizza.png",
                                      height: 80.h,
                                      fit: BoxFit.fill,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    height: 80.h,
                                    width: 80.w,
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
            hBox(70),
          ],
        ),
      ),
    );
  }
}
