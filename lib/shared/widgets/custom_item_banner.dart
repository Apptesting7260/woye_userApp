import 'package:woye_user/core/utils/app_export.dart';

class CustomItemBanner extends StatelessWidget {
  final int index;
  const CustomItemBanner({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    RxBool isFavorite = false.obs;
    IconData favorite = Icons.favorite;
    IconData favoriteNot = Icons.favorite_border_outlined;
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Image.asset(
                  "assets/images/cat-image${index % 5}.png",
                  height: 160.h,
                  width: Get.width * 0.45,

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
          hBox(5),
          Row(
            children: [
              Text(
                "\$18.00",
                textAlign: TextAlign.left,
                style: AppFontStyle.text_16_600(AppColors.primary),
              ),
            ],
          ),
          Text(
            "McMushroom Pizza",
            textAlign: TextAlign.left,
            style: AppFontStyle.text_16_400(AppColors.darkText),
          ),
        ],
      ),
    );
  }
}
