import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Pharmacy/Pages/Pharmacy_home/Sub_screens/Vendor_details/pharmacy_vendor_details_screen.dart';
import 'package:woye_user/shared/widgets/custom_expansion_tile.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class GroceryProductDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  const GroceryProductDetailsScreen(
      {super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    RxInt selectedIndex = 0.obs;
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
          children: [
            mainBanner(mainBannerImage, title, selectedIndex),
            hBox(10),
            //
            titleAndDetails(),
            hBox(30),
            //
            description(),
            hBox(30),
            //
            shopCard(),
            hBox(20),
            //
            buttons(),
            hBox(30),
            //
            dropdownsSection(),
            hBox(30),
            //
            productReviews(),
            hBox(8),
            //
            const Divider(),
            hBox(30),
            //
            reviews(),
            hBox(30),
            //
            moreProducts(),
            hBox(20),
          ],
        ),
      ),
    );
  }

  Widget mainBanner(String mainBannerImage, String title, selectedIndex) {
    // RxBool isSelected = false.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            mainBannerImage,
            height: 340.h,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
        hBox(15),
        SizedBox(
          height: 70,
          width: Get.width,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, i) {
              return Obx(
                () => InkWell(
                  onTap: () {
                    selectedIndex.value = i;
                  },
                  child: Container(
                    padding: REdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: selectedIndex == i
                                ? AppColors.primary
                                : Colors.transparent)),
                    child: Image.asset(
                      mainBannerImage,
                      height: 50.h,
                      width: 50.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => wBox(20),
          ),
        ),
      ],
    );
  }

  Widget titleAndDetails() {
    RxInt cartCount = 1.obs;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Dairy",
        style: AppFontStyle.text_16_400(AppColors.primary),
      ),
      hBox(10),
      Text(
        title,
        overflow: TextOverflow.visible,
        style: AppFontStyle.text_18_600(
          AppColors.darkText,
        ),
      ),
      hBox(10),
      Row(
        children: [
          Text(
            "Strip of 10 tablets",
            style: AppFontStyle.text_14_400(AppColors.lightText),
          ),
          Text(
            " • ",
            style: AppFontStyle.text_14_400(AppColors.lightText),
          ),
          SvgPicture.asset("assets/svg/star-yellow.svg"),
          wBox(4),
          Text(
            "4.5/5",
            style: AppFontStyle.text_14_400(AppColors.lightText),
          ),
        ],
      ),
      hBox(10),
      Row(
        children: [
          Text(
            "Provided by",
            style: AppFontStyle.text_12_400(AppColors.lightText),
          ),
          wBox(5),
          ClipRRect(
            borderRadius: BorderRadius.circular(50.r),
            child: Image.asset(
              "assets/images/dairy-shop.jpg",
              height: 20.h,
              width: 20.h,
              fit: BoxFit.cover,
            ),
          ),
          wBox(5),
          Text(
            "(300 sold)",
            style: AppFontStyle.text_14_600(AppColors.darkText),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            "\$72.00",
            style: AppFontStyle.text_16_600(AppColors.primary),
          ),
          wBox(8),
          Text(
            "\$20.00",
            style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.mediumText,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.lineThrough,
                decorationColor: AppColors.mediumText),
          ),
          const Spacer(),
          Container(
            height: 40.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.r),
              border: Border.all(width: 0.8.w, color: AppColors.primary),
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (cartCount.value != 0) cartCount.value--;
                    },
                    child: Icon(
                      Icons.remove,
                      size: 16.w,
                    ),
                  ),
                  Text(
                    "${cartCount.value}",
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  ),
                  GestureDetector(
                    onTap: () {
                      cartCount.value++;
                    },
                    child: Icon(
                      Icons.add,
                      size: 16.w,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ]);
  }

  Widget description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Descriptions",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(10),
        Text(
          "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
          overflow: TextOverflow.visible,
          style: AppFontStyle.text_16_400(AppColors.lightText, height: 1.4),
        ),
      ],
    );
  }

  Widget shopCard() {
    return InkWell(
      onTap: () {
        Get.to(PharmacyVendorDetailsScreen(
            title: "Micro Labs Ltd", image: "assets/images/dairy-shop.jpg"));
      },
      child: Container(
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
                "assets/images/dairy-shop.jpg",
                height: 50.h,
              ),
            ),
            wBox(10),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Micro Labs Ltd",
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
                          style: AppFontStyle.text_12_400(AppColors.lightText),
                        ),
                      ),
                    ],
                  ),
                  hBox(10),
                  CustomOutlinedButton(
                      height: 40.h,
                      onPressed: () {},
                      child: const Text("Favorite Shop"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttons() {
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton(
              height: 50.h,
              width: Get.width,
              color: AppColors.darkText,
              text: "Add to Cart",
              onPressed: () {}),
        ),
        wBox(10),
        Expanded(
          child: CustomElevatedButton(
              height: 50.h,
              width: Get.width,
              text: "Buy now",
              onPressed: () {}),
        ),
      ],
    );
  }

  Widget dropdownsSection() {
    List dropdownTitles = [
      "How to Use?",
      "Usage, Direction and Dosage",
      "Interactions",
      "Side Effects",
      "Expert advice and Concern",
      "When not to use?",
      "General Instructions & Warnings",
      "Other Details"
    ];
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          itemCount: 8,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            RxBool isExpanded = false.obs;

            return Obx(
              () => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                          color: isExpanded.value == false
                              ? AppColors.textFieldBorder
                              : AppColors.darkText)),
                  child: CustomExpansionTile(
                      onExpansionChanged: (value) {
                        isExpanded.value = value;
                      },
                      title: dropdownTitles[i],
                      titleTextStyle:
                          AppFontStyle.text_16_600(AppColors.darkText),
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "•",
                                style: AppFontStyle.text_14_600(
                                    AppColors.darkText),
                              ),
                            ),
                            wBox(10),
                            Expanded(
                              flex: 39,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Missed Dose",
                                    style: AppFontStyle.text_14_600(
                                        AppColors.darkText),
                                  ),
                                  hBox(10),
                                  Text(
                                    "Lorem Ipsum has been the industry's text ever since the 1500s, when an unknown printer took a galley of type and  it to make a type specimen book.",
                                    overflow: TextOverflow.visible,
                                    style: AppFontStyle.text_14_400(
                                        AppColors.lightText),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        hBox(20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "•",
                                style: AppFontStyle.text_14_600(
                                    AppColors.darkText),
                              ),
                            ),
                            wBox(10),
                            Expanded(
                              flex: 39,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Overdose",
                                    style: AppFontStyle.text_14_600(
                                        AppColors.darkText),
                                  ),
                                  hBox(10),
                                  Text(
                                    "Lorem Ipsum has been the industry's text ever since the 1500s, when an unknown printer took a galley of type and  it to make a type specimen book.",
                                    overflow: TextOverflow.visible,
                                    style: AppFontStyle.text_14_400(
                                        AppColors.lightText),
                                  ),
                                  hBox(10)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ])),
            );
          },
          separatorBuilder: (context, index) => hBox(20),
        )
      ],
    );
  }

  Widget productReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Product Reviews",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(10),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              "assets/svg/star-yellow.svg",
              width: 15.w,
            ),
            SvgPicture.asset(
              "assets/svg/star-yellow.svg",
              width: 15.w,
            ),
            SvgPicture.asset(
              "assets/svg/star-yellow.svg",
              width: 15.w,
            ),
            SvgPicture.asset(
              "assets/svg/star-yellow.svg",
              fit: BoxFit.cover,
              width: 15.w,
            ),
            SvgPicture.asset(
              "assets/svg/star-white.svg",
            ),
            wBox(8),
            Text(
              "4.5/5",
              style: AppFontStyle.text_16_400(AppColors.darkText),
            ),
            wBox(8),
            Text(
              "(120 reviews)",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
          ],
        ),
      ],
    );
  }

  Widget reviews() {
    return Column(
      children: [
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: Image.asset(
                              "assets/images/profile-review.png",
                              height: 50.h,
                              width: 50.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        wBox(15),
                        Flexible(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ronald Richards",
                                style: AppFontStyle.text_16_400(
                                    AppColors.darkText),
                              ),
                              hBox(5),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/star-yellow.svg",
                                    width: 15.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/star-yellow.svg",
                                    width: 15.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/star-yellow.svg",
                                    width: 15.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/star-yellow.svg",
                                    fit: BoxFit.cover,
                                    width: 15.w,
                                  ),
                                  SvgPicture.asset(
                                    "assets/svg/star-white.svg",
                                  ),
                                ],
                              ),
                              hBox(10),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque malesuada eget vitae Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                                overflow: TextOverflow.visible,
                                style: AppFontStyle.text_16_400(
                                    AppColors.darkText),
                              ),
                              hBox(10),
                              Row(
                                children: [
                                  Text(
                                    "01-09-2024",
                                    style: AppFontStyle.text_16_400(
                                        AppColors.lightText),
                                  ),
                                  wBox(10),
                                  Text(
                                    "12:20",
                                    style: AppFontStyle.text_16_400(
                                        AppColors.lightText),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: REdgeInsets.symmetric(vertical: 10),
                      child: const Divider(),
                    ),
                  ],
                );
              },
              // separatorBuilder: (context, inxex) => Padding(
              //   padding: REdgeInsets.symmetric(vertical: 10),
              //   child: const Divider(),
              // ),
            ),
          ],
        ),
        hBox(10),
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Get.toNamed(AppRoutes.pharmacyProductReviews);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "See All (20)",
                style: AppFontStyle.text_14_600(AppColors.primary),
              ),
              Icon(
                Icons.arrow_forward,
                color: AppColors.primary,
                size: 20.h,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget moreProducts() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Similar Products",
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.pharmacyMoreProduct);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "See All",
                    style: AppFontStyle.text_14_600(AppColors.primary),
                  ),
                  wBox(4),
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: AppColors.primary,
                    size: 18,
                  )
                ],
              ),
            ),
          ],
        ),
        hBox(20),
        const CustomGridView(
          // itemCount: 2,
        )
      ],
    );
  }
}
