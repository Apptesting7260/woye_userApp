import 'package:woye_user/core/utils/app_export.dart';

class CustomBanner extends StatelessWidget {
  int index;

  final String? price;
  final String? priceBefore;
  final String? title;
  final String? quantity;

  final String? imageAddress;

  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  CustomBanner(
      {super.key,
      this.index = 0,
      this.imageAddress,
      this.padding,
      this.backgroundColor,
      this.price,
      this.priceBefore,
      this.title,
      this.quantity});

  @override
  Widget build(BuildContext context) {
    RxBool isFavorite = false.obs;
    IconData favorite = Icons.favorite;
    IconData favoriteNot = Icons.favorite_border_outlined;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              padding: padding,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: backgroundColor),
              child: Center(
                child: Image.asset(
                  imageAddress ?? "assets/images/cat-image${index % 5}.png",
                  height: 160.h,
                  width: Get.width,
                  fit: BoxFit.cover,
                  // width: Get.width,
                ),
              ),
            ),
            Obx(
              () => Container(
                  margin: REdgeInsets.only(top: 10, right: 10),
                  padding: REdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColors.greyBackground),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      isFavorite.value = !isFavorite.value;
                    },
                    child: Icon(
                      isFavorite.value ? favorite : favoriteNot,
                      // Icons.favorite_border_outlined,
                      size: 22,
                    ),
                  )),
            )
          ],
        ),
        hBox(10),
        Row(
          children: [
            Text(
              price ?? "\$18.00",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_600(AppColors.primary),
            ),
            wBox(5),
            Text(
              priceBefore ?? "\$20",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,

              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: AppColors.lightText,
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColors.lightText),

              //  AppFontStyle.text_14_300(AppColors.lightText),
            ),
          ],
        ),
        // hBox(10),
        Text(
          title ?? "Azithral XP 150mg...",
          textAlign: TextAlign.left,
          style: AppFontStyle.text_14_500(AppColors.darkText),
        ),
        // hBox(10),
        Text(
          quantity ?? "Strip of 10 tablets",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppFontStyle.text_14_400(AppColors.lightText),
        ),
        // hBox(10),
      ],
    );
  }
}
