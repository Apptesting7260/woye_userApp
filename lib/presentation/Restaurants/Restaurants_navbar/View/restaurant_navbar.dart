import 'package:get_storage/get_storage.dart';
import 'package:woye_user/Presentation/Restaurants/Restaurants_navbar/Controller/restaurant_navbar_controller.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Controller/restaurant_cart_controller.dart';

class RestaurantNavbar extends StatelessWidget {
  final int navbarInitialIndex;

  RestaurantNavbar({super.key, this.navbarInitialIndex = 0});

  final storage = GetStorage();

  // final RestaurantWishlistController controller =
  //     Get.put(RestaurantWishlistController());
  RxInt cartCount = 0.obs;

  final RestaurantCartController restaurantCartController = Get.put(RestaurantCartController());

  // final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RestaurantNavbarController>(
        init: RestaurantNavbarController(navbarCurrentIndex: navbarInitialIndex),
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
                  navbarController.widgets[navbarController.navbarCurrentIndex],
                  // IndexedStack(
                  //   index: navbarController.navbarCurrentIndex,
                  //   children: navbarController.widgets,
                  // ),
                  if(MediaQuery.of(context).viewInsets.bottom == 0.0) ...[
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: navbar(navbarController),
                    ),
                  ],
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
    return   Container(
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
                  // print("MediaQuery.of(context).viewInsets.bottom ${MediaQuery.of(Get.context!).viewInsets.bottom}");
                  // print("MediaQuery.of(context).viewInsets.bottom ${MediaQuery.of(Get.context!).viewInsets.bottom.runtimeType}");
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
                              padding:
                                  REdgeInsets.only(top: 19, bottom: 23),
                              child: SvgPicture.asset(
                                icon,
                                height: 24.h,
                              ),
                            ),
                          ],
                        ),
                        if (index == 3)
                          Obx(
                            () => restaurantCartController
                                        .cartData.value.cart !=
                                    null
                                ? Positioned(
                                    top: 15,
                                    right: 2,
                                    child: restaurantCartController
                                                .cartData
                                                .value
                                                .cart
                                                ?.totalProductsInCart !=
                                            "0"
                                        ? Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.black,
                                            ),
                                            child: Padding(
                                              padding: REdgeInsets.all(4),
                                              child: Obx(() {
                                                return Text(
                                                  restaurantCartController
                                                          .cartData
                                                          .value
                                                          .cart
                                                          ?.totalProductsInCart
                                                          .toString() ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                      color: AppColors.white),
                                                );
                                              }),
                                            ),
                                          )
                                        : SizedBox(), // If the value is null or 0, show an empty container (nothing)
                                  )
                                : SizedBox(),
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
