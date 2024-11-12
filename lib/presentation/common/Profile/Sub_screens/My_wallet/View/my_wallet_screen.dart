import 'package:woye_user/Core/Utils/app_export.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "My Wallet",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [balance(), hBox(20), transactionHistory(), hBox(50)],
        ),
      ),
    );
  }

  Widget balance() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.r),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: AppColors.lightPrimary.withOpacity(0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Credit balance ",
            style: AppFontStyle.text_16_400(AppColors.darkText),
          ),
          hBox(10),
          Text(
            "\$400.00 ",
            style: AppFontStyle.text_24_600(AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget transactionHistory() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Transaction History",
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            InkWell(
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                Get.toNamed(AppRoutes.transactionHistory);
              },
              child: Row(
                children: [
                  Text(
                    "See All",
                    style: AppFontStyle.text_14_600(AppColors.primary),
                  ),
                  wBox(4),
                  Icon(
                    Icons.arrow_forward_sharp,
                    color: AppColors.primary,
                    size: 16.h,
                  )
                ],
              ),
            ),
          ],
        ),
        hBox(20),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 13,
          itemBuilder: (c, i) {
            bool debited = false;
            if (i % 3 == 0) {
              debited = true;
            }
            return SizedBox(
              width: Get.width,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: debited
                        ? Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.lightPrimary.withOpacity(0.1)),
                            child: SvgPicture.asset(
                              "assets/svg/wallet.svg",
                              height: 20,
                            ))
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Image.asset(
                              "assets/images/coffee.png",
                              height: 40.h,
                              // width: 15,
                            )),
                  ),
                  wBox(10),
                  Expanded(
                    flex: 17,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nescafe Classic Coff...",
                              style:
                                  AppFontStyle.text_14_600(AppColors.darkText),
                            ),
                            Text(
                              debited ? "+\$100.00" : "-\$37.80",
                              style: AppFontStyle.text_12_600(
                                  debited ? AppColors.primary : AppColors.red),
                            ),
                          ],
                        ),
                        hBox(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mon, 04 Apr - 12:00 AM ",
                              style:
                                  AppFontStyle.text_12_400(AppColors.lightText),
                            ),
                            Text(
                              debited ? "Refund" : "Orders",
                              style:
                                  AppFontStyle.text_12_400(AppColors.lightText),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
          separatorBuilder: (c, i) {
            return hBox(20);
          },
        )
      ],
    );
  }
}
