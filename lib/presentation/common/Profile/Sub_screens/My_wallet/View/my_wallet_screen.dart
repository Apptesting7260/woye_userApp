import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/Shared/Widgets/CircularProgressIndicator.dart';
import 'package:woye_user/Shared/theme/font_family.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/My_wallet/wallet_controller/wallet_controller.dart';

class MyWalletScreen extends StatelessWidget {
  MyWalletScreen({super.key});

  final UserWalletController controller = Get.put(UserWalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "My Wallet",
          style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
        ),
      ),
      body: Obx(() {
        switch (controller.rxRequestStatus.value) {
          case Status.LOADING:
            return Center(child: circularProgressIndicator());
          case Status.ERROR:
            if (controller.error.value == 'No internet' || controller.error.value == 'InternetExceptionWidget') {
              return InternetExceptionWidget(
                onPress: () {
                  controller.refreshUserWalletApi();
                },
              );
            } else {
              return GeneralExceptionWidget(
                onPress: () {
                  controller.refreshUserWalletApi();
                },
              );
            }
          case Status.COMPLETED:
            return RefreshIndicator(
              onRefresh: () async {
                controller.refreshUserWalletApi();
              },
              child: SingleChildScrollView(
                padding: REdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    balance(),
                    hBox(20),
                    if (controller
                        .userWalletData.value.transactionDetails!.isNotEmpty)
                      transactionHistory(),
                    hBox(50)
                  ],
                ),
              ),
            );
        }
      }),
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
            "Credit Balance ",
            style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.gilroyMedium),
          ),
          hBox(10),
          Text(
            "\$${controller.userWalletData.value.currentBalance}",
            style: AppFontStyle.text_24_600(AppColors.primary,family: AppFontFamily.gilroyRegular),
          ),
        ],
      ),
    );
  }

  Widget transactionHistory() {
    return Column(
      children: [
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text(
        //       "Transaction History",
        //       style: AppFontStyle.text_20_600(AppColors.darkText),
        //     ),
        //     InkWell(
        //       splashColor: Colors.transparent,
        //       hoverColor: Colors.transparent,
        //       onTap: () {
        //         Get.toNamed(AppRoutes.transactionHistory);
        //       },
        //       child: Row(
        //         children: [
        //           Text(
        //             "See All",
        //             style: AppFontStyle.text_14_600(AppColors.primary),
        //           ),
        //           wBox(4),
        //           Icon(
        //             Icons.arrow_forward_sharp,
        //             color: AppColors.primary,
        //             size: 16.h,
        //           )
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        // hBox(20),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.userWalletData.value.transactionDetails!.length,
          itemBuilder: (c, index) {
            // bool debited = false;
            // if (i % 3 == 0) {
            //   debited = true;
            // }
            var data =
                controller.userWalletData.value.transactionDetails![index];
            return SizedBox(
              width: Get.width,
              child: Row(
                children: [
                  Expanded(
                      flex: 3,
                      child:
                          // debited
                          //     ?
                          Container(
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      AppColors.lightPrimary.withOpacity(0.1)),
                              child: SvgPicture.asset(
                                "assets/svg/wallet.svg",
                                height: 20,
                              ))
                      //     :

                      // Container(
                      //         decoration: BoxDecoration(
                      //           borderRadius: BorderRadius.circular(4.r),
                      //         ),
                      //         child: Image.asset(
                      //           "assets/images/coffee.png",
                      //           height: 40.h,
                      //           // width: 15,
                      //         )),
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
                              data.productName.toString(),
                              style:
                                  AppFontStyle.text_14_600(AppColors.darkText),
                            ),
                            Text(
                              data.amount.toString(),
                              style: AppFontStyle.text_12_600(
                                  data.transactionType.toString() == "Order"
                                      ? AppColors.red
                                      : AppColors.primary),
                            ),
                          ],
                        ),
                        hBox(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.transactionDate.toString(),
                              style:
                                  AppFontStyle.text_12_400(AppColors.lightText),
                            ),
                            Text(
                              data.transactionType.toString(),
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
            return hBox(20.h);
          },
        )
      ],
    );
  }
}
