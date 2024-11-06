import 'package:woye_user/core/utils/app_export.dart';

class RestaurantCategoriesScreen extends StatelessWidget {
  const RestaurantCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List catItems = [
      "Pizza",
      "Burger",
      "Chicken",
      "Fried Rice",
      "Desserts",
      "Sweet"
    ];
    return Scaffold(
        appBar: CustomAppBar(
          isLeading: false,
          isActions: true,
          title: Text(
            "Categories",
            style: AppFontStyle.text_28_600(AppColors.darkText),
          ),
        ),
        body: 
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: CustomScrollView(
            slivers: [
              const CustomSliverAppBar(),
              SliverToBoxAdapter(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.restaurantCategoriesDetails,
                            arguments: catItems[index % 5]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.8.w, color: AppColors.lightPrimary),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Padding(
                          padding: REdgeInsets.only(
                              left: 10, right: 15, top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    height: 70.w,
                                    width: 70.w,
                                    child: Image.asset(
                                      "assets/images/cat-image${index % 5}.png",
                                      height: 80.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  wBox(20),
                                  Text(
                                    catItems[index % 5],
                                    style: AppFontStyle.text_18_400(
                                        AppColors.darkText),
                                  )
                                ],
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
              SliverToBoxAdapter(
                child: hBox(100),
              )
            ],
          ),
        ));
  }
}
