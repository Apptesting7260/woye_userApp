import 'package:woye_user/Core/Utils/app_export.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Product Reviews",
          style: AppFontStyle.text_24_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [productReviews(), hBox(30), reviews(), hBox(50)],
        ),
      ),
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
    // RxBool showAll = false.obs;

    return Column(
      children: [
        Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 20,
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
      ],
    );
  }
}
