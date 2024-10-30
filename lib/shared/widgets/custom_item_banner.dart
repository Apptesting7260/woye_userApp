import 'package:woye_user/core/utils/app_export.dart';

class CustomItemBanner extends StatelessWidget {
  final int index;
  const CustomItemBanner({super.key, required this.index});

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
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Image.asset(
                // "assets/images/rk.jpg",
                "assets/images/cat-image${index % 5}.png",
                height: 160.h,
                width: Get.width,
                fit: BoxFit.cover,
                // width: Get.width,
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
              "\$18.00",
              textAlign: TextAlign.left,
              style: AppFontStyle.text_16_600(AppColors.primary),
            ),
            wBox(5),
            Text(
              "\$20",
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
          "McMushroom Pizza",
          textAlign: TextAlign.left,
          style: AppFontStyle.text_16_400(AppColors.darkText),
        ),
        // hBox(10),
        Text(
          "The Pizza Hub And Restaurant",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: AppFontStyle.text_14_300(AppColors.lightText),
        ),
        // hBox(10),
        Row(
          children: [
            SvgPicture.asset("assets/svg/star-yellow.svg"),
            wBox(4),
            Text(
              "4.5/5",
              style: AppFontStyle.text_14_300(AppColors.lightText),
            ),
          ],
        )
      ],
    );
  }
}
