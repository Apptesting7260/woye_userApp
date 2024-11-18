import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_home/Sub_screens/Product_details/grocery_product_details_screen.dart';
import 'package:woye_user/shared/widgets/custom_grid_view.dart';

class GroceryVendorDetailsScreen extends StatelessWidget {
  final String image;
  final String title;
  GroceryVendorDetailsScreen(
      {super.key, required this.title, required this.image});
  static final List detailCategories = [
    "All",
    "Acidity",
    "Bloating",
    "Constipation",
    "Indigestions"
  ];
  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    String mainBannerImage = image;
    String title = this.title;
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        actions: [
          Container(
            padding: REdgeInsets.all(9),
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(12.r)),
            child: Icon(
              Icons.share_outlined,
              size: 24.w,
            ),
          ),
          wBox(8),
          Container(
              padding: REdgeInsets.all(9),
              height: 44.h,
              width: 44.h,
              decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Icon(
                Icons.favorite_outline_sharp,
                size: 24.w,
              )),
          wBox(8),
          Container(
            padding: REdgeInsets.all(9),
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
                color: AppColors.greyBackground,
                borderRadius: BorderRadius.circular(12.r)),
            child: SvgPicture.asset(
              ImageConstants.notification,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              flex: 36,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  mainBanner(mainBannerImage, title),
                ],
              ),
            ),
            Expanded(flex: 64, child: tabBar()),
          ],
        ),
      ),
    );
  }

  Widget mainBanner(String mainBannerImage, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: REdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.greyBackground.withOpacity(0.4),
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: Image.asset(
                    mainBannerImage,
                    height: 60.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              wBox(10),
              Expanded(
                flex: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppFontStyle.text_16_600(AppColors.darkText),
                    ),
                    hBox(5),
                    Row(
                      children: [
                        SvgPicture.asset("assets/svg/star-yellow.svg"),
                        wBox(4),
                        Text(
                          "4.5/5",
                          style: AppFontStyle.text_14_400(AppColors.lightText),
                        ),
                        wBox(4),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.pharmacyVendorReview);
                          },
                          child: Text(
                            "(120 Reviews)",
                            style:
                                AppFontStyle.text_12_400(AppColors.lightText),
                          ),
                        ),
                      ],
                    ),
                    hBox(10),
                    CustomElevatedButton(
                        height: 40.h,
                        onPressed: () {},
                        child: const Text("Favorite Shop"))
                  ],
                ),
              ),
            ],
          ),
        ),
        hBox(15),
        Row(
          children: [
            const Icon(Icons.person_outline_rounded),
            wBox(8),
            Text(
              "John Doe",
              style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary),
            )
          ],
        ),
        hBox(10),
        Row(
          children: [
            const Icon(Icons.mail_outline_rounded),
            wBox(8),
            Text(
              "restaurants@gmail.com",
              style: AppFontStyle.text_14_400(AppColors.darkText),
            )
          ],
        ),
        hBox(10),
        Row(
          children: [
            const Icon(Icons.location_on_outlined),
            wBox(8),
            Text(
              "Greenfield, Abc Manchester, 199",
              style: AppFontStyle.text_14_400(AppColors.darkText),
            )
          ],
        ),
      ],
    );
  }

 

  Widget tabBar() {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Column(
        children: <Widget>[
          const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerHeight: 0,
            tabs: [
              Tab(text: 'All'),
              Tab(text: 'Vegetables'),
              Tab(text: 'Fruits'),
              Tab(text: 'Milk & Eggs'),
              Tab(text: 'Fruits'),
            ],
          ),
          hBox(20),
          Expanded(
            child: TabBarView(
              children: [
                CustomGridView(
                  physics: BouncingScrollPhysics(),
                  itemCount: 20,
                  imageAddress: "assets/images/grocery-item.png",
                  title: "Arla DANO Full Cream Milk Powder Instant",
                  quantity: "50gm",
                  onTap: () {
                    Get.to(() => const GroceryProductDetailsScreen(
                        image: "assets/images/grocery-item.png",
                        title: "Arla DANO Full Cream Milk Powder Instant"));
                  },
                ),
                CustomGridView(
                  physics: BouncingScrollPhysics(),
                  itemCount: 4,
                  imageAddress: "assets/images/grocery-item.png",
                  title: "Arla DANO Full Cream Milk Powder Instant",
                  quantity: "50gm",
                  onTap: () {
                    Get.to(() => const GroceryProductDetailsScreen(
                        image: "assets/images/grocery-item.png",
                        title: "Arla DANO Full Cream Milk Powder Instant"));
                  },
                ),
                CustomGridView(
                  physics: BouncingScrollPhysics(),
                  itemCount: 6,
                  imageAddress: "assets/images/grocery-item.png",
                  title: "Arla DANO Full Cream Milk Powder Instant",
                  quantity: "50gm",
                  onTap: () {
                    Get.to(() => const GroceryProductDetailsScreen(
                        image: "assets/images/grocery-item.png",
                        title: "Arla DANO Full Cream Milk Powder Instant"));
                  },
                ),
                CustomGridView(
                  physics: BouncingScrollPhysics(),
                  itemCount: 8,
                  imageAddress: "assets/images/grocery-item.png",
                  title: "Arla DANO Full Cream Milk Powder Instant",
                  quantity: "50gm",
                  onTap: () {
                    Get.to(() => const GroceryProductDetailsScreen(
                        image: "assets/images/grocery-item.png",
                        title: "Arla DANO Full Cream Milk Powder Instant"));
                  },
                ),
                CustomGridView(
                  physics: BouncingScrollPhysics(),
                  itemCount: 10,
                  imageAddress: "assets/images/grocery-item.png",
                  title: "Arla DANO Full Cream Milk Powder Instant",
                  quantity: "50gm",
                  onTap: () {
                    Get.to(() => const GroceryProductDetailsScreen(
                        image: "assets/images/grocery-item.png",
                        title: "Arla DANO Full Cream Milk Powder Instant"));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
