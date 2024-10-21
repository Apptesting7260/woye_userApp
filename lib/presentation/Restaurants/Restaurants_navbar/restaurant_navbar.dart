import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/restaurant_navbar_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';

class RestaurantNavbar extends StatelessWidget {
  final int navbarInitialIndex;
  const RestaurantNavbar({super.key, this.navbarInitialIndex = 0});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantNavbarController>(
        init:
            RestaurantNavbarController(navbarCurrentIndex: navbarInitialIndex),
        builder: (navbarController) {
          return PopScope(
            canPop: false,
            child: Scaffold(
              body: Stack(
                children: [
                  IndexedStack(
                    index: navbarController.navbarCurrentIndex,
                    children: navbarController.widgets,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: navbar(navbarController),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget navbar(RestaurantNavbarController navbarController) {
    List<String> navbarItems = [
      ImageConstants.home,
      ImageConstants.categories,
      ImageConstants.wishlist,
      ImageConstants.cart,
      ImageConstants.profileOutlined,
    ];
    List<String> navbarItemsFilled = [
      ImageConstants.homeFilled,
      ImageConstants.categoriesFilled,
      ImageConstants.wishlistFilled,
      ImageConstants.cartFilled,
      ImageConstants.profilefilled,
    ];
    return Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: AppColors.navbar,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        ),
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 13),
          child: Row(
              children: List.generate(navbarItems.length, (index) {
            bool isSelected = navbarController.navbarCurrentIndex == index;
            String icon = navbarController.navbarCurrentIndex == index
                ? navbarItemsFilled[index]
                : navbarItems[index];
            return InkWell(
              onTap: () {
                navbarController.getIndex(index);
              },
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: 48.w,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.zero,
                        height: 4.h,
                        width: 44.w,
                        decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10.r),
                                bottomRight: Radius.circular(10.r))),
                      ),
                      Padding(
                        padding: REdgeInsets.only(top: 19, bottom: 23),
                        child: SvgPicture.asset(
                          icon,
                          height: 24.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          })
              // navbarItems.map((icon) {
              //   int index = navbarItems.indexOf(icon);
              //   bool isSelected = navbarController.navbarCurrentIndex == index;
              //   return GestureDetector(
              //     onTap: () {
              //       navbarController.getIndex(index);
              //     },
              //     child: Padding(
              //       padding: REdgeInsets.symmetric(horizontal: 12),
              //       child: AnimatedContainer(
              //         duration: const Duration(milliseconds: 300),
              //         curve: Curves.easeInOut,
              //         height: 48.h,
              //         width: 48.h,
              //         child: Column(
              //           children: [
              //             SvgPicture.asset(
              //               icon,
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   );
              // }).toList(),
              ),
        ));
  }
}
