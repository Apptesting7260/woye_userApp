import 'package:woye_user/Presentation/Restaurants/Pages/Categories/Category_details/category_details_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/shared/widgets/custom_app_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingWidth: 200,
        leading: Text(
          "Categories",
          style: AppFontStyle.text_28_600(AppColors.darkText),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          width: 1, color: AppColors.textFieldBorder)),
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

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
                              width: 1, color: AppColors.lightPrimary),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              child: Row(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      "assets/images/6cee589c2f553320ee93e5afced09766 1.png",
                                      scale: 10,
                                      fit: BoxFit.fill,
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height: 80,
                                    width: 80,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
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
                  return SizedBox(
                    height: 20,
                  );
                },
              ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
