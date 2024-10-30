import 'package:woye_user/Presentation/Restaurants/Sub_screens/Product_details/product_details_screen.dart';
import 'package:woye_user/core/utils/app_export.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  const RestaurantDetailsScreen(
      {super.key, required this.title, required this.image});

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
            openHours(),
            hBox(30),
            description(),
            hBox(30),
            moreProducts(context),
            hBox(30),
          ],
        ),
      ),
    );
  }

  Widget mainBanner(String mainBannerImage, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Image.asset(
            // "assets/images/rk.jpg",
            mainBannerImage,
            height: 250,
            width: Get.width,
            fit: BoxFit.cover,
          ),
        ),
        hBox(15),
        Text(
          title,
          style: AppFontStyle.text_24_400(AppColors.darkText),
        ),
        hBox(15),
        Row(
          children: [
            Text(
              "32min",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            wBox(4),
            Text(
              "•",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            wBox(4),
            Text(
              "2km",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            wBox(4),
            Text(
              "•",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
            wBox(4),
            SvgPicture.asset("assets/svg/star-yellow.svg"),
            wBox(4),
            Text(
              "4.5/5",
              style: AppFontStyle.text_14_400(AppColors.lightText),
            ),
          ],
        ),
        hBox(20),
        Row(
          children: [
            Icon(Icons.person_outline_rounded),
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
            Icon(Icons.mail_outline_rounded),
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
            Icon(Icons.location_on_outlined),
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

  Widget openHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Open Hours",
          style: AppFontStyle.text_20_600(AppColors.darkText),
        ),
        hBox(14),
        SizedBox(
          width: Get.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tuesday",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
              Text(
                "10 AM - 11 PM",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
            ],
          ),
        ),
        hBox(10),
        SizedBox(
          width: Get.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Wednesday",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
              Text(
                "10 AM - 11 PM",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
            ],
          ),
        ),
        hBox(10),
        SizedBox(
          width: Get.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Thursday",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
              Text(
                "10 AM - 11 PM",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
            ],
          ),
        ),
        hBox(10),
        SizedBox(
          width: Get.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Friday",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
              Text(
                "10 AM - 11 PM",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
            ],
          ),
        ),
        hBox(10),
        SizedBox(
          width: Get.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Saturday",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
              Text(
                "10 AM - 11 PM",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
            ],
          ),
        ),
        hBox(10),
        SizedBox(
          width: Get.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sunday",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
              Text(
                "10 AM - 11 PM",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
            ],
          ),
        ),
        hBox(10),
        SizedBox(
          width: Get.width * 0.70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Monday",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
              Text(
                "10 AM - 11 PM",
                style: AppFontStyle.text_16_400(AppColors.lightText),
              ),
            ],
          ),
        ),
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
          style: AppFontStyle.text_16_400(AppColors.lightText),
        ),
      ],
    );
  }

  Widget moreProducts(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "More Products",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
        hBox(15),
        // MoreProducts().productList()
        GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
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
