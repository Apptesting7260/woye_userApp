import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Grocery/Grocery_navbar/controller/grocery_navbar_controller.dart';
import 'package:woye_user/presentation/Grocery/Pages/Grocery_cart/show_all_grocery_carts/grocery_allCart_controller.dart';

class GroceryNavbar extends StatelessWidget {
  final int navbarInitialIndex;
   GroceryNavbar({super.key, this.navbarInitialIndex = 0});

  GroceryShowAllCartController groceryShowAllCartController = Get.put(GroceryShowAllCartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GroceryNavbarController>(
        init: GroceryNavbarController(navbarCurrentIndex: navbarInitialIndex),
        builder: (navbarController) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (navbarController.navbarCurrentIndex != 0) {
                navbarController.getIndex(0);
              }
            },
            child: Scaffold(
              body: Stack(
                children: [
                  // IndexedStack(
                  //   index: navbarController.navbarCurrentIndex,
                  //   children: navbarController.widgets,
                  // // ),
                  // navbarController.widgets[navbarController.navbarCurrentIndex],
                  // Align(
                  //   alignment: Alignment.bottomCenter,
                  //   child: navbar(navbarController),
                  // )
                  if (navbarController.widgets.isNotEmpty)
                    navbarController.widgets[navbarController.navbarCurrentIndex]
                  else
                    const SizedBox(),

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

  Widget navbar(GroceryNavbarController navbarController) {
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
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColors.navbar,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(navbarItems.length, (index) {

              bool isSelected = navbarController.navbarCurrentIndex == index;
              String icon = isSelected ? navbarItemsFilled[index] : navbarItems[index];

              return InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  navbarController.getIndex(index);
                },
                child: Padding(
                  padding: REdgeInsets.symmetric(horizontal: 12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: 44.w,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
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
                        if (index == 3)
                          Obx(() => groceryShowAllCartController.cartData.value.carts != null
                              ? Positioned(top: 15, right: 3,
                            child: (groceryShowAllCartController.cartData.value.carts?.isNotEmpty ?? true)
                                ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.black,
                              ),
                              child: Padding(
                                padding: REdgeInsets.all(4),
                                child: Obx(() {
                                  return Text(
                                    groceryShowAllCartController.cartData.value.carts?.length.toString() ?? "",
                                    style: TextStyle(fontSize: 9,
                                        color: AppColors.white),
                                  );
                                }),
                              ),
                            )
                                : const SizedBox(),
                          )
                              : const SizedBox(),
                          )
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
            ));
  }
}
