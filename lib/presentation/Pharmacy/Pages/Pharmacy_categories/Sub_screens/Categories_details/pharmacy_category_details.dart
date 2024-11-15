import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class PharmacyCategoryDetails extends StatelessWidget {
  PharmacyCategoryDetails({super.key});

  static final List detailCategories = [
    "All",
    "Acidity",
    "Bloating",
    "Constipation",
    "Indigestions"
  ];
  RxInt selectedIndex = 0.obs;
  // int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var title = Get.arguments ?? "Your Item";

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          title,
          style: AppFontStyle.text_22_600(
            AppColors.darkText,
          ),
        ),
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: false,
              snap: true,
              floating: true,
              expandedHeight: 70.h,
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: REdgeInsets.only(bottom: 15),
                title: SizedBox(
                  height: 35.h,
                  child: (CustomSearchFilter(
                    onFilterTap: () {
                      Get.toNamed(AppRoutes.pharmacyCategoryFilter);
                    },
                  )),
                ),
                centerTitle: true,
              ),
            ),
            SliverToBoxAdapter(
              child: hBox(10),
            ),
            categoriesList(),
            itemGrid(),
            SliverToBoxAdapter(
              child: hBox(50),
            )
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter categoriesList() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView.separated(
          itemCount: detailCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (c, i) {
            // bool isSelected = i == selectedIndex.value;
            return Obx(
              () => InkWell(
                onTap: () {
                  selectedIndex.value = i;
                },
                child: Text(
                  detailCategories[i],
                  style: AppFontStyle.text_14_400(selectedIndex.value == i
                      ? AppColors.primary
                      : AppColors.lightText),
                ),
              ),
            );
          },
          separatorBuilder: (c, i) => wBox(20.w),
        ),
      ),
    );
  }

  SliverToBoxAdapter itemGrid() {
    return SliverToBoxAdapter(
      child: CustomGridView(),
    );
  }
}
