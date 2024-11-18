import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class PharmacyCategoryDetails extends StatelessWidget {
  PharmacyCategoryDetails({super.key});

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
        child: DefaultTabController(
          length: 5,
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
                        Get.toNamed(AppRoutes.groceryCategoriesFilter);
                      },
                    )),
                  ),
                  centerTitle: true,
                ),
              ),

              const SliverToBoxAdapter(
                child: TabBar(
                    dividerColor: Colors.transparent,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    tabs: [
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Acidity",
                      ),
                      Tab(
                        text: "Bloating",
                      ),
                      Tab(
                        text: "Constipation",
                      ),
                      Tab(
                        text: "Indigestion",
                      ),
                    ]),
              ),
              SliverToBoxAdapter(
                child: hBox(10),
              ),
              const SliverFillRemaining(
                child: const TabBarView(children: [
                  CustomGridView(
                    itemCount: 20,
                  ),
                  CustomGridView(
                    itemCount: 4,
                  ),
                  CustomGridView(
                    itemCount: 3,
                  ),
                  CustomGridView(
                    itemCount: 6,
                  ),
                  CustomGridView(
                    itemCount: 8,
                  ),
                ]),
              ),
              // categoriesList(),
              // itemGrid(),
              SliverToBoxAdapter(
                child: hBox(50),
              )
            ],
          ),
        ),
      ),
    );
  }
}
