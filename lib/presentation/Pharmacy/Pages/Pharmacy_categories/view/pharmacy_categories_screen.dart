import 'package:woye_user/core/utils/app_export.dart';

class PharmacyCategoriesScreen extends StatelessWidget {
  const PharmacyCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List catItems = [
      "Personal Care",
      "Skin Care",
      "Digestive Care",
      "Fever Care",
      "Heart Care",
      "Eyes Care"
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
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 24),
          child: CustomScrollView(
            slivers: [
              const CustomSliverAppBar(),
              SliverToBoxAdapter(
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.pharmacyCategoryDetails,
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
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: ColoredBox(
                                      color: AppColors.ultraLightPrimary,
                                      child: Padding(
                                        padding: const EdgeInsets.all(14.0),
                                        child: Image.asset(
                                          "assets/images/pharmacy-cat-${index % 3}.png",
                                          height: 30.h,
                                          // fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  wBox(20),
                                  Text(
                                    catItems[index % 5],
                                    style: AppFontStyle.text_16_400(
                                        AppColors.darkText),
                                  )
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 18.w,
                              ),
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
