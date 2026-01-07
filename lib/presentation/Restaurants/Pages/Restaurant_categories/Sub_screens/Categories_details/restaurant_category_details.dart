import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/Core/Utils/login_required_pop_up.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_cart/View/restaurant_cart_screen.dart';
import 'package:woye_user/Presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Categories_details/Modal/RestaurantCategoryDetailsModal.dart';
import 'package:woye_user/Shared/Widgets/custom_search_filter.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_cart/Add_to_Cart/addtocartcontroller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_categories/Sub_screens/Filter/controller/CategoriesFilter_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/controller/specific_product_controller.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/modal/specific_product_modal.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/view/product_details_screen.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_wishlist/Controller/aad_product_wishlist_Controller/add_product_wishlist.dart';
import 'package:woye_user/presentation/common/get_user_data/get_user_data.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/custom_no_data_found.dart';
import 'package:woye_user/shared/widgets/custom_print.dart' show pt;

import '../../../../../../Data/components/GeneralException.dart';
import '../../../../../../Data/components/InternetException.dart';
import '../../../../../../shared/widgets/CircularProgressIndicator.dart';
import '../../../../Restaurants_navbar/Controller/restaurant_navbar_controller.dart';
import 'controller/RestaurantCategoriesDetailsController.dart';

class RestaurantCategoryDetails extends StatelessWidget {
  RestaurantCategoryDetails({super.key});

  final RestaurantCategoriesDetailsController controller = Get.put(RestaurantCategoriesDetailsController());
  final AddToCartController addToCartController = Get.put(AddToCartController());

  final AddProductWishlistController add_Wishlist_Controller = Get.put(AddProductWishlistController());

  final specific_Product_Controller specific_product_controllerontroller = Get.put(specific_Product_Controller());
  final GetUserDataController getUserDataController = Get.put(GetUserDataController());

  final Categories_FilterController categoriesFilterController = Get.put(Categories_FilterController());
  // RestaurantNavbarController navbarController = Get.put(RestaurantNavbarController());

  /*Future<dynamic> addToCartPopUp(BuildContext context, CategoryProduct? product) {
    // Directly use the product data from RestaurantCategoryDetailsModal
    final hasOptions = product?.options != null && product!.options!.isNotEmpty;
    final hasAddOns = product?.addOns != null && product!.addOns!.isNotEmpty;
    final hasAttributes = product?.productAttributes != null && product!.productAttributes!.isNotEmpty;
    final hasAnyContent = hasOptions || hasAddOns || hasAttributes;

    // Create local Rx variables for state management
    final RxInt localCartCount = 1.obs;
    final RxList<Map<String, dynamic>> selectedAddOns = <Map<String, dynamic>>[].obs;
    final RxMap<String, String?> selectedOptions = <String, String?>{}.obs;

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: true,
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            content: StatefulBuilder(
              builder: (context, setState) {
                // Helper functions for handling selections
                void toggleAddOnSelection(addOn) {
                  final existingIndex = selectedAddOns.indexWhere((item) => item['id'] == addOn.id);
                  if (existingIndex != -1) {
                    selectedAddOns.removeAt(existingIndex);
                  } else {
                    if (selectedAddOns.length < 9) {
                      selectedAddOns.add({
                        'id': addOn.id,
                        'name': addOn.name,
                        'price': addOn.price,
                      });
                    } else {
                      Utils.showToast("Maximum 9 add-ons can be selected");
                    }
                  }
                  setState(() {});
                }

                void toggleOptionSelection(String optionId, String choiceName, String choicePrice) {
                  if (selectedOptions[optionId] == choiceName) {
                    selectedOptions.remove(optionId);
                  } else {
                    selectedOptions[optionId] = choiceName;
                  }
                  setState(() {});
                }

                bool isAddOnSelected(String addOnId) {
                  return selectedAddOns.any((item) => item['id'] == addOnId);
                }

                bool isOptionSelected(String optionId, String choiceName) {
                  return selectedOptions[optionId] == choiceName;
                }

                return SizedBox(
                  width: Get.width * 0.95,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          hBox(40.h),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, right: 16, left: 16, bottom: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Show message if no content
                                    if (!hasAnyContent)
                                      Container(
                                        padding: REdgeInsets.symmetric(vertical: 40),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: AppColors.primary,
                                                size: 40,
                                              ),
                                              hBox(10),
                                              Text(
                                                "No addons available",
                                                style: AppFontStyle.text_16_400(
                                                  AppColors.darkText,
                                                  family: AppFontFamily.gilroyMedium,
                                                ),
                                              ),
                                              hBox(5),
                                              Text(
                                                "You can add this product directly to cart",
                                                style: AppFontStyle.text_14_400(
                                                  AppColors.lightText,
                                                  family: AppFontFamily.gilroyRegular,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    // Show content if available
                                    if (hasAnyContent) ...[
                                      // Options Section
                                      if (hasOptions)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Extras",
                                              style: AppFontStyle.text_16_400(
                                                AppColors.darkText,
                                                family: AppFontFamily.gilroyMedium,
                                              ),
                                            ),
                                            hBox(10.h),
                                            ...product!.options!.map((option) {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    option.optionName ?? "Option",
                                                    style: AppFontStyle.text_14_400(
                                                      AppColors.darkText,
                                                      family: AppFontFamily.gilroyMedium,
                                                    ),
                                                  ),
                                                  hBox(5.h),
                                                  ...option.choices!.map((choice) {
                                                    return RadioListTile<String>(
                                                      title: Text(
                                                        "${choice.name} (+${choice.price})",
                                                        style: AppFontStyle.text_14_400(
                                                          AppColors.darkText,
                                                          family: AppFontFamily.gilroyRegular,
                                                        ),
                                                      ),
                                                      value: choice.name ?? "",
                                                      groupValue: selectedOptions[option.optionId ?? ""],
                                                      onChanged: (value) {
                                                        toggleOptionSelection(
                                                          option.optionId ?? "",
                                                          choice.name ?? "",
                                                          choice.price ?? "0",
                                                        );
                                                      },
                                                    );
                                                  }).toList(),
                                                ],
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      if (hasOptions)
                                        hBox(10.h),

                                      // AddOns Section
                                      if (hasAddOns)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Add-ons",
                                              style: AppFontStyle.text_16_400(
                                                AppColors.darkText,
                                                family: AppFontFamily.gilroyMedium,
                                              ),
                                            ),
                                            hBox(10.h),
                                            ...product!.addOns!.map((addOn) {
                                              return CheckboxListTile(
                                                title: Text(
                                                  "${addOn.name} (+${addOn.price})",
                                                  style: AppFontStyle.text_14_400(
                                                    AppColors.darkText,
                                                    family: AppFontFamily.gilroyRegular,
                                                  ),
                                                ),
                                                value: isAddOnSelected(addOn.id ?? ""),
                                                onChanged: (value) {
                                                  toggleAddOnSelection(addOn);
                                                },
                                              );
                                            }).toList(),
                                          ],
                                        ),

                                      // Product Attributes Section
                                      if (hasAttributes)
                                        Column(
                                          children: [
                                            hBox(10.h),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Attributes",
                                                  style: AppFontStyle.text_16_400(
                                                    AppColors.darkText,
                                                    family: AppFontFamily.gilroyMedium,
                                                  ),
                                                ),
                                                hBox(10.h),
                                                ...product!.productAttributes!.map((attributeGroup) {
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        attributeGroup.groupName ?? "",
                                                        style: AppFontStyle.text_14_400(
                                                          AppColors.darkText,
                                                          family: AppFontFamily.gilroyMedium,
                                                        ),
                                                      ),
                                                      hBox(5.h),
                                                      ...attributeGroup.attributes!.map((attribute) {
                                                        return Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                                          child: Text(
                                                            "• ${attribute.name}",
                                                            style: AppFontStyle.text_14_400(
                                                              AppColors.lightText,
                                                              family: AppFontFamily.gilroyRegular,
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ],
                                                  );
                                                }).toList(),
                                              ],
                                            ),
                                          ],
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomElevatedButton(
                              fontFamily: AppFontFamily.gilroyMedium,
                              width: Get.width,
                              color: AppColors.darkText,
                              isLoading: addToCartController.rxRequestStatusPopUp.value == (Status.LOADING),
                              text: "Add to Cart",
                              onPressed: () {
                                if (getUserDataController.userData.value.user?.userType == "guestUser") {
                                  showLoginRequired(context);
                                  return;
                                }

                                // Prepare data for API
                                final addonsList = selectedAddOns.map((addon) => addon['id'].toString()).toList();

                                // Prepare options data
                                final selectedOptionsList = selectedOptions.entries.map((entry) {
                                  return {
                                    'optionId': entry.key,
                                    'choiceName': entry.value,
                                  };
                                }).toList();

                                print("Selected AddOns: $selectedAddOns");
                                print("Selected Options: $selectedOptionsList");

                                // Call your addToCart API
                                addToCartController.addToCartApi(
                                  isPopUp: true,
                                  cartId: product?.id.toString(),
                                  productId: product?.id.toString() ?? '',
                                  productPrice: product?.salePrice?.toString() ?? product?.regularPrice?.toString() ?? '0',
                                  productQuantity: localCartCount.value.toString(),
                                  restaurantId: product?.vendorId.toString() ?? '',
                                  addons: selectedAddOns,
                                  extrasIds: selectedOptions.keys.toList(),
                                  extrasItemIds: selectedOptions.keys.toList(),
                                  extrasItemNames: selectedOptions.values.toList(),
                                  extrasItemPrices: [], // You need to get prices from choices
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      // Close Icon
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                            addToCartController.clearSelected();
                          },
                          icon: Icon(Icons.cancel, color: AppColors.primary, size: 26),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
*/

  /*Future<dynamic> addToCartPopUp(BuildContext context, CategoryProduct? product) {
    // Directly use the product data from RestaurantCategoryDetailsModal
    final hasOptions = product?.options != null && product!.options!.isNotEmpty;
    final hasAddOns = product?.addOns != null && product!.addOns!.isNotEmpty;
    final hasAttributes = product?.productAttributes != null && product!.productAttributes!.isNotEmpty;
    final hasAnyContent = hasOptions || hasAddOns || hasAttributes;

    // Create local variables for state management (similar to first function)
    RxInt localCartCount = 1.obs;
    RxList<Map<String, dynamic>> selectedAddOns = <Map<String, dynamic>>[].obs;
    RxMap<String, String?> selectedOptions = <String, String?>{}.obs;
    RxList<String> extrasTitlesIdsId = <String>[].obs;
    RxList<String> extrasItemIdsId = <String>[].obs;
    RxList<String> extrasItemIdsName = <String>[].obs;
    RxList<String> extrasItemIdsPrice = <String>[].obs;

    // Initialize addons selection state
    if (hasAddOns) {
      for (var addOn in product!.addOns!) {
        addOn.isSelected.value = false;
      }
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: true,
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            content: StatefulBuilder(
              builder: (context, setState) {
                // Helper functions for handling selections
                void toggleAddOnSelection(addOn) {
                  final existingIndex = selectedAddOns.indexWhere((item) => item['id'] == addOn.id);
                  if (existingIndex != -1) {
                    selectedAddOns.removeAt(existingIndex);
                    addOn.isSelected.value = false;
                  } else {
                    if (selectedAddOns.length < 9) {
                      selectedAddOns.add({
                        'id': addOn.id,
                        'name': addOn.name,
                        'price': addOn.price,
                      });
                      addOn.isSelected.value = true;
                    } else {
                      Utils.showToast("Maximum 9 add-ons can be selected");
                    }
                  }
                  setState(() {});
                }

                void toggleOptionSelection(String optionId, String optionName, String choiceName, String choicePrice) {
                  if (selectedOptions[optionId] == choiceName) {
                    // Deselect
                    selectedOptions.remove(optionId);

                    // Remove from arrays
                    int indexToRemove = extrasTitlesIdsId.indexWhere((id) => id == optionId);
                    if (indexToRemove != -1) {
                      extrasTitlesIdsId.removeAt(indexToRemove);
                      extrasItemIdsId.removeAt(indexToRemove);
                      extrasItemIdsName.removeAt(indexToRemove);
                      extrasItemIdsPrice.removeAt(indexToRemove);
                    }
                  } else {
                    // Select (radio behavior - one per option)
                    selectedOptions[optionId] = choiceName;

                    // Find if this option is already selected
                    int existingIndex = extrasTitlesIdsId.indexWhere((id) => id == optionId);

                    if (existingIndex != -1) {
                      // Update existing
                      extrasItemIdsName[existingIndex] = choiceName;
                      extrasItemIdsPrice[existingIndex] = choicePrice;
                    } else {
                      // Add new
                      extrasTitlesIdsId.add(optionId);
                      extrasItemIdsId.add(optionId);
                      extrasItemIdsName.add(choiceName);
                      extrasItemIdsPrice.add(choicePrice);
                    }
                  }
                  setState(() {});
                }

                bool isAddOnSelected(String addOnId) {
                  return selectedAddOns.any((item) => item['id'] == addOnId);
                }

                bool isOptionSelected(String optionId, String choiceName) {
                  return selectedOptions[optionId] == choiceName;
                }

                // Increment/Decrement quantity
                void incrementQuantity() {
                  localCartCount.value++;
                  setState(() {});
                }

                void decrementQuantity() {
                  if (localCartCount.value > 1) {
                    localCartCount.value--;
                    setState(() {});
                  }
                }

                return SizedBox(
                  width: Get.width * 0.95,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          hBox(40.h),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0, right: 16, left: 16, bottom: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Show message if no content
                                    if (!hasAnyContent)
                                      Container(
                                        padding: REdgeInsets.symmetric(vertical: 40),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: AppColors.primary,
                                                size: 40,
                                              ),
                                              hBox(10),
                                              Text(
                                                "No addons available",
                                                style: AppFontStyle.text_16_400(
                                                  AppColors.darkText,
                                                  family: AppFontFamily.gilroyMedium,
                                                ),
                                              ),
                                              hBox(5),
                                              Text(
                                                "You can add this product directly to cart",
                                                style: AppFontStyle.text_14_400(
                                                  AppColors.lightText,
                                                  family: AppFontFamily.gilroyRegular,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    // Show content if available
                                    if (hasAnyContent) ...[
                                      // Options Section
                                      if (hasOptions)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Extras",
                                              style: AppFontStyle.text_16_400(
                                                AppColors.darkText,
                                                family: AppFontFamily.gilroyMedium,
                                              ),
                                            ),
                                            hBox(10.h),
                                            ...product!.options!.map((option) {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    option.optionName ?? "Option",
                                                    style: AppFontStyle.text_14_400(
                                                      AppColors.darkText,
                                                      family: AppFontFamily.gilroyMedium,
                                                    ),
                                                  ),
                                                  hBox(5.h),
                                                  ...option.choices!.map((choice) {
                                                    final isSelected = isOptionSelected(option.optionId ?? "", choice.name ?? "");
                                                    return GestureDetector(
                                                      onTap: () {
                                                        toggleOptionSelection(
                                                          option.optionId ?? "",
                                                          option.optionName ?? "",
                                                          choice.name ?? "",
                                                          choice.price ?? "0",
                                                        );
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(bottom: 8),
                                                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(
                                                            color: isSelected ? AppColors.primary : AppColors.lightText,
                                                            width: isSelected ? 2 : 1,
                                                          ),
                                                          color: isSelected ? AppColors.primary.withOpacity(0.1) : AppColors.white,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              choice.name ?? "",
                                                              style: AppFontStyle.text_14_400(
                                                                isSelected ? AppColors.primary : AppColors.darkText,
                                                                family: AppFontFamily.gilroyMedium,
                                                              ),
                                                            ),
                                                            Text(
                                                              "+₹${choice.price ?? "0"}",
                                                              style: AppFontStyle.text_14_400(
                                                                isSelected ? AppColors.primary : AppColors.darkText,
                                                                family: AppFontFamily.gilroyMedium,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ],
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      if (hasOptions)
                                        hBox(10.h),

                                      // AddOns Section
                                      if (hasAddOns)
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Add-ons",
                                              style: AppFontStyle.text_16_400(
                                                AppColors.darkText,
                                                family: AppFontFamily.gilroyMedium,
                                              ),
                                            ),
                                            hBox(10.h),
                                            ...product!.addOns!.map((addOn) {
                                              final isSelected = isAddOnSelected(addOn.id ?? "");
                                              return Obx(() => GestureDetector(
                                                onTap: () {
                                                  toggleAddOnSelection(addOn);
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(bottom: 8),
                                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    border: Border.all(
                                                      color: addOn.isSelected.value ? AppColors.primary : AppColors.lightText,
                                                      width: addOn.isSelected.value ? 2 : 1,
                                                    ),
                                                    color: addOn.isSelected.value ? AppColors.primary.withOpacity(0.1) : AppColors.white,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        addOn.name ?? "",
                                                        style: AppFontStyle.text_14_400(
                                                          addOn.isSelected.value ? AppColors.primary : AppColors.darkText,
                                                          family: AppFontFamily.gilroyMedium,
                                                        ),
                                                      ),
                                                      Text(
                                                        "+₹${addOn.price ?? "0"}",
                                                        style: AppFontStyle.text_14_400(
                                                          addOn.isSelected.value ? AppColors.primary : AppColors.darkText,
                                                          family: AppFontFamily.gilroyMedium,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            }).toList(),
                                          ],
                                        ),

                                      // Product Attributes Section
                                      if (hasAttributes)
                                        Column(
                                          children: [
                                            hBox(10.h),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Attributes",
                                                  style: AppFontStyle.text_16_400(
                                                    AppColors.darkText,
                                                    family: AppFontFamily.gilroyMedium,
                                                  ),
                                                ),
                                                hBox(10.h),
                                                ...product!.productAttributes!.map((attributeGroup) {
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        attributeGroup.groupName ?? "",
                                                        style: AppFontStyle.text_14_400(
                                                          AppColors.darkText,
                                                          family: AppFontFamily.gilroyMedium,
                                                        ),
                                                      ),
                                                      hBox(5.h),
                                                      ...attributeGroup.attributes!.map((attribute) {
                                                        return Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                                          child: Row(
                                                            children: [
                                                              Icon(Icons.circle, size: 8, color: AppColors.lightText),
                                                              SizedBox(width: 8),
                                                              Expanded(
                                                                child: Text(
                                                                  attribute.name ?? "",
                                                                  style: AppFontStyle.text_14_400(
                                                                    AppColors.lightText,
                                                                    family: AppFontFamily.gilroyRegular,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ],
                                                  );
                                                }).toList(),
                                              ],
                                            ),
                                          ],
                                        ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => CustomElevatedButton(
                              fontFamily: AppFontFamily.gilroyMedium,
                              width: Get.width,
                              color: addToCartController.goToCart.value ? AppColors.primary : AppColors.darkText,
                              isLoading: addToCartController.rxRequestStatusPopUp.value == (Status.LOADING),
                              text: addToCartController.goToCart.value ? "Go to Cart" : "Add to Cart",
                              onPressed: () {
                                if (getUserDataController.userData.value.user?.userType == "guestUser") {
                                  showLoginRequired(context);
                                  return;
                                }

                                // Prepare data for API
                                final addonsIds = selectedAddOns.map((addon) => addon['id'].toString()).toList();
                                final addonsNames = selectedAddOns.map((addon) => addon['name'].toString()).toList();
                                final addonsPrices = selectedAddOns.map((addon) => addon['price'].toString()).toList();

                                print("=== Sending to API ===");
                                print("Selected AddOns IDs: $addonsIds");
                                print("Selected Options IDs: ${extrasTitlesIdsId}");
                                print("Selected Option Names: ${extrasItemIdsName}");
                                print("Selected Option Prices: ${extrasItemIdsPrice}");

                                // Call your addToCart API
                                addToCartController.addToCartApi(
                                  isPopUp: true,
                                  cartId: product?.id.toString(),
                                  productId: product?.id.toString() ?? '',
                                  productPrice: product?.salePrice?.toString() ?? product?.regularPrice?.toString() ?? '0',
                                  productQuantity: localCartCount.value.toString(),
                                  restaurantId: product?.vendorId.toString() ?? '',
                                  addons: addonsIds,
                                  extrasIds: extrasTitlesIdsId.toList(),
                                  extrasItemIds: extrasItemIdsId.toList(),
                                  extrasItemNames: extrasItemIdsName.toList(),
                                  extrasItemPrices: extrasItemIdsPrice.toList(),
                                );
                              },
                            )),
                          ),
                        ],
                      ),
                      // Close Icon
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                            addToCartController.clearSelected();
                          },
                          icon: Icon(Icons.cancel, color: AppColors.primary, size: 26),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget extra({specific_Product_Controller? tempController, StateSetter? setState}) {
    final controllerToUse = tempController ?? specific_product_controllerontroller;

    if (controllerToUse.productData.value.product?.options == null ||
        controllerToUse.productData.value.product!.options!.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Loop through each option
        ...controllerToUse.productData.value.product!.options!.asMap().entries.map((entry) {
          final option = entry.value;
          final index = entry.key;

          if (option.choices == null || option.choices!.isEmpty) {
            return SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                option.optionName ?? "Option ${index + 1}",
                style: AppFontStyle.text_20_500(
                  AppColors.darkText,
                  family: AppFontFamily.gilroySemiBold,
                ),
              ),
              hBox(5),
              ...option.choices!.asMap().entries.map((choiceEntry) {
                final choice = choiceEntry.value;
                final choiceIndex = choiceEntry.key;
                final String uniqueKey = '${option.optionId}_$choiceIndex';

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            choice.name ?? "Choice ${choiceIndex + 1}",
                            style: AppFontStyle.text_16_400(
                              AppColors.black,
                              family: AppFontFamily.gilroyRegular,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        wBox(8),
                        Flexible(
                          flex: 1,
                          child: _buildToggleableRadioButton(
                            title: '\$${choice.price ?? "0.00"}',
                            isSelected: controllerToUse.isChoiceSelected(uniqueKey),
                            onTap: () {
                              controllerToUse.toggleChoiceSelection(
                                optionId: option.optionId,
                                optionName: option.optionName,
                                uniqueKey: uniqueKey,
                                choiceIndex: choiceIndex,
                                choiceName: choice.name,
                                choicePrice: choice.price?.toString(),
                                isRequired: true,
                              );
                              if (setState != null) setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    if (choiceIndex < option.choices!.length - 1) hBox(8),
                  ],
                );
              }).toList(),
              if (index < controllerToUse.productData.value.product!.options!.length - 1) hBox(20.h),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildToggleableRadioButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: BoxConstraints(maxWidth: 100),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                style: AppFontStyle.text_16_400(
                  AppColors.black,
                  family: AppFontFamily.gilroySemiBold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            wBox(8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.lightText,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget addOn({specific_Product_Controller? tempController, StateSetter? setState}) {
    final controllerToUse = tempController ?? specific_product_controllerontroller;
    final RxBool showAll = false.obs;

    int totalAddons = controllerToUse.productData.value.product?.addOns?.length ?? 0;
    int initialShowCount = 6;
    int itemsToShow = showAll.value ? totalAddons : min(totalAddons, initialShowCount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add On",
          style: AppFontStyle.text_20_500(AppColors.darkText, family: AppFontFamily.gilroySemiBold),
        ),
        hBox(5),
        Row(
          children: [
            Text(
              "Select any option",
              style: AppFontStyle.text_12_200(AppColors.lightText, family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
        hBox(10),
        if (controllerToUse.productData.value.product?.addOns == null || controllerToUse.productData.value.product!.addOns!.isEmpty)
          Container(
            padding: REdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text(
                "No add-ons available",
                style: AppFontStyle.text_16_400(AppColors.lightText, family: AppFontFamily.gilroyRegular),
              ),
            ),
          )
        else
          Column(
            children: [
              ...List.generate(
                itemsToShow,
                    (index) {
                  final addOn = controllerToUse.productData.value.product?.addOns?[index];
                  bool isSelected = controllerToUse.isAddOnSelected(addOn?.id ?? '');

                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            addOn?.name ?? "Addon ${index + 1}",
                            style: AppFontStyle.text_16_400(
                              AppColors.black,
                              family: AppFontFamily.gilroyRegular,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "\$${addOn?.price ?? "0.00"}",
                                style: AppFontStyle.text_16_600(
                                  AppColors.black,
                                  family: AppFontFamily.gilroyRegular,
                                ),
                              ),
                              wBox(10),
                              GestureDetector(
                                onTap: () {
                                  controllerToUse.toggleAddOnSelection(
                                    addOnId: addOn?.id ?? '',
                                    addOnName: addOn?.name ?? '',
                                    addOnPrice: addOn?.price ?? '0.00',
                                  );
                                  if (setState != null) setState(() {});
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: isSelected ? AppColors.primary : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected ? AppColors.primary : AppColors.lightText,
                                      width: isSelected ? 6 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: isSelected
                                      ? Center(
                                    child: Icon(
                                      Icons.check,
                                      size: 10,
                                      color: Colors.white,
                                    ),
                                  )
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (index < itemsToShow - 1) hBox(8),
                    ],
                  );
                },
              ),
              if (totalAddons > initialShowCount) ...[
                hBox(10),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    showAll.value = !showAll.value;
                    if (setState != null) setState(() {});
                  },
                  child: Container(
                    padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          showAll.value ? "-${totalAddons - initialShowCount} Less" : "+${totalAddons - initialShowCount} More",
                          style: AppFontStyle.text_14_600(AppColors.primary, family: AppFontFamily.gilroyRegular),
                        ),
                        wBox(4),
                        Icon(
                          showAll.value ? Icons.expand_less : Icons.expand_more,
                          color: AppColors.primary,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
      ],
    );
  }

  Widget productAttributes({specific_Product_Controller? tempController}) {
    final controllerToUse = tempController ?? specific_product_controllerontroller;

    if (controllerToUse.productData.value.product?.productAttributes == null ||
        controllerToUse.productData.value.product!.productAttributes!.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Attributes",
          style: AppFontStyle.text_20_500(
            AppColors.darkText,
            family: AppFontFamily.gilroySemiBold,
          ),
        ),
        hBox(10),
        ...controllerToUse.productData.value.product!.productAttributes!.asMap().entries.map((entry) {
          final attributeGroup = entry.value;
          final groupIndex = entry.key;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (attributeGroup.groupName != null && attributeGroup.groupName!.isNotEmpty)
                Column(
                  children: [
                    Text(
                      attributeGroup.groupName!,
                      style: AppFontStyle.text_18_600(
                        AppColors.darkText,
                        family: AppFontFamily.gilroyMedium,
                      ),
                    ),
                    hBox(10),
                  ],
                ),
              ...attributeGroup.attributes!.asMap().entries.map((attrEntry) {
                final attribute = attrEntry.value;
                final attrIndex = attrEntry.key;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            attribute.name ?? "Attribute ${attrIndex + 1}",
                            style: AppFontStyle.text_16_400(
                              AppColors.black,
                              family: AppFontFamily.gilroyRegular,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        wBox(8),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                    if (attrIndex < attributeGroup.attributes!.length - 1) hBox(8),
                  ],
                );
              }).toList(),
              if (groupIndex < controllerToUse.productData.value.product!.productAttributes!.length - 1) hBox(12),
            ],
          );
        }).toList(),
      ],
    );
  }*/

  // Add these helper widgets at the top of the class
  Widget _buildToggleableRadioButton({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        constraints: BoxConstraints(maxWidth: 100),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                title,
                style: AppFontStyle.text_16_400(
                  AppColors.black,
                  family: AppFontFamily.gilroySemiBold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            wBox(8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.lightText,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                ),
              )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

// Updated addToCartPopUp function with ProductDetailsScreen-like UI
  Future<dynamic> addToCartPopUp(BuildContext context, CategoryProduct? product) {
    // Directly use the product data from RestaurantCategoryDetailsModal
    final hasOptions = product?.options != null && product!.options!.isNotEmpty;
    final hasAddOns = product?.addOns != null && product!.addOns!.isNotEmpty;
    final hasAttributes = product?.productAttributes != null &&
        product!.productAttributes!.isNotEmpty;
    final hasAnyContent = hasOptions || hasAddOns || hasAttributes;

    // Create local variables for state management
    RxInt localCartCount = 1.obs;
    RxList<Map<String, dynamic>> selectedAddOns = <Map<String, dynamic>>[].obs;
    RxMap<String, String?> selectedOptions = <String, String?>{}.obs;
    RxList<String> extrasTitlesIdsId = <String>[].obs;
    RxList<String> extrasItemIdsId = <String>[].obs;
    RxList<String> extrasItemIdsName = <String>[].obs;
    RxList<String> extrasItemIdsPrice = <String>[].obs;

    // Initialize addons selection state
    if (hasAddOns) {
      for (var addOn in product!.addOns!) {
        addOn.isSelected.value = false;
      }
    }

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: true,
          child: AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: EdgeInsets.zero,
            backgroundColor: AppColors.white,
            content: StatefulBuilder(
              builder: (context, setState) {
                // Helper functions for handling selections
                void toggleAddOnSelection(addOn) {
                  final existingIndex = selectedAddOns.indexWhere(
                          (item) => item['id'] == addOn.id);
                  if (existingIndex != -1) {
                    selectedAddOns.removeAt(existingIndex);
                    addOn.isSelected.value = false;
                  } else {
                    if (selectedAddOns.length < 9) {
                      selectedAddOns.add({
                        'id': addOn.id,
                        'name': addOn.name,
                        'price': addOn.price,
                      });
                      addOn.isSelected.value = true;
                    } else {
                      Utils.showToast("Maximum 9 add-ons can be selected");
                    }
                  }
                  setState(() {});
                }

                void toggleOptionSelection(String optionId, String optionName,
                    String choiceName, String choicePrice) {
                  if (selectedOptions[optionId] == choiceName) {
                    // Deselect
                    selectedOptions.remove(optionId);

                    // Remove from arrays
                    int indexToRemove =
                    extrasTitlesIdsId.indexWhere((id) => id == optionId);
                    if (indexToRemove != -1) {
                      extrasTitlesIdsId.removeAt(indexToRemove);
                      extrasItemIdsId.removeAt(indexToRemove);
                      extrasItemIdsName.removeAt(indexToRemove);
                      extrasItemIdsPrice.removeAt(indexToRemove);
                    }
                  } else {
                    // Select (radio behavior - one per option)
                    selectedOptions[optionId] = choiceName;

                    // Find if this option is already selected
                    int existingIndex =
                    extrasTitlesIdsId.indexWhere((id) => id == optionId);

                    if (existingIndex != -1) {
                      // Update existing
                      extrasItemIdsName[existingIndex] = choiceName;
                      extrasItemIdsPrice[existingIndex] = choicePrice;
                    } else {
                      // Add new
                      extrasTitlesIdsId.add(optionId);
                      extrasItemIdsId.add(optionId);
                      extrasItemIdsName.add(choiceName);
                      extrasItemIdsPrice.add(choicePrice);
                    }
                  }
                  setState(() {});
                }

                bool isAddOnSelected(String addOnId) {
                  return selectedAddOns.any((item) => item['id'] == addOnId);
                }

                bool isOptionSelected(String optionId, String choiceName) {
                  return selectedOptions[optionId] == choiceName;
                }

                // Widget for Options Section (like ProductDetailsScreen)
                Widget buildOptionsSection() {
                  if (!hasOptions) return SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Loop through each option
                      ...product!.options!.asMap().entries.map((entry) {
                        final option = entry.value;
                        final index = entry.key;

                        if (option.choices == null || option.choices!.isEmpty) {
                          return SizedBox.shrink();
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Option Name (Heading)
                            Text(
                              option.optionName ?? "Option ${index + 1}",
                              style: AppFontStyle.text_20_500(
                                AppColors.darkText,
                                family: AppFontFamily.gilroySemiBold,
                              ),
                            ),

                            // Required/Selection info
                            if (option.choices != null &&
                                option.choices!.isNotEmpty) ...[
                              hBox(5),
                              Row(
                                children: [
                                  Text(
                                    "Required",
                                    style: AppFontStyle.text_12_200(
                                      AppColors.lightText,
                                      family: AppFontFamily.gilroyRegular,
                                    ),
                                  ),
                                  Text(
                                    "•",
                                    style: AppFontStyle.text_12_200(
                                      AppColors.lightText,
                                      family: AppFontFamily.gilroyRegular,
                                    ),
                                  ),
                                  wBox(4),
                                  Expanded(
                                    child: Text(
                                      "Select any 1 option",
                                      style: AppFontStyle.text_12_200(
                                        AppColors.lightText,
                                        family: AppFontFamily.gilroyRegular,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            hBox(10),

                            // Choices for this option
                            ...option.choices!.asMap().entries.map((choiceEntry) {
                              final choice = choiceEntry.value;
                              final choiceIndex = choiceEntry.key;
                              final String uniqueKey =
                                  '${option.optionId}_$choiceIndex';

                              return Column(
                                children: [
                                  // Choice Row with FIXED LAYOUT
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Choice Name - Flexible width
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                          choice.name ?? "Choice ${choiceIndex + 1}",
                                          style: AppFontStyle.text_16_400(
                                            AppColors.black,
                                            family: AppFontFamily.gilroyRegular,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),

                                      // Spacing
                                      wBox(8),

                                      // Price and Radio Button - Fixed width
                                      Flexible(
                                        flex: 1,
                                        child: _buildToggleableRadioButton(
                                          title: '\$${choice.price ?? "0.00"}',
                                          isSelected: isOptionSelected(
                                              option.optionId ?? "",
                                              choice.name ?? ""),
                                          onTap: () {
                                            toggleOptionSelection(
                                              option.optionId ?? "",
                                              option.optionName ?? "",
                                              choice.name ?? "",
                                              choice.price ?? "0",
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Add spacing between choices (except last one)
                                  if (choiceIndex < option.choices!.length - 1)
                                    hBox(8),
                                ],
                              );
                            }).toList(),

                            // Add spacing between options (except last one)
                            if (index < product!.options!.length - 1) hBox(20.h),
                          ],
                        );
                      }).toList(),
                    ],
                  );
                }

                // Widget for AddOns Section (like ProductDetailsScreen)
                Widget buildAddOnsSection() {
                  if (!hasAddOns) return SizedBox.shrink();

                  // Show only first 6 items initially
                  int totalAddons = product!.addOns!.length;
                  int initialShowCount = 6;
                  RxBool showAll = false.obs;
                  int itemsToShow = showAll.value
                      ? totalAddons
                      : min(totalAddons, initialShowCount);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add On",
                        style: AppFontStyle.text_20_500(AppColors.darkText,
                            family: AppFontFamily.gilroySemiBold),
                      ),
                      hBox(5),
                      Row(
                        children: [
                          Text(
                            "Select any option",
                            style: AppFontStyle.text_12_200(AppColors.lightText,
                                family: AppFontFamily.gilroyRegular),
                          ),
                        ],
                      ),
                      hBox(10),

                      Column(
                        children: [
                          // Show addons from API
                          ...List.generate(
                            itemsToShow,
                                (index) {
                              final addOn = product!.addOns![index];
                              bool isSelected = isAddOnSelected(addOn.id ?? '');

                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Addon name
                                      Text(
                                        addOn.name ?? "Addon ${index + 1}",
                                        style: AppFontStyle.text_16_400(
                                          AppColors.black,
                                          family: AppFontFamily.gilroyRegular,
                                        ),
                                      ),

                                      // Price and checkbox
                                      Row(
                                        children: [
                                          // Price
                                          Text(
                                            "\$${addOn.price ?? "0.00"}",
                                            style: AppFontStyle.text_16_600(
                                              AppColors.black,
                                              family: AppFontFamily.gilroyRegular,
                                            ),
                                          ),
                                          wBox(10),

                                          // Checkbox
                                          Obx(() => GestureDetector(
                                            onTap: () {
                                              toggleAddOnSelection(addOn);
                                            },
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: addOn.isSelected.value
                                                    ? AppColors.primary
                                                    : Colors.transparent,
                                                border: Border.all(
                                                  color: addOn.isSelected.value
                                                      ? AppColors.primary
                                                      : AppColors.lightText,
                                                  width:
                                                  addOn.isSelected.value
                                                      ? 6
                                                      : 1,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(4.r),
                                              ),
                                              child: addOn.isSelected.value
                                                  ? Center(
                                                child: Icon(
                                                  Icons.check,
                                                  size: 10,
                                                  color: Colors.white,
                                                ),
                                              )
                                                  : null,
                                            ),
                                          )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (index < itemsToShow - 1) hBox(8),
                                ],
                              );
                            },
                          ),

                          // Show More/Less button if more than initial items
                          if (totalAddons > initialShowCount) ...[
                            hBox(10),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                showAll.value = !showAll.value;
                                setState(() {});
                              },
                              child: Container(
                                padding:
                                REdgeInsets.symmetric(vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primary.withOpacity(0.5)),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      showAll.value
                                          ? "-${totalAddons - initialShowCount} Less"
                                          : "+${totalAddons - initialShowCount} More",
                                      style: AppFontStyle.text_14_600(
                                          AppColors.primary,
                                          family: AppFontFamily.gilroyRegular),
                                    ),
                                    wBox(4),
                                    Icon(
                                      showAll.value
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: AppColors.primary,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  );
                }

                // Widget for Attributes Section (like ProductDetailsScreen)
                Widget buildAttributesSection() {
                  if (!hasAttributes) return SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Attributes",
                        style: AppFontStyle.text_20_500(
                          AppColors.darkText,
                          family: AppFontFamily.gilroySemiBold,
                        ),
                      ),
                      hBox(10),

                      // Loop through each product attribute group
                      ...product!.productAttributes!.asMap().entries.map((entry) {
                        final attributeGroup = entry.value;
                        final groupIndex = entry.key;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Display group name if it exists
                            if (attributeGroup.groupName != null &&
                                attributeGroup.groupName!.isNotEmpty)
                              Column(
                                children: [
                                  Text(
                                    attributeGroup.groupName!,
                                    style: AppFontStyle.text_18_600(
                                      AppColors.darkText,
                                      family: AppFontFamily.gilroyMedium,
                                    ),
                                  ),
                                  hBox(10),
                                ],
                              ),

                            // Loop through each attribute in this group
                            ...attributeGroup.attributes!.asMap().entries.map((attrEntry) {
                              final attribute = attrEntry.value;
                              final attrIndex = attrEntry.key;

                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: Text(
                                          attribute.name ?? "Attribute ${attrIndex + 1}",
                                          style: AppFontStyle.text_16_400(
                                            AppColors.black,
                                            family: AppFontFamily.gilroyRegular,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      wBox(8),
                                      Flexible(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                  if (attrIndex < attributeGroup.attributes!.length - 1)
                                    hBox(8),
                                ],
                              );
                            }).toList(),

                            // Space between groups
                            if (groupIndex < product!.productAttributes!.length - 1)
                              hBox(12),
                          ],
                        );
                      }).toList(),
                    ],
                  );
                }

                return SizedBox(
                  width: Get.width * 0.95,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          hBox(40.h),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, right: 16, left: 16, bottom: 16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Show message if no content
                                    if (!hasAnyContent)
                                      Container(
                                        padding: REdgeInsets.symmetric(vertical: 40),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                color: AppColors.primary,
                                                size: 40,
                                              ),
                                              hBox(10),
                                              Text(
                                                "No addons available",
                                                style: AppFontStyle.text_16_400(
                                                  AppColors.darkText,
                                                  family: AppFontFamily.gilroyMedium,
                                                ),
                                              ),
                                              hBox(5),
                                              Text(
                                                "You can add this product directly to cart",
                                                style: AppFontStyle.text_14_400(
                                                  AppColors.lightText,
                                                  family: AppFontFamily.gilroyRegular,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),

                                    // Show content if available
                                    if (hasAnyContent) ...[
                                      // Options Section
                                      if (hasOptions) buildOptionsSection(),
                                      if (hasOptions && (hasAddOns || hasAttributes))
                                        hBox(20.h),

                                      // AddOns Section
                                      if (hasAddOns) buildAddOnsSection(),
                                      if (hasAddOns && hasAttributes) hBox(20.h),

                                      // Attributes Section
                                      if (hasAttributes) buildAttributesSection(),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Obx(() => CustomElevatedButton(
                              fontFamily: AppFontFamily.gilroyMedium,
                              width: Get.width,
                              color: addToCartController.goToCart.value
                                  ? AppColors.primary
                                  : AppColors.darkText,
                              isLoading: addToCartController.rxRequestStatusPopUp
                                  .value ==
                                  (Status.LOADING),
                              text: addToCartController.goToCart.value
                                  ? "Go to Cart"
                                  : "Add to Cart",
                              onPressed: () {
                                if (getUserDataController
                                    .userData.value.user?.userType ==
                                    "guestUser") {
                                  showLoginRequired(context);
                                  return;
                                }

                                // Prepare data for API
                                final addonsIds = selectedAddOns
                                    .map((addon) => addon['id'].toString())
                                    .toList();
                                final addonsNames = selectedAddOns
                                    .map((addon) => addon['name'].toString())
                                    .toList();
                                final addonsPrices = selectedAddOns
                                    .map((addon) => addon['price'].toString())
                                    .toList();

                                print("=== Sending to API ===");
                                print("Selected AddOns IDs: $addonsIds");
                                print("Selected Options IDs: ${extrasTitlesIdsId}");
                                print("Selected Option Names: ${extrasItemIdsName}");
                                print("Selected Option Prices: ${extrasItemIdsPrice}");

                                // Call your addToCart API
                                addToCartController.addToCartApi_in_categoryProduct(
                                  isPopUp: true,
                                  cartId: product?.id.toString(),
                                  productId: product?.id.toString() ?? '',
                                  productPrice: product?.salePrice?.toString() ??
                                      product?.regularPrice?.toString() ??
                                      '0',
                                  productQuantity: localCartCount.value.toString(),
                                  restaurantId: product?.vendorId.toString() ?? '',
                                  addons: addonsIds,
                                  extrasIds: extrasTitlesIdsId.toList(),
                                  extrasItemIds: extrasItemIdsId.toList(),
                                  extrasItemNames: extrasItemIdsName.toList(),
                                  extrasItemPrices: extrasItemIdsPrice.toList(),
                                );
                              },
                            )),
                          ),
                        ],
                      ),
                      // Close Icon
                      Positioned(
                        right: 0,
                        top: 0,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                            addToCartController.clearSelected();
                          },
                          icon:
                          Icon(Icons.cancel, color: AppColors.primary, size: 26),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

// Remove the old extra, addOn, productAttributes functions and replace them with:

  Widget extra({CategoryProduct? product, StateSetter? setState}) {
    if (product?.options == null || product!.options!.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Loop through each option
        ...product.options!.asMap().entries.map((entry) {
          final option = entry.value;
          final index = entry.key;

          if (option.choices == null || option.choices!.isEmpty) {
            return SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                option.optionName ?? "Option ${index + 1}",
                style: AppFontStyle.text_20_500(
                  AppColors.darkText,
                  family: AppFontFamily.gilroySemiBold,
                ),
              ),
              hBox(5),
              Row(
                children: [
                  Text(
                    "Required",
                    style: AppFontStyle.text_12_200(
                      AppColors.lightText,
                      family: AppFontFamily.gilroyRegular,
                    ),
                  ),
                  Text(
                    "•",
                    style: AppFontStyle.text_12_200(
                      AppColors.lightText,
                      family: AppFontFamily.gilroyRegular,
                    ),
                  ),
                  wBox(4),
                  Expanded(
                    child: Text(
                      "Select any 1 option",
                      style: AppFontStyle.text_12_200(
                        AppColors.lightText,
                        family: AppFontFamily.gilroyRegular,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              hBox(10),
              ...option.choices!.asMap().entries.map((choiceEntry) {
                final choice = choiceEntry.value;
                final choiceIndex = choiceEntry.key;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            choice.name ?? "Choice ${choiceIndex + 1}",
                            style: AppFontStyle.text_16_400(
                              AppColors.black,
                              family: AppFontFamily.gilroyRegular,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        wBox(8),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                    if (choiceIndex < option.choices!.length - 1) hBox(8),
                  ],
                );
              }).toList(),
              if (index < product.options!.length - 1) hBox(20.h),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget addOn({CategoryProduct? product}) {
    if (product?.addOns == null || product!.addOns!.isEmpty) {
      return SizedBox.shrink();
    }

    // Show only first 6 items initially
    int totalAddons = product.addOns!.length;
    int initialShowCount = 6;
    RxBool showAll = false.obs;
    int itemsToShow = showAll.value ? totalAddons : min(totalAddons, initialShowCount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add On",
          style: AppFontStyle.text_20_500(AppColors.darkText,
              family: AppFontFamily.gilroySemiBold),
        ),
        hBox(5),
        Row(
          children: [
            Text(
              "Select any option",
              style: AppFontStyle.text_12_200(AppColors.lightText,
                  family: AppFontFamily.gilroyRegular),
            ),
          ],
        ),
        hBox(10),
        Column(
          children: [
            // Show addons from API
            ...List.generate(
              itemsToShow,
                  (index) {
                final addOn = product.addOns![index];

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Addon name
                        Text(
                          addOn.name ?? "Addon ${index + 1}",
                          style: AppFontStyle.text_16_400(
                            AppColors.black,
                            family: AppFontFamily.gilroyRegular,
                          ),
                        ),

                        // Price
                        Text(
                          "\$${addOn.price ?? "0.00"}",
                          style: AppFontStyle.text_16_600(
                            AppColors.black,
                            family: AppFontFamily.gilroyRegular,
                          ),
                        ),
                      ],
                    ),
                    if (index < itemsToShow - 1) hBox(8),
                  ],
                );
              },
            ),

            // Show More/Less button if more than initial items
            if (totalAddons > initialShowCount) ...[
              hBox(10),
              Obx(() => InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  showAll.value = !showAll.value;
                },
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    border:
                    Border.all(color: AppColors.primary.withOpacity(0.5)),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        showAll.value
                            ? "-${totalAddons - initialShowCount} Less"
                            : "+${totalAddons - initialShowCount} More",
                        style: AppFontStyle.text_14_600(AppColors.primary,
                            family: AppFontFamily.gilroyRegular),
                      ),
                      wBox(4),
                      Icon(
                        showAll.value ? Icons.expand_less : Icons.expand_more,
                        color: AppColors.primary,
                        size: 18,
                      )
                    ],
                  ),
                ),
              )),
            ],
          ],
        ),
      ],
    );
  }

  Widget productAttributes({CategoryProduct? product}) {
    if (product?.productAttributes == null ||
        product!.productAttributes!.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Attributes",
          style: AppFontStyle.text_20_500(
            AppColors.darkText,
            family: AppFontFamily.gilroySemiBold,
          ),
        ),
        hBox(10),

        // Loop through each product attribute group
        ...product.productAttributes!.asMap().entries.map((entry) {
          final attributeGroup = entry.value;
          final groupIndex = entry.key;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display group name if it exists
              if (attributeGroup.groupName != null &&
                  attributeGroup.groupName!.isNotEmpty)
                Column(
                  children: [
                    Text(
                      attributeGroup.groupName!,
                      style: AppFontStyle.text_18_600(
                        AppColors.darkText,
                        family: AppFontFamily.gilroyMedium,
                      ),
                    ),
                    hBox(10),
                  ],
                ),

              // Loop through each attribute in this group
              ...attributeGroup.attributes!.asMap().entries.map((attrEntry) {
                final attribute = attrEntry.value;
                final attrIndex = attrEntry.key;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            attribute.name ?? "Attribute ${attrIndex + 1}",
                            style: AppFontStyle.text_16_400(
                              AppColors.black,
                              family: AppFontFamily.gilroyRegular,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        wBox(8),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                    if (attrIndex < attributeGroup.attributes!.length - 1) hBox(8),
                  ],
                );
              }).toList(),

              // Space between groups
              if (groupIndex < product.productAttributes!.length - 1) hBox(12),
            ],
          );
        }).toList(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String categoryTitle = args['name'] ?? "";
    final int categoryId = args['id'] ?? 0;

    return Container(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          // bottomNavigationBar: navBarStatic(navbarItems),
          appBar: CustomAppBar(
            title: Text(
              categoryTitle,
              style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.gilroyRegular),
            ),
          ),
          body: Obx(() {
            switch (controller.rxRequestStatus.value) {
              case Status.LOADING:
                return Center(child: circularProgressIndicator());
              case Status.ERROR:
                if (controller.error.value == 'No internet'  || controller.error.value == 'InternetExceptionWidget') {
                  return InternetExceptionWidget(
                    onPress: () {
                      controller.restaurant_Categories_Details_Api(
                          id: categoryId.toString());
                    },
                  );
                } else {
                  return GeneralExceptionWidget(
                    onPress: () {
                      controller.restaurant_Categories_Details_Api(
                          id: categoryId.toString());
                    },
                  );
                }
              case Status.COMPLETED:
                return RefreshIndicator(
                    onRefresh: () async {
                      categoriesFilterController.resetFilters();
                      controller.restaurant_Categories_Details_Api(id: categoryId.toString());
                    },
                    child: Padding(
                      padding: REdgeInsets.symmetric(horizontal: 24),
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            // pinned: false,
                            // snap: true,
                            // floating: true,
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
                                  controller: controller.searchController,
                                  onChanged: (value) {
                                    if (controller.categoriesDetailsData.value
                                        .filterProduct!.isEmpty) {
                                      controller.searchDataFun(value);
                                    } else {
                                      controller.filterSearchDataFun(value);
                                    }
                                  },
                                  onFilterTap: () {
                                    Get.toNamed(
                                      AppRoutes.restaurantCategoriesFilter,
                                      arguments: {
                                        'categoryId': categoryId.toString()
                                      },
                                    );
                                    // Get.toNamed(AppRoutes.restaurantCategoriesNewFilter);
                                    categoriesFilterController.restaurant_get_CategoriesFilter_Api(categoryId.toString());
                                  },
                                )),
                              ),
                              centerTitle: true,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: hBox(10.h),
                          ),
                          if (controller.categoriesDetailsData.value.filterProduct!.isEmpty &&controller.categoriesDetailsData.value.categoryProduct!.isEmpty
                              // ||(controller.categoriesDetailsData.value.filterProduct!.isEmpty  && controller.searchController.text.isNotEmpty)
                              // ||(controller.categoriesDetailsData.value.categoryProduct!.isEmpty && controller.searchController.text.isNotEmpty)
                          )...[
                            SliverToBoxAdapter(
                              child:CustomNoDataFound(heightBox: hBox(50.h))
                            ),
                          ],
                          //------------------------------------------------------------------
                          if (controller.categoriesDetailsData.value.filterProduct!.isEmpty)...[
                            if (controller.searchController.text.isNotEmpty && controller.searchData.isEmpty)...[
                            const SliverToBoxAdapter(
                            child: CustomNoDataFound(),
                            ),
                            ]
                            else...[
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: controller.searchData.length,
                                    (context, index) {
                                  var product = controller.searchData[index];
                                  return GestureDetector(
                                      onTap: () {
                                        specific_product_controllerontroller
                                            .specific_Product_Api(
                                                productId:
                                                    product.id.toString(),
                                                categoryId:
                                                    categoryId.toString());
                                        Get.to(()=>ProductDetailsScreen(
                                          productId: product.id.toString(),
                                          categoryId: categoryId.toString(),
                                          categoryName: categoryTitle,
                                          restaurantId: product.vendorId.toString(),
                                        ));
                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:BorderRadius.circular(20.r),
                                                ),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: "${product.image}"
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    height: 160.h,
                                                    width: double.maxFinite,
                                                    errorWidget: (context, url,
                                                            error) => Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(color: AppColors.greyBackground),
                                                        color: AppColors.transparent,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20.r),
                                                      ),
                                                      child: Icon(Icons.broken_image_rounded,color: AppColors.greyImageColor,),
                                                    ),
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                              baseColor: AppColors.greyBackground,
                                                        highlightColor:
                                                          AppColors.lightText,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors.gray,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Obx(
                                                () => Container(
                                                  margin: REdgeInsets.only(
                                                      top: 10, right: 10),
                                                  padding: REdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: AppColors
                                                        .greyBackground,
                                                  ),
                                                  child: InkWell(
                                                    highlightColor:Colors.transparent,
                                                    splashColor: Colors.transparent,
                                                    onTap: () async {
                                                      if (getUserDataController.userData.value.user?.userType =="guestUser") {
                                                        showLoginRequired(context);
                                                      }else{
                                                      product.isInWishlist = !product.isInWishlist!;
                                                      product.isLoading.value = true;
                                                      await add_Wishlist_Controller.restaurant_add_product_wishlist(categoryId: categoryId.toString(), product_id: product.id.toString(),);
                                                      product.isLoading.value =
                                                          false;
                                                      }
                                                    },
                                                    child: product.isLoading.value
                                                        ? circularProgressIndicator(size: 18)
                                                        : Icon(product.isInWishlist == true
                                                                ? Icons.favorite
                                                                : Icons.favorite_border_outlined,
                                                            size: 22,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              // Positioned(
                                              //   bottom: 10,right: 10,
                                              //   child: Obx(
                                              //     ()=> InkWell(
                                              //       onTap: () {
                                              //         controller.searchData[index].isAddToCart.value = true;
                                              //       },
                                              //       child: Container(
                                              //         height: 30.h,width: 30.w,
                                              //       decoration: BoxDecoration(color: AppColors.primary,
                                              //       // shape: BoxShape.circle,
                                              //       borderRadius: BorderRadius.circular(10.r)
                                              //       ),
                                              //       child: Icon( controller.searchData[index].isAddToCart.value ? Icons.done :Icons.add,
                                              //         color: AppColors.white,size: 20,),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                          hBox(10.h),
                                          Row(
                                            children: [
                                              Text(
                                                product.title.toString(),
                                                textAlign: TextAlign.left,
                                                style: AppFontStyle.text_14_400(
                                                    AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                              ),
                                              const Spacer(),
                                              SvgPicture.asset(
                                                "assets/svg/star-yellow.svg",
                                                height: 12,
                                              ),
                                              wBox(4),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 3.0),
                                                child: Text(
                                                  "${product.rating}",
                                                  style: AppFontStyle.text_12_400(AppColors.darkText,
                                                      family: AppFontFamily.gilroyMedium),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Flexible(
                                            child: Text(
                                              product.restoName.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppFontStyle.text_14_300(
                                                  AppColors.lightText,family: AppFontFamily.gilroyRegular),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 20,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: AppColors.primary.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(15.r),
                                                    border: Border.all(
                                                      color: AppColors.primary,
                                                    )
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "\$${product.regularPrice ?? '0'}",
                                                    style: AppFontStyle.text_10_400(AppColors.black,
                                                        family: AppFontFamily.gilroyRegular
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              SvgPicture.asset(
                                                ImageConstants.clockIcon,
                                                height: 10,
                                                colorFilter:
                                                ColorFilter.mode(AppColors.darkText, BlendMode.srcIn),
                                              ),
                                              wBox(3.w),
                                              Text(
                                                product.preparationTime.toString(),
                                                style: AppFontStyle.text_10_400(AppColors.darkText,
                                                    family: AppFontFamily.gilroyRegular),
                                              ),
                                              const Spacer(),
                                              GetBuilder<AddToCartController>(
                                                builder: (cartController) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      /*if (getUserDataController.userData.value.user?.userType == "guestUser") {
                                                        showLoginRequired(context);
                                                      } else {
                                                        cartController.addToCartApi(
                                                            productId: product.id.toString(),
                                                            productQuantity: '1',
                                                            productPrice: product.regularPrice,
                                                            restaurantId: product.vendorId.toString(),
                                                            addons: [],
                                                            extrasIds: [],
                                                            extrasItemIds: [],
                                                            extrasItemNames: [],
                                                            extrasItemPrices: [],
                                                            isPopUp: false
                                                        );
                                                      }*/
                                                      if(product.addOns!.isNotEmpty || product.options!.isNotEmpty || product.productAttributes!.isNotEmpty)
                                                      addToCartPopUp(Get.context!, product);
                                                      else
                                                        cartController.addToCartApi(
                                                            productId: product.id.toString(),
                                                            productQuantity: '1',
                                                            productPrice: product.regularPrice,
                                                            restaurantId: product.vendorId.toString(),
                                                            addons: [],
                                                            extrasIds: [],
                                                            extrasItemIds: [],
                                                            extrasItemNames: [],
                                                            extrasItemPrices: [],
                                                            isPopUp: false
                                                        );
                                                    },
                                                    child: cartController.isCartLoading(product.id.toString())
                                                        ? circularProgressIndicator(size: 30)
                                                        : Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                          color: AppColors.black,
                                                          borderRadius: BorderRadius.circular(20)
                                                      ),
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 20,
                                                        color: AppColors.white,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ));
                                  //  categoryItem(index);
                                }),
                                gridDelegate:
                                    (SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6.w,
                                  crossAxisSpacing: 14.w,
                                  mainAxisSpacing: 5.h,
                                ))),
                            ],
                          ],
                          //------------------------------------------------------------------

                          if (controller.categoriesDetailsData.value.filterProduct!.isNotEmpty)...[
                          if (controller.searchController.text.isNotEmpty && controller.filterProductSearchData.isEmpty)...[
                            const SliverToBoxAdapter(
                              child: CustomNoDataFound(),
                            ),
                          ] else...[
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                 childCount: controller.filterProductSearchData.length, (context, index) {
                                  var product =controller.filterProductSearchData[index];
                                  return GestureDetector(
                                      onTap: () {
                                        specific_product_controllerontroller.specific_Product_Api(
                                                productId:product.id.toString(),
                                                categoryId:categoryId.toString());
                                        Get.to(ProductDetailsScreen(
                                          cuisineType: categoriesFilterController.selectedCuisines.join(', '),
                                          priceRange: "${categoriesFilterController.lowerValue.value},${categoriesFilterController.upperValue.value}",
                                          priceSort: categoriesFilterController.priceRadioValue.value == 0 ? ""
                                          : categoriesFilterController.priceRadioValue.value == 1 ? "low to high" : "high to low",
                                          quickFilter: categoriesFilterController.selectedQuickFilters.toString(),
                                          productId: product.id.toString(),
                                          categoryId: categoryId.toString(),
                                          categoryName: categoryTitle,
                                        ));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              Container(
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.r),
                                                ),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: product.urlImage.toString(),
                                                    fit: BoxFit.cover,
                                                    height: 160.h,
                                                    errorWidget: (context, url,
                                                        error) => Container(
                                                      width: Get.width,
                                                      decoration:
                                                      BoxDecoration(
                                                        border: Border.all(color: AppColors.greyBackground),
                                                        color: AppColors.transparent,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            20.r),
                                                      ),
                                                      child: Icon(Icons.broken_image_rounded,color: AppColors.greyImageColor,),
                                                    ),
                                                    placeholder:(context, url) =>Shimmer.fromColors(
                                                      baseColor: AppColors.greyBackground,
                                                      highlightColor:AppColors.lightText,
                                                      child: Container(
                                                        decoration:BoxDecoration(
                                                          color: AppColors.gray,
                                                          borderRadius:BorderRadius.circular(20.r),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Obx(
                                                () => Container(
                                                  margin: REdgeInsets.only(top: 10, right: 10),
                                                  padding: REdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    borderRadius:BorderRadius.circular(10.r),
                                                    color: AppColors.greyBackground,
                                                  ),
                                                  child: InkWell(
                                                    highlightColor:Colors.transparent,
                                                    splashColor:Colors.transparent,
                                                    onTap: () async {
                                                      if (getUserDataController.userData.value.user?.userType =="guestUser") {
                                                        showLoginRequired(context);
                                                      }else{
                                                      product.isInWishlist =!product.isInWishlist!;
                                                      product.isLoading.value =true;
                                                      await add_Wishlist_Controller.restaurant_add_product_wishlist(
                                                        cuisineType: categoriesFilterController.selectedCuisines.join(', '),
                                                        priceRange:categoriesFilterController.priceRadioValue.value == 1 ? ""
                                                            : "${categoriesFilterController.lowerValue.value},${categoriesFilterController.upperValue.value}",
                                                        priceSort: categoriesFilterController.priceRadioValue.value == 0 ? ""
                                                            : categoriesFilterController.priceRadioValue.value == 1 ? "low to high" : "high to low",
                                                        quickFilter:categoriesFilterController.priceRadioValue.value == 1 ? ""
                                                                   : categoriesFilterController.selectedQuickFilters.toString(),
                                                        categoryId: categoryId.toString(),
                                                        product_id: product.id.toString(),
                                                      );
                                                      product.isLoading.value =false;
                                                      }
                                                    },
                                                    child: product.isLoading.value
                                                        ? circularProgressIndicator(size: 18)
                                                        : Icon(
                                                            product.isInWishlist == true
                                                                ? Icons.favorite
                                                                : Icons.favorite_border_outlined,
                                                            size: 22,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              // Positioned(
                                              //   bottom: 10,right: 10,
                                              //   child: Obx(
                                              //         ()=> InkWell(
                                              //       onTap: () {
                                              //         controller.filterProductSearchData[index].isAddToCart.value = true;
                                              //       },
                                              //       child: Container(
                                              //         height: 30.h,width: 30.w,
                                              //         decoration: BoxDecoration(color: AppColors.primary,
                                              //             // shape: BoxShape.circle,
                                              //             borderRadius: BorderRadius.circular(10.r)
                                              //         ),
                                              //         child: Icon( controller.filterProductSearchData[index].isAddToCart.value ? Icons.done :Icons.add,
                                              //           color: AppColors.white,size: 20,),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          hBox(10),
                                          Row(
                                            children: [
                                              Text(
                                                "\$${product.salePrice ?? product.regularPrice}",
                                                textAlign: TextAlign.left,
                                                style: AppFontStyle.text_16_600(
                                                    AppColors.primary,family: AppFontFamily.gilroyRegular),
                                              ),
                                              wBox(5),
                                              Text(
                                                "\$${product.regularPrice}",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w300,
                                                    color: AppColors.lightText,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    decorationColor:
                                                        AppColors.lightText,
                                                    fontFamily: AppFontFamily.gilroyRegular,
                                                ),

                                                //  AppFontStyle.text_14_300(AppColors.lightText),
                                              ),
                                            ],
                                          ),
                                          // hBox(10),
                                          Text(
                                            product.title.toString(),
                                            textAlign: TextAlign.left,
                                            style: AppFontStyle.text_16_400(
                                                AppColors.darkText,family: AppFontFamily.gilroyMedium),
                                          ),
                                          // hBox(10),

                                          // hBox(10),
                                          // Row(
                                          //   children: [
                                          //     SvgPicture.asset(
                                          //         "assets/svg/star-yellow.svg"),
                                          //     wBox(4),
                                          //     Text(
                                          //       "${product.rating.toString()}/5",
                                          //       style: AppFontStyle.text_14_300(
                                          //           AppColors.lightText),
                                          //     ),
                                          //     wBox(4),
                                          Flexible(
                                            child: Text(
                                              product.restoName.toString(),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppFontStyle.text_14_300(
                                                  AppColors.lightText,family: AppFontFamily.gilroyRegular),
                                            ),
                                          ),
                                          //   ],
                                          // )
                                        ],
                                      ));
                                  //  categoryItem(index);
                                }),
                                gridDelegate:(SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.6.w,
                                  crossAxisSpacing: 14.w,
                                  mainAxisSpacing: 5.h,
                                  // crossAxisCount: 2,
                                  // childAspectRatio: 0.6.w,
                                  // crossAxisSpacing: 16.w,
                                  // mainAxisSpacing: 5.h,
                                ))),
                            ],
                          ],
                          //------------------------------------------------------------------

                          SliverToBoxAdapter(
                            child: hBox(70.h),
                          ),
                        ],
                      ),
                    ),
                );
            }
          },
         ),
        ),
      ),
    );
  }
  // Container navBarStatic() {
  //   List<String> navbarItems = [
  //     ImageConstants.home,
  //     ImageConstants.categories,
  //     ImageConstants.wishlist,
  //     ImageConstants.cart,
  //     ImageConstants.profileOutlined,
  //   ];
  //   return Container( height: 70.h,
  //         width: Get.width,
  //         decoration: BoxDecoration(
  //           color: AppColors.navbar,
  //           borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)
  //           ),
  //         ),
  //         child:  Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: List.generate(navbarItems.length, (index) {
  //               bool isSelected = navbarController.navbarCurrentIndex == index;
  //               // String icon = isSelected ? navbarItemsFilled[index] : navbarItems[index];
  //               return InkWell(
  //                 highlightColor: Colors.transparent,
  //                 splashColor: Colors.transparent,
  //                 onTap: () {
  //                   // Get.to(RestaurantNavbar(navbarInitialIndex: index));
  //                   navbarController.getIndex(index);
  //                   Get.to(RestaurantNavbar(navbarInitialIndex: index));
  //                 },
  //                 child: Padding(
  //                   padding: REdgeInsets.symmetric(horizontal: 12),
  //                   child: AnimatedContainer(
  //                     duration: const Duration(milliseconds: 300),
  //                     curve: Curves.easeInOut,
  //                     width: 44.w,
  //                     child: Stack(
  //                       children: [
  //                         Column(
  //                           children: [
  //                             AnimatedContainer(
  //                               duration: const Duration(milliseconds: 300),
  //                               curve: Curves.linear,
  //                               height: 4.h,
  //                               width: 44.w,
  //                               decoration: BoxDecoration(
  //                                   color:
  //                                   // isSelected
  //                                   //     ? AppColors.primary
  //                                   //     :
  //                                   Colors.transparent,
  //                                   borderRadius: BorderRadius.only(
  //                                       bottomLeft: Radius.circular(10.r),
  //                                       bottomRight: Radius.circular(10.r))),
  //                             ),
  //                             Padding(
  //                               padding:
  //                               REdgeInsets.only(top: 19, bottom: 23),
  //                               child: SvgPicture.asset(
  //                                 navbarItems[index],
  //                                 height: 24.h,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             })
  //           // navbarItems.map((icon) {
  //           //   int index = navbarItems.indexOf(icon);
  //           //   bool isSelected = navbarController.navbarCurrentIndex == index;
  //           //   return GestureDetector(
  //           //     onTap: () {
  //           //       navbarController.getIndex(index);
  //           //     },
  //           //     child: Padding(
  //           //       padding: REdgeInsets.symmetric(horizontal: 12),
  //           //       child: AnimatedContainer(
  //           //         duration: const Duration(milliseconds: 300),
  //           //         curve: Curves.easeInOut,
  //           //         height: 48.h,
  //           //         width: 48.h,
  //           //         child: Column(
  //           //           children: [
  //           //             SvgPicture.asset(
  //           //               icon,
  //           //             ),
  //           //           ],
  //           //         ),
  //           //       ),
  //           //     ),
  //           //   );
  //           // }).toList(),
  //         ),
  //       );
  // }
}


