import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/help/sub_screens/support/supports_controller.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});
  static final SupportsController supportsController =
      Get.put(SupportsController());
  @override
  Widget build(BuildContext context) {
    RxList supportsPages =
        [activeList(), closedList(), staredList(), allList()].obs;
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Support",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          slivers: [
            searchBar(),
            SliverToBoxAdapter(
              child: hBox(10),
            ),
            supportTypes(),
            // SliverToBoxAdapter(
            //   child: hBox(20),
            // ),
            SliverFillRemaining(
              child: Obx(
                () => IndexedStack(
                  //  children: supportsPages.obs,
                )
                // CustomScrollView(
                //   slivers: [
                //     if (supportsController.selectedIndex.value == 0)
                //       activeList(),
                //     if (supportsController.selectedIndex.value == 1)
                //       closedList(),
                //     if (supportsController.selectedIndex.value == 2)
                //       staredList(),
                //     if (supportsController.selectedIndex.value == 3) allList(),
                //   ],
                // ),
              ),
            ),
            SliverToBoxAdapter(
              child: hBox(100),
            )
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: false,
      snap: true,
      floating: true,
      expandedHeight: 70.h,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: REdgeInsets.only(bottom: 15),
        title: SizedBox(
          height: 35.h,
          child: (CustomSearchFilter(
            filterIcon: Icon(
              Icons.add_sharp,
              size: 16,
              color: AppColors.white,
            ),
            filterColor: AppColors.primary,
            onFilterTap: () {
              // Get.toNamed(AppRoutes.restaurantCategoriesFilter);
            },
          )),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget supportTypes() {
    List supportTypesList = ["Active", "Closed", "Stared", "All"];
    return SliverToBoxAdapter(
      child: Obx(
        () => Column(
          children: [
            Row(
                children: List.generate(4, (i) {
              bool isSelected = supportsController.selectedIndex.value == i;
              return InkWell(
                onTap: () {
                  supportsController.selectedIndex.value = i;
                },
                child: IntrinsicWidth(
                  child: Column(
                    children: [
                      Text(
                        supportTypesList[i],
                        style: AppFontStyle.text_16_500(
                          isSelected ? AppColors.primary : AppColors.mediumText,
                        ),
                      ).paddingOnly(right: 20.w),
                      Divider(
                        color:
                            isSelected ? AppColors.primary : Colors.transparent,
                        thickness: 3,
                        endIndent: 20,
                      ),
                    ],
                  ),
                ),
              );
            })),
            hBox(20),
          ],
        ),
      ),
    );
  }

  Widget activeList() {
    return SliverList.separated(
      itemCount: 10,
      itemBuilder: (c, i) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.asset(
                  "assets/images/profile-image.png",
                  height: 50.h,
                  width: 50.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            wBox(15),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "John Deo",
                        style: AppFontStyle.text_14_400(
                          AppColors.darkText,
                        ),
                      ),
                      Text(
                        "12 jan",
                        style: AppFontStyle.text_14_400(AppColors.lightText),
                      )
                    ],
                  ),
                  hBox(10),
                  Text(
                    "Unable to select currency when order",
                    overflow: TextOverflow.visible,
                    style: AppFontStyle.text_16_600(AppColors.darkText),
                  ),
                  hBox(5),
                  Text(
                    "Hello team, I am facing problem as i  can not select currency on buy order",
                    overflow: TextOverflow.visible,
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  ),
                  hBox(10),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (c, i) => Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: const Divider(),
      ),
    );
  }

  Widget closedList() {
    return SliverList.separated(
      itemCount: 10,
      itemBuilder: (c, i) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.asset(
                  "assets/images/profile-image.png",
                  height: 50.h,
                  width: 50.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            wBox(15),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "John Deo",
                        style: AppFontStyle.text_14_400(
                          AppColors.darkText,
                        ),
                      ),
                      Text(
                        "12 jan",
                        style: AppFontStyle.text_14_400(AppColors.red),
                      )
                    ],
                  ),
                  hBox(10),
                  Text(
                    "Unable to select currency when order",
                    overflow: TextOverflow.visible,
                    style: AppFontStyle.text_16_600(AppColors.darkText),
                  ),
                  hBox(5),
                  Text(
                    "Hello team, I am facing problem as i  can not select currency on buy order",
                    overflow: TextOverflow.visible,
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  ),
                  hBox(10),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (c, i) => Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: const Divider(),
      ),
    );
  }

  Widget staredList() {
    return SliverList.separated(
      itemCount: 10,
      itemBuilder: (c, i) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.asset(
                  "assets/images/profile-image.png",
                  height: 50.h,
                  width: 50.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            wBox(15),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "John Deo",
                        style: AppFontStyle.text_14_400(
                          AppColors.darkText,
                        ),
                      ),
                      Text(
                        "12 jan",
                        style: AppFontStyle.text_14_400(AppColors.lightText),
                      )
                    ],
                  ),
                  hBox(10),
                  Text(
                    "Unable to select currency when order",
                    overflow: TextOverflow.visible,
                    style: AppFontStyle.text_16_600(AppColors.darkText),
                  ),
                  hBox(5),
                  Text(
                    "Hello team, I am facing problem as i  can not select currency on buy order",
                    overflow: TextOverflow.visible,
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  ),
                  hBox(10),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (c, i) => Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: const Divider(),
      ),
    );
  }

  Widget allList() {
    return SliverList.separated(
      itemCount: 10,
      itemBuilder: (c, i) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: Image.asset(
                  "assets/images/profile-image.png",
                  height: 50.h,
                  width: 50.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            wBox(15),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "John Deo",
                        style: AppFontStyle.text_14_400(
                          AppColors.darkText,
                        ),
                      ),
                      Text(
                        "12 jan",
                        style: AppFontStyle.text_14_400(AppColors.lightText),
                      )
                    ],
                  ),
                  hBox(10),
                  Text(
                    "Unable to select currency when order",
                    overflow: TextOverflow.visible,
                    style: AppFontStyle.text_16_600(AppColors.darkText),
                  ),
                  hBox(5),
                  Text(
                    "Hello team, I am facing problem as i  can not select currency on buy order",
                    overflow: TextOverflow.visible,
                    style: AppFontStyle.text_14_400(AppColors.darkText),
                  ),
                  hBox(10),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (c, i) => Padding(
        padding: REdgeInsets.symmetric(vertical: 10),
        child: const Divider(),
      ),
    );
  }
}
