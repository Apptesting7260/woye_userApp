import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Grocery/Grocery_navbar/controller/grocery_navbar_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/grocery_product_details_screen.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/controller/grocery_home_controller.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class GroceryHomeScreen extends StatelessWidget {
  const GroceryHomeScreen({super.key});

  static final GroceryHomeController homeController =
      Get.put(GroceryHomeController());

  static final GroceryNavbarController navbarController =
      Get.put(GroceryNavbarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeScreen(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: REdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  sliver: serchAndFilter(),
                ),
                SliverPadding(
                    padding: REdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          mainBanner(),
                          hBox(20),
                          catergories(),
                          hBox(20),
                          mostPopular(),
                          hBox(20),
                          moreProduct(),
                          hBox(80)
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget serchAndFilter() {
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
              Get.toNamed(AppRoutes.groceryHomeFilter);
            },
          )),
        ),
        centerTitle: true,
      ),
    );
  }

  Widget mainBanner() {
    return Container(
      decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage(
            "assets/images/pharmacy-main-banner.png",
          )),
          borderRadius: BorderRadius.circular(30.r)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "30%",
                      overflow: TextOverflow.visible,
                      style: AppFontStyle.text_30_600(AppColors.darkText,
                          height: 1.0),
                    ),
                    Text(
                      "off",
                      // "Order from these restaurants and save.",
                      overflow: TextOverflow.visible,
                      style: AppFontStyle.text_16_600(AppColors.darkText),
                    ),
                  ],
                ),
                hBox(5),
                Text(
                  "Today Special!",
                  overflow: TextOverflow.visible,
                  style: AppFontStyle.text_16_600(AppColors.darkText),
                ),
                hBox(16),
                CustomElevatedButton(
                  height: 40.h,
                  width: 100.w,
                  onPressed: () {},
                  child: Text(
                    "Buy now",
                    style: AppFontStyle.text_12_600(AppColors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget catergories() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Catergories",
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            const Spacer(),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                navbarController.getIndex(1);
              },
              child: InkWell(
                onTap: () {
                  navbarController.getIndex(1);
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
                      size: 18,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        hBox(20),
        SizedBox(
          height: 110.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.r),
                    child: ColoredBox(
                      color: AppColors.ultraLightPrimary,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Image.asset(
                          "assets/images/grocery-cat-${index % 4}.png",
                          height: 30.h,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  hBox(10),
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      "Home - Item",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      softWrap: true,
                      style: AppFontStyle.text_14_500(AppColors.darkText),
                    ),
                  )
                ],
              ).marginOnly(right: 30.w);
            },
          ),
        )
      ],
    );
  }

  Widget mostPopular() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Most Popular",
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.groceryMostPopular);
              },
              child: Text(
                "See All",
                style: AppFontStyle.text_14_600(AppColors.primary),
              ),
            ),
            wBox(4),
            Icon(
              Icons.arrow_forward_sharp,
              color: AppColors.primary,
              size: 18,
            )
          ],
        ),
        hBox(20),
        CustomGridView(
          itemCount: 2,
          image: "assets/images/grocery-item.png",
          description: "Arla DANO Full Cream Milk Powder Instant",
          quantity: "50gm",
          onTap: () {
            Get.to(() => GroceryProductDetailsScreen(
                image: "assets/images/grocery-item.png",
                title: "Arla DANO Full Cream Milk Powder Instant"));
          },
        )
      ],
    );
  }

  Widget moreProduct() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "More Products",
              style: AppFontStyle.text_20_600(AppColors.darkText),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.groceryMoreProducts);
              },
              child: Text(
                "See All",
                style: AppFontStyle.text_14_600(AppColors.primary),
              ),
            ),
            wBox(4),
            Icon(
              Icons.arrow_forward_sharp,
              color: AppColors.primary,
              size: 18,
            )
          ],
        ),
        hBox(20),
        CustomGridView(
          itemCount: 10,
          image: "assets/images/grocery-item.png",
          description: "Arla DANO Full Cream Milk Powder Instant",
          quantity: "50gm",
          onTap: () {
            Get.to(() => GroceryProductDetailsScreen(
                image: "assets/images/grocery-item.png",
                title: "Arla DANO Full Cream Milk Powder Instant"));
          },
        )
      ],
    );
  }
}
