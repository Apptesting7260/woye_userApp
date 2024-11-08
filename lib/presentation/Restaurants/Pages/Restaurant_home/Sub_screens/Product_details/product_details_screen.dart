import 'package:woye_user/Shared/Widgets/custom_radio_button_reverse.dart';
import 'package:woye_user/core/utils/app_export.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  const ProductDetailsScreen(
      {super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    String mainBanner = image;
    String title = this.title;
    RxInt sizeValue = 1.obs;
    List sizeData = [
      {"title": "Small", "price": "\$18.00"},
      {"title": "Medium", "price": "\$22.00"},
      {"title": "Large", "price": "\$28.00"},
    ];
    RxInt baseSectionValue = 1.obs;
    List baseSectionData = [
      {"title": "White Base", "price": "\$5.00"},
      {"title": "Cheese Burst", "price": "\$7.00"},
      {"title": "Cheese Burst", "price": "\$8.00"},
    ];
    RxInt addOnValue = 1.obs;
    List addOnData = [
      {"title": "Capsicum", "price": "\$1.00"},
      {"title": "Tomato", "price": "\$2.00"},
      {"title": "Onion", "price": "\$3.00"},
      {"title": "Extra Cheese", "price": "\$4.00"},
      {"title": "Golden Corn", "price": "\$5.00"},
      {"title": "Red Paprika", "price": "\$6.00"},
      {"title": "Capsicum", "price": "\$1.00"},
      {"title": "Tomato", "price": "\$2.00"},
      {"title": "Onion", "price": "\$3.00"},
    ];

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
            mainContainer(mainBanner, title),
            hBox(30),
            description(),
            hBox(30),
            size(
                context: context,
                radioGroupValue: sizeValue,
                jsonData: sizeData),
            hBox(30),
            baseSection(
                context: context,
                radioGroupValue: baseSectionValue,
                jsonData: baseSectionData),
            hBox(30),
            addOn(
                context: context,
                radioGroupValue: addOnValue,
                jsonData: addOnData),
            hBox(30),
            CustomElevatedButton(
                width: Get.width,
                color: AppColors.darkText,
                text: "Add to Cart",
                onPressed: () {}),
            hBox(30),
            productReviews(),
            hBox(8),
            const Divider(),
            hBox(30),
            reviews(),
            hBox(30),
            moreProducts(),
            hBox(20),
          ],
        ),
      ),
    );
  }

  Widget mainContainer(String mainBanner, String title) {
    RxInt cartCount = 1.obs;
    // RxBool isSelected = false.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            mainBanner,
            height: 340.h,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
        hBox(10),
        Text(
          "Pizza",
          style: AppFontStyle.text_16_400(AppColors.primary),
        ),
        hBox(10),
        Text(
          title,
          style: AppFontStyle.text_20_400(AppColors.darkText),
        ),
        hBox(10),
        Row(
          children: [
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
              "\$18.00",
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
        )
      ],
    );
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
          style: AppFontStyle.text_16_400(AppColors.lightText, height: 1.4),
        ),
      ],
    );
  }

  Widget size({context, radioGroupValue, jsonData}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Size",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jsonData.length,
          itemBuilder: (context, index) {
            final data = jsonData[index];
            return CustomTitleRadioButton(
                title: data["title"],
                value: index.obs,
                groupValue: radioGroupValue,
                onChanged: (value) {
                  radioGroupValue.value = value!;
                },
                priceValue: data["price"]);
          },
          separatorBuilder: (context, inxex) => hBox(8),
        ),
      ],
    );
  }

  Widget baseSection({context, radioGroupValue, jsonData}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Base Bread Section",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(10),
        Row(
          children: [
            Text(
              "Required",
              style: AppFontStyle.text_16_300(AppColors.lightText),
            ),
            Text(
              "•",
              style: AppFontStyle.text_16_300(AppColors.lightText),
            ),
            wBox(4),
            Text(
              "Select any 1 option",
              style: AppFontStyle.text_16_300(AppColors.lightText),
            ),
          ],
        ),
        hBox(10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: jsonData.length,
          itemBuilder: (context, index) {
            final data = jsonData[index];
            return CustomTitleRadioButton(
                title: data["title"],
                value: index.obs,
                groupValue: radioGroupValue,
                onChanged: (value) {
                  radioGroupValue.value = value!;
                },
                priceValue: data["price"]);
          },
          separatorBuilder: (context, inxex) => hBox(8),
        ),
      ],
    );
  }

  Widget addOn({context, radioGroupValue, jsonData}) {
    RxBool showAll = false.obs;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Base Bread Section",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(10),
        Row(
          children: [
            Text(
              "Required",
              style: AppFontStyle.text_16_300(AppColors.lightText),
            ),
            Text(
              "•",
              style: AppFontStyle.text_16_300(AppColors.lightText),
            ),
            wBox(4),
            Text(
              "Select any 1 option",
              style: AppFontStyle.text_16_300(AppColors.lightText),
            ),
          ],
        ),
        hBox(10),
        Obx(
          () => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: showAll.value ? jsonData.length : 5,
            itemBuilder: (context, index) {
              final data = jsonData[index];
              return CustomTitleRadioButton(
                  title: data["title"],
                  value: index.obs,
                  groupValue: radioGroupValue,
                  onChanged: (value) {
                    radioGroupValue.value = value!;
                  },
                  priceValue: data["price"]);
            },
            separatorBuilder: (context, inxex) => hBox(8),
          ),
        ),
        hBox(10),
        Obx(
          () => InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              showAll.value = !showAll.value;
            },
            child: showAll.value
                ? Row(
                    children: [
                      Text(
                        "Hide",
                        style: AppFontStyle.text_16_600(AppColors.primary),
                      ),
                      Icon(
                        Icons.keyboard_arrow_up_sharp,
                        color: AppColors.primary,
                        size: 30.h,
                      )
                    ],
                  )
                : Row(
                    children: [
                      // Text(
                      //   "+",
                      //   style: AppFontStyle.text_18_600(AppColors.primary),
                      // ),
                      Text(
                        "Show More",
                        style: AppFontStyle.text_16_600(AppColors.primary),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: AppColors.primary,
                        size: 30.h,
                      )
                    ],
                  ),
          ),
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
            Get.toNamed(AppRoutes.productReviews);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "See All (20)",
                style: AppFontStyle.text_14_400(AppColors.primary),
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
              "More Products",
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.moreProducts);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "See All",
                    style: AppFontStyle.text_16_400(AppColors.primary),
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
        hBox(10),
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 2,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6.h,
              crossAxisSpacing: 14.w,
              mainAxisSpacing: 5.h,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    Get.to(ProductDetailsScreen(
                        image: "assets/images/cat-image${index % 5}.png",
                        title: "McMushroom Pizza"));
                  },
                  child: CustomItemBanner(index: index));
            })
      ],
    );
  }
}
