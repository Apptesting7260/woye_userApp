import 'package:woye_user/Core/Utils/app_export.dart';

class CustomGridView extends StatelessWidget {
  final int? itemCount;
  final String? price;
  final String? priceBefore;
  final String? description;
  final String? quantity;

  final String? image;
  final double? imageHeight;
  final VoidCallback? onTap;
  const CustomGridView(
      {super.key,
      this.image,
      this.onTap,
      this.imageHeight,
      this.price,
      this.priceBefore,
      this.description,
      this.quantity,
      this.itemCount});

  @override
  Widget build(BuildContext context) {
    RxBool isFavorite = false.obs;
    IconData favorite = Icons.favorite;
    IconData favoriteNot = Icons.favorite_border_outlined;
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount ?? 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65.h,
          crossAxisSpacing: 16.w,
          mainAxisSpacing: 5.h,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        padding: REdgeInsets.all(25),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.greyBackground.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Image.asset(
                          image ?? "assets/images/tablet.png",
                          height: imageHeight ?? 160.h,
                          width: Get.width,
                          fit: BoxFit.cover,
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
                                size: 18,
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
                    description ?? "Azithral XP 150mg...",
                    textAlign: TextAlign.left,
                    style: AppFontStyle.text_16_400(AppColors.darkText),
                  ),
                  // hBox(10),
                  Text(
                    quantity ?? "The Pizza Hub And Restaurant",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppFontStyle.text_14_300(AppColors.lightText),
                  ),
                  // hBox(10),
                ],
              ));
        });
  }
}
