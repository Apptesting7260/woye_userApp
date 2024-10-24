import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';

class CategoryDetailsScreen extends StatelessWidget {
  const CategoryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          "Pizza",
          style: AppFontStyle.text_24_600(AppColors.darkText),
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
              expandedHeight: 80.h,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              flexibleSpace: FlexibleSpaceBar(
                title: SizedBox(
                  height: 40.h,
                  child: (CustomSearchFilter(
                    onFilterTap: () {},
                  )),
                ),
                centerTitle: true,
              ),
            ),
            SliverGrid(
                delegate:
                    SliverChildBuilderDelegate(childCount: 6, (context, index) {
                  return categoryItem(index);
                }),
                gridDelegate: (SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.72.h,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 5.h,
                )))
          ],
        ),
      ),
    );
  }
}

Widget categoryItem(index) {
  return Column(
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
              "assets/images/cat-image$index.png",
              height: 160,
              // width: Get.width,
            ),
          ),
          Container(
            margin: REdgeInsets.only(top: 10, right: 10),
            padding: REdgeInsets.symmetric(horizontal: 6, vertical: 8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppColors.greyBackground),
            child: SvgPicture.asset(
              "assets/svg/wishlist.svg",
              height: 15.h,
            ),
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
  );
}
