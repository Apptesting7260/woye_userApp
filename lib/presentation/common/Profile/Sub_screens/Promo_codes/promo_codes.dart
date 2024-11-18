import 'package:woye_user/core/utils/app_export.dart';

class PromoCodes extends StatelessWidget {
  const PromoCodes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        isActions: true,
        title: Text(
          "Promotion code",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            restaurantPromoCodeList(),
          ],
        ),
      ),
    );
  }

  Widget restaurantPromoCodeList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          padding: REdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: AppColors.navbar.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.r)),
          child: Row(
            children: [
              Container(
                // height: 70.h,
                // width: 70.w,
                padding: REdgeInsets.symmetric(vertical: 10, horizontal: 14),

                decoration: BoxDecoration(
                    color: index % 2 == 0 ? AppColors.primary : AppColors.black,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${(index * 5 + 10)}",
                            style: AppFontStyle.text_30_600(Colors.white,
                                height: 1.h),
                          ),
                          Text(
                            "%",
                            style: AppFontStyle.text_16_400(Colors.white),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "OFF",
                      style: AppFontStyle.text_15_400(Colors.white),
                    )
                  ],
                ),
              ),
              wBox(10),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal offer",
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.text_13_400(AppColors.lightText),
                    ),
                    hBox(10),
                    FittedBox(
                      child: Text(
                        "PROCODE2024",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_15_400(AppColors.darkText,
                            height: 1.h),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      child: Text(
                        "6 days remaining",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_12_400(AppColors.lightText),
                      ),
                    ),
                    hBox(8),
                    CustomElevatedButton(
                        textStyle:
                            AppFontStyle.text_13_400(Colors.white, height: 1.0),
                        width: 85.w,
                        height: 36.h,
                        text: "Apply",
                        onPressed: () {
                          Get.back();
                        })
                  ],
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => hBox(20),
    );
  }

  Widget pharmacyPromoCodeList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          padding: REdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: AppColors.navbar.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.r)),
          child: Row(
            children: [
              Container(
                // height: 70.h,
                // width: 70.w,
                padding: REdgeInsets.symmetric(vertical: 10, horizontal: 14),

                decoration: BoxDecoration(
                    color: index % 2 == 0 ? AppColors.primary : AppColors.black,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${(index * 5 + 10)}",
                            style: AppFontStyle.text_30_600(Colors.white,
                                height: 1.h),
                          ),
                          Text(
                            "%",
                            style: AppFontStyle.text_16_400(Colors.white),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "OFF",
                      style: AppFontStyle.text_15_400(Colors.white),
                    )
                  ],
                ),
              ),
              wBox(10),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal offer",
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.text_13_400(AppColors.lightText),
                    ),
                    hBox(10),
                    FittedBox(
                      child: Text(
                        "PROCODE2024",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_15_400(AppColors.darkText,
                            height: 1.h),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      child: Text(
                        "6 days remaining",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_12_400(AppColors.lightText),
                      ),
                    ),
                    hBox(8),
                    CustomElevatedButton(
                        textStyle:
                            AppFontStyle.text_13_400(Colors.white, height: 1.0),
                        width: 85.w,
                        height: 36.h,
                        text: "Apply",
                        onPressed: () {})
                  ],
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => hBox(20),
    );
  }

  Widget groceryPromoCodeList() {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          padding: REdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: AppColors.navbar.withOpacity(0.5),
              borderRadius: BorderRadius.circular(15.r)),
          child: Row(
            children: [
              Container(
                // height: 70.h,
                // width: 70.w,
                padding: REdgeInsets.symmetric(vertical: 10, horizontal: 14),

                decoration: BoxDecoration(
                    color: index % 2 == 0 ? AppColors.primary : AppColors.black,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${(index * 5 + 10)}",
                            style: AppFontStyle.text_30_600(Colors.white,
                                height: 1.h),
                          ),
                          Text(
                            "%",
                            style: AppFontStyle.text_16_400(Colors.white),
                          )
                        ],
                      ),
                    ),
                    Text(
                      "OFF",
                      style: AppFontStyle.text_15_400(Colors.white),
                    )
                  ],
                ),
              ),
              wBox(10),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal offer",
                      overflow: TextOverflow.ellipsis,
                      style: AppFontStyle.text_13_400(AppColors.lightText),
                    ),
                    hBox(10),
                    FittedBox(
                      child: Text(
                        "PROCODE2024",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_15_400(AppColors.darkText,
                            height: 1.h),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FittedBox(
                      child: Text(
                        "6 days remaining",
                        overflow: TextOverflow.ellipsis,
                        style: AppFontStyle.text_12_400(AppColors.lightText),
                      ),
                    ),
                    hBox(8),
                    CustomElevatedButton(
                        textStyle:
                            AppFontStyle.text_13_400(Colors.white, height: 1.0),
                        width: 85.w,
                        height: 36.h,
                        text: "Apply",
                        onPressed: () {})
                  ],
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => hBox(20),
    );
  }
}
