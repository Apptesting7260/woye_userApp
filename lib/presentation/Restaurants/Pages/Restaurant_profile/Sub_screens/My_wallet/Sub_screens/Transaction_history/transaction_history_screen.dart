import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Transaction History",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          slivers: [
            searchFilter(),
            // const CustomSliverAppBar(),
            transactionList(),
            SliverToBoxAdapter(
              child: hBox(100),
            )
          ],
        ),
      ),
    );
  }

  Widget searchFilter() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      snap: true,
      floating: true,
      expandedHeight: 80.h,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      flexibleSpace: FlexibleSpaceBar(
        title: SizedBox(
          height: 34.h,
          child: (CustomSearchFilter(
            searchIocnPadding: REdgeInsets.all(8),
            searchIconHeight: 16.h,
            hintStyle: AppFontStyle.text_10_400(AppColors.hintText),
            textStyle: AppFontStyle.text_10_400(AppColors.darkText),
            prefixConstraints: BoxConstraints(
              maxHeight: 18.h,
            ),
            prefix: Padding(
              padding: REdgeInsets.only(left: 15, right: 5, bottom: 1),
              child: SvgPicture.asset(
                "assets/svg/search.svg",
                height: 12,
              ),
            ),
            padding: REdgeInsets.only(top: 10, bottom: 10),
            onFilterTap: () {
              Get.toNamed(AppRoutes.myWalletFilter);
            },
          )),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget transactionList() {
    return SliverToBoxAdapter(
        child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 21,
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
                          style: AppFontStyle.text_14_600(AppColors.darkText),
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
                          style: AppFontStyle.text_12_400(AppColors.lightText),
                        ),
                        Text(
                          debited ? "Refund" : "Orders",
                          style: AppFontStyle.text_12_400(AppColors.lightText),
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
    ));
  }
}
