import 'package:woye_user/core/utils/app_export.dart';

class PromoCodes extends StatelessWidget {
  const PromoCodes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: false,
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
            promoCodeList(),
          ],
        ),
      ),
    );
  }

  Widget promoCodeList() {
    return ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                    color: AppColors.navbar,
                    borderRadius: BorderRadius.circular(15.r)),
                child: Padding(
                  padding: REdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Container(
                        height: 80.h,
                        width: 80.w,
                        // padding: const EdgeInsets.symmetric(
                        //     horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            color: index % 2 == 0
                                ? AppColors.primary
                                : AppColors.black,
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${(index * 5 + 10)}",
                                    style: AppFontStyle.text_34_600(
                                        Colors.white,
                                        height: 1.h),
                                  ),
                                  Text(
                                    "%",
                                    style: AppFontStyle.text_16_400(
                                        Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Text(
                              "OFF",
                              style: AppFontStyle.text_16_400(Colors.white),
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
                              style: AppFontStyle.text_14_400(
                                  AppColors.lightText),
                            ),
                            hBox(10),
                            FittedBox(
                              child: Text(
                                "PROCODE2024",
                                overflow: TextOverflow.ellipsis,
                                style: AppFontStyle.text_16_400(
                                    AppColors.darkText,
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
                                style: AppFontStyle.text_12_400(
                                    AppColors.lightText),
                              ),
                            ),
                            hBox(8),
                            CustomElevatedButton(
                                textStyle:
                                    AppFontStyle.text_14_600(Colors.white),
                                width: 85.w,
                                height: 40.h,
                                text: "Apply",
                                onPressed: () {})
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => hBox(20),
          );
  }
}
