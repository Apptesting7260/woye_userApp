import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class PharmacyVendorDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  PharmacyVendorDetailsScreen(
      {super.key, required this.title, required this.image});
  static final List detailCategories = [
    "All",
    "Acidity",
    "Bloating",
    "Constipation",
    "Indigestions"
  ];
  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    String mainBannerImage = image;
    String title = this.title;
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        actions: [
          Container(
            padding: REdgeInsets.all(9),
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(12.r)),
            child: Icon(
              Icons.share_outlined,
              size: 24.w,
            ),
          ),
          wBox(8),
          Container(
              padding: REdgeInsets.all(9),
              height: 44.h,
              width: 44.h,
              decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Icon(
                Icons.favorite_outline_sharp,
                size: 24.w,
              )),
          wBox(8),
          Container(
            padding: REdgeInsets.all(9),
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(12.r)),
            child: SvgPicture.asset(
              ImageConstants.notification,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mainBanner(mainBannerImage, title),
            hBox(30),
            categoriesList(),
            // itemsGrid(),
            hBox(50)
          ],
        ),
      ),
    );
  }

  Widget mainBanner(String mainBannerImage, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: REdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.greyBackground.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Image.asset(
                  mainBannerImage,
                  height: 60.h,
                ),
              ),
              wBox(10),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFontStyle.text_16_600(AppColors.darkText),
                    ),
                    hBox(5),
                    Row(
                      children: [
                        SvgPicture.asset("assets/svg/star-yellow.svg"),
                        wBox(4),
                        Text(
                          "4.5/5",
                          style: AppFontStyle.text_14_400(AppColors.lightText),
                        ),
                        wBox(4),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.pharmacyVendorReview);
                          },
                          child: Text(
                            "(120 Reviews)",
                            style:
                                AppFontStyle.text_12_400(AppColors.lightText),
                          ),
                        ),
                      ],
                    ),
                    hBox(10),
                    CustomElevatedButton(
                        height: 40.h,
                        onPressed: () {},
                        child: const Text("Favorite Shop"))
                  ],
                ),
              ),
            ],
          ),
        ),
        hBox(15),
        Row(
          children: [
            const Icon(Icons.person_outline_rounded),
            wBox(8),
            Text(
              "John Doe",
              style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary),
            )
          ],
        ),
        hBox(10),
        Row(
          children: [
            const Icon(Icons.mail_outline_rounded),
            wBox(8),
            Text(
              "restaurants@gmail.com",
              style: AppFontStyle.text_14_400(AppColors.darkText),
            )
          ],
        ),
        hBox(10),
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            wBox(8),
            Text(
              "Greenfield, Abc Manchester, 199",
              style: AppFontStyle.text_14_400(AppColors.darkText),
            )
          ],
        ),
      ],
    );
  }

  Widget categoriesList() {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        itemCount: detailCategories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (c, i) {
          // bool isSelected = i == selectedIndex.value;
          return Obx(
            () => InkWell(
              onTap: () {
                selectedIndex.value = i;
              },
              child: Text(
                detailCategories[i],
                style: AppFontStyle.text_14_400(selectedIndex.value == i
                    ? AppColors.primary
                    : AppColors.lightText),
              ),
            ),
          );
        },
        separatorBuilder: (c, i) => wBox(20.w),
      ),
    );
  }

  // Widget itemsGrid() {
  //   return const CustomGridView();
  // }
}
