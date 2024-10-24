import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Presentation/Common/Home/home_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_home/restaurant_home_controller.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key});

  @override
  State<RestaurantHomeScreen> createState() => _HomeRestaurantScreenState();
}

class _HomeRestaurantScreenState extends State<RestaurantHomeScreen> {
  GlobalKey homeWidgetKey = GlobalKey();
  double? height;
  final RestaurantHomeController restaurantHomeController =
      Get.put(RestaurantHomeController());

  _getHeight(_) {
    final keyContext = homeWidgetKey.currentContext;

    if (keyContext != null) height = keyContext.size!.height;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_getHeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HomeScreen(
            key: homeWidgetKey,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: REdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  sliver: SliverAppBar(
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
                        height: 34.h,
                        child: (CustomSearchFilter(
                          searchIocnPadding: REdgeInsets.all(8),
                          searchIconHeight: 16.h,
                          hintStyle:
                              AppFontStyle.text_10_400(AppColors.hintText),
                          textStyle:
                              AppFontStyle.text_10_400(AppColors.darkText),
                          prefixConstraints: BoxConstraints(
                            maxHeight: 18.h,
                          ),
                          prefix: Padding(
                            padding:
                                REdgeInsets.only(left: 15, right: 5, bottom: 1),
                            child: SvgPicture.asset(
                              "assets/svg/search.svg",
                              height: 12,
                            ),
                          ),
                          padding: REdgeInsets.only(top: 10, bottom: 10),
                          onFilterTap: () {},
                        )),
                      ),
                      centerTitle: true,
                    ),
                  ),
                ),
                SliverPadding(
                    padding: REdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) => SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // height: 150.h,
                              decoration: BoxDecoration(
                                  color:
                                      const Color(0xffBB9A65).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 30, bottom: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Order from these restaurants and save.",
                                            style: AppFontStyle.text_18_600(
                                                AppColors.darkText),
                                          ),
                                          hBox(16),
                                          CustomElevatedButton(
                                            height: 40.h,
                                            width: 100.w,
                                            onPressed: () {},
                                            child: Text(
                                              "Buy now",
                                              style: AppFontStyle.text_12_600(
                                                  AppColors.white),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Image.asset(
                                      "assets/images/burger.png",
                                      height: 160.h,
                                      // width: 100.w,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            hBox(20),
                            catergoryList(),
                            hBox(20),
                            Row(
                              children: [
                                Text(
                                  "Popular Restaurant",
                                  style: AppFontStyle.text_24_600(
                                      AppColors.darkText),
                                ),
                                const Spacer(),
                                Text(
                                  "See All",
                                  style: AppFontStyle.text_14_400(
                                      AppColors.primary),
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
                            ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final controllerList =
                                      restaurantHomeController
                                          .restaurantList[index];
                                  return restaurantList(
                                      image: controllerList["image"],
                                      title: controllerList["title"],
                                      type: controllerList["type"],
                                      isFavourite:
                                          controllerList["isFavourite"]);
                                },
                                itemCount: restaurantHomeController
                                    .restaurantList.length,
                                separatorBuilder: (context, index) => hBox(20)),
                            hBox(100)
                          ],
                        ),
                      ),
                      childCount: 1,
                    )))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column catergoryList() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Catergories",
              style: AppFontStyle.text_24_600(AppColors.darkText),
            ),
            const Spacer(),
            Text(
              "See All",
              style: AppFontStyle.text_14_400(AppColors.primary),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CustomRoundedButton(
                    onPressed: () {},
                    child: Image.asset("assets/images/cat-pizza.png")),
                hBox(15),
                Text(
                  "Pizza",
                  style: AppFontStyle.text_14_400(AppColors.darkText),
                )
              ],
            ),
            Column(
              children: [
                CustomRoundedButton(
                    onPressed: () {},
                    child: Image.asset("assets/images/cat-burger.png")),
                hBox(15),
                Text(
                  "Burger",
                  style: AppFontStyle.text_14_400(AppColors.darkText),
                )
              ],
            ),
            Column(
              children: [
                CustomRoundedButton(
                    onPressed: () {},
                    child: Image.asset("assets/images/cat-cake.png")),
                hBox(15),
                Text(
                  "Cake",
                  style: AppFontStyle.text_14_400(AppColors.darkText),
                )
              ],
            ),
            Column(
              children: [
                CustomRoundedButton(
                    onPressed: () {},
                    child: Image.asset("assets/images/cat-sweet.png")),
                hBox(15),
                Text(
                  "Sweet",
                  style: AppFontStyle.text_14_400(AppColors.darkText),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget restaurantList({image, title, type, isFavourite}) {
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
                image,
                // height: 200,
                width: Get.width,
              ),
            ),
            Container(
              margin: REdgeInsets.only(top: 15, right: 15),
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
        hBox(10),
        Text(
          title,
          textAlign: TextAlign.left,
          style: AppFontStyle.text_18_400(AppColors.darkText),
        ),
        hBox(10),
        Text(
          type,
          textAlign: TextAlign.left,
          style: AppFontStyle.text_16_300(AppColors.lightText),
        ),
      ],
    );
  }
}
