import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/modal/specific_product_modal.dart';
import 'package:intl/intl.dart';

/*
class specific_Product_Controller extends GetxController {
  final api = Repository();

  RxString selectedImageUrl = ''.obs;
  RxInt isSelected = 0.obs;
  RxBool isLoading = false.obs;
  RxInt cartCount = 1.obs;
  var productPrice = 0;
  PageController pageController = PageController();
  RxInt priceRadioValue = 0.obs;

  RxBool goToCart = false.obs;
  RxBool isExtraPopUps = false.obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final productData = specificProduct().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void productdata_Set(specificProduct value) => productData.value = value;

  void setError(String value) => error.value = value;

  Map<String, RxInt> optionSelections = <String, RxInt>{}.obs;

  // Lists to store selected option data for API
  List<String> selectedOptionIds = [];
  List<String> selectedOptionNames = [];
  List<String> selectedChoiceNames = [];
  List<String> selectedChoicePrices = [];

  void updateSelectedOptionChoice({
    String? optionId,
    String? optionName,
    String? choiceName,
    String? choicePrice,
  }) {
    // Find if this option is already selected
    int existingIndex = selectedOptionIds.indexWhere((id) => id == optionId);

    if (existingIndex != -1) {
      // Update existing selection
      selectedOptionNames[existingIndex] = optionName ?? '';
      selectedChoiceNames[existingIndex] = choiceName ?? '';
      selectedChoicePrices[existingIndex] = choicePrice ?? '0';
    } else {
      // Add new selection
      selectedOptionIds.add(optionId ?? '');
      selectedOptionNames.add(optionName ?? '');
      selectedChoiceNames.add(choiceName ?? '');
      selectedChoicePrices.add(choicePrice ?? '0');
    }

    update();
  }

  // Method to get all selected options as formatted string
  String getSelectedOptionsSummary() {
    String summary = '';
    for (int i = 0; i < selectedOptionIds.length; i++) {
      summary += '${selectedOptionNames[i]}: ${selectedChoiceNames[i]} (\$${selectedChoicePrices[i]})\n';
    }
    return summary;
  }

  // Method to get total extra price from selected options
  double getTotalExtraPrice() {
    double total = 0;
    for (String price in selectedChoicePrices) {
      total += double.tryParse(price) ?? 0;
    }
    return total;
  }

  specific_Product_Api({
    required String productId,
    required String categoryId,
  }) async {
    goToCart.value = false;
    selectedAddOn.clear();
    extrasTitlesIdsId.clear();
    extrasItemIdsId.clear();
    extrasItemIdsName.clear();
    extrasItemIdsPrice.clear();
    selectedImageUrl.value = "";
    cartCount.value = 1;
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "product_id": productId,
      "category_id": categoryId,
    };
    api.specific_Product_Api(data).then((value) {
      if(value.status == true){
        isSelected = (-1).obs;
        productdata_Set(value);
        setRxRequestStatus(Status.COMPLETED);
      }else if(value.status == false){
        Get.back();
        Utils.showToast("Product is not active.");
        setRxRequestStatus(Status.ERROR);
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }


  refreshSpecificProductApi({
    required String productId,
    required String categoryId,
  }) async {
    // goToCart.value = false;
    // selectedAddOn.clear();
    // extrasTitlesIdsId.clear();
    // extrasItemIdsId.clear();
    // extrasItemIdsName.clear();
    // extrasItemIdsPrice.clear();
    // selectedImageUrl.value = "";
    // cartCount.value = 1;
    // setRxRequestStatus(Status.LOADING);
    Map data = {
      "product_id": productId,
      "category_id": categoryId,
    };
    api.specific_Product_Api(data).then((value) {
      if(value.status == true){
        // isSelected = (-1).obs;
        productdata_Set(value);
        setRxRequestStatus(Status.COMPLETED);
      }else if(value.status == false){
        Get.back();
        Utils.showToast("Product is not active.");
        setRxRequestStatus(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  String formatDate(String? dateString) {
    if (dateString == null) {
      return "";
    }
    try {
      DateTime date = DateTime.parse(dateString);
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);
      print("Formatted Date: $formattedDate");
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e");
      return "";
    }
  }

  // ----------------- add to cart data -----------------
  RxList selectedAddOn = [].obs;
  RxList extrasTitlesIdsId = [].obs;
  RxList extrasItemIdsId = [].obs;
  RxList extrasItemIdsName = [].obs;
  RxList extrasItemIdsPrice = [].obs;


  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // void productPriceFun() {
  //   int count = cartCount.value;
  //   if(productData.value.product!.salePrice != null) {
  //     int? price = productData.value.product!.salePrice;
  //     if (price != null) {
  //       int totalPrice = count * price;
  //       productPrice = totalPrice;
  //       print("Total Price: $totalPrice");
  //     } else {
  //       print("Error: Price is not a valid number");
  //     }
  //   } else {
  //
  //     int? price = productData.value.product!.regularPrice;
  //     if (price != null) {
  //       int totalPrice = count * price;
  //       productPrice = totalPrice;
  //       print("Total Price: $totalPrice");
  //     } else {
  //       print("Error: Price is not a valid number");
  //     }
  //
  //
  //   }
  //   // productPrice = totalPrice;
  //   // print("Total Price: $totalPrice");
  // }
}
*/

class specific_Product_Controller extends GetxController {
  final api = Repository();

  RxString selectedImageUrl = ''.obs;
  RxInt isSelected = 0.obs;
  RxBool isLoading = false.obs;
  RxInt cartCount = 1.obs;
  var productPrice = 0;
  PageController pageController = PageController();
  RxInt priceRadioValue = 0.obs;

  RxBool goToCart = false.obs;
  RxBool isExtraPopUps = false.obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  final productData = specificProduct().obs;

  RxString error = ''.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void productdata_Set(specificProduct value) => productData.value = value;

  void setError(String value) => error.value = value;

  Map<String, RxInt> optionSelections = <String, RxInt>{}.obs;

  // Lists to store selected option data for API
  List<String> selectedOptionIds = [];
  List<String> selectedOptionNames = [];
  List<String> selectedChoiceNames = [];
  List<String> selectedChoicePrices = [];

  RxMap<String, bool> selectedChoices = <String, bool>{}.obs;

  // Track selected options for each option group (for radio behavior)
  RxMap<String, String?> selectedOptions = <String, String?>{}.obs;

  // ----------------- add to cart data -----------------
  RxList selectedAddOn = [].obs;
  RxList extrasTitlesIdsId = [].obs;
  RxList extrasItemIdsId = [].obs;
  RxList extrasItemIdsName = [].obs;
  RxList extrasItemIdsPrice = [].obs;

  void toggleAddOnSelection({
    required String addOnId,
    required String addOnName,
    required String addOnPrice,
  }) {
    // Check if addon is already selected
    int existingIndex = selectedAddOn.indexWhere((addon) => addon['id'] == addOnId);

    if (existingIndex != -1) {
      // Remove addon
      selectedAddOn.removeAt(existingIndex);
    } else {
      // Check max selection limit (9)
      if (selectedAddOn.length < 9) {
        // Add addon with full details
        selectedAddOn.add({
          'id': addOnId,
          'name': addOnName,
          'price': addOnPrice,
        });
      } else {
        // Show message if limit reached
        Utils.showToast("Maximum 9 add-ons can be selected");
      }
    }

    update();
  }

  // Check if addon is selected
  bool isAddOnSelected(String addOnId) {
    return selectedAddOn.any((addon) => addon['id'] == addOnId);
  }

  // Get addon IDs only (for API)
  List<String> getAddOnIds() {
    return selectedAddOn.map((addon) => addon['id'].toString()).toList();
  }

  // Get addon names only (for API)
  List<String> getAddOnNames() {
    return selectedAddOn.map((addon) => addon['name'].toString()).toList();
  }

  // Get addon prices only (for API)
  List<String> getAddOnPrices() {
    return selectedAddOn.map((addon) => addon['price'].toString()).toList();
  }

  // Clear all addon selections
  void clearAddOnSelections() {
    selectedAddOn.clear();
    update();
  }

  // Method to check if a choice is selected
  bool isChoiceSelected(String choiceKey) {
    return selectedChoices[choiceKey] ?? false;
  }

  // Method to toggle choice selection with radio button behavior
  void toggleChoiceSelection({
    String? optionId,
    String? optionName,
    required String choiceKey,
    String? choiceName,
    String? choicePrice,
    bool isRequired = false,
  }) {
    // For radio button behavior (select only one per option)
    if (isRequired && optionId != null) {
      // If this option already has a selected choice, deselect it
      if (selectedOptions[optionId] != null && selectedOptions[optionId] != choiceKey) {
        String? previousChoiceKey = selectedOptions[optionId];
        if (previousChoiceKey != null) {
          selectedChoices[previousChoiceKey] = false;

          // Remove from selected options list
          removeSelectedOptionChoice(optionId: optionId, choiceKey: previousChoiceKey);
        }
      }

      // Toggle current choice
      bool currentState = selectedChoices[choiceKey] ?? false;
      if (currentState) {
        // Deselect
        selectedChoices[choiceKey] = false;
        selectedOptions[optionId] = null;
        removeSelectedOptionChoice(optionId: optionId, choiceKey: choiceKey);
      } else {
        // Select
        selectedChoices[choiceKey] = true;
        selectedOptions[optionId] = choiceKey;
        updateSelectedOptionChoice(
          optionId: optionId,
          optionName: optionName,
          choiceKey: choiceKey,
          choiceName: choiceName,
          choicePrice: choicePrice?.toString(),
        );
      }
    } else {
      // For checkbox behavior (multiple selection allowed)
      bool currentState = selectedChoices[choiceKey] ?? false;
      selectedChoices[choiceKey] = !currentState;

      if (!currentState) {
        // Add to selected options
        updateSelectedOptionChoice(
          optionId: optionId,
          optionName: optionName,
          choiceKey: choiceKey, // Add this
          choiceName: choiceName,
          choicePrice: choicePrice?.toString(), // Ensure it's string
        );
      } else {
        // Remove from selected options
        removeSelectedOptionChoice(
          optionId: optionId,
          choiceKey: choiceKey,
        );
      }
    }

    update();
  }


  // Method to update selected option choice
  void updateSelectedOptionChoice({
    String? optionId,
    String? optionName,
    String? choiceName,
    String? choicePrice,
    String? choiceKey
  }) {
    if (optionId == null || choiceKey == null) return;

    // Find if this option is already selected
    int existingIndex = selectedOptionIds.indexWhere((id) => id == optionId);

    if (existingIndex != -1) {
      // Update existing selection
      selectedOptionNames[existingIndex] = optionName ?? '';
      selectedChoiceNames[existingIndex] = choiceName ?? '';
      selectedChoicePrices[existingIndex] = choicePrice ?? '0';

      // Update the arrays for API
      if (existingIndex < extrasTitlesIdsId.length) {
        extrasTitlesIdsId[existingIndex] = optionId;
      }
      if (existingIndex < extrasItemIdsId.length) {
        extrasItemIdsId[existingIndex] = choiceKey;
      }
      if (existingIndex < extrasItemIdsName.length) {
        extrasItemIdsName[existingIndex] = choiceName ?? '';
      }
      if (existingIndex < extrasItemIdsPrice.length) {
        extrasItemIdsPrice[existingIndex] = choicePrice ?? '0';
      }
    } else {
      // Add new selection
      selectedOptionIds.add(optionId);
      selectedOptionNames.add(optionName ?? '');
      selectedChoiceNames.add(choiceName ?? '');
      selectedChoicePrices.add(choicePrice ?? '0');

      // Add to arrays for API
      extrasTitlesIdsId.add(optionId);
      extrasItemIdsId.add(choiceKey);
      extrasItemIdsName.add(choiceName ?? '');
      extrasItemIdsPrice.add(choicePrice ?? '0');

      print("Added to arrays:");
      print("extrasTitlesIdsId: $extrasTitlesIdsId");
      print("extrasItemIdsId: $extrasItemIdsId");
      print("extrasItemIdsName: $extrasItemIdsName");
      print("extrasItemIdsPrice: $extrasItemIdsPrice");
    }

    update();
  }


  // Method to remove selected option choice
  void removeSelectedOptionChoice({
    String? optionId,
    String? choiceKey,
  }) {
    if (optionId == null) return;

    int indexToRemove = selectedOptionIds.indexWhere((id) => id == optionId);
    if (indexToRemove != -1) {
      selectedOptionIds.removeAt(indexToRemove);
      selectedOptionNames.removeAt(indexToRemove);
      selectedChoiceNames.removeAt(indexToRemove);
      selectedChoicePrices.removeAt(indexToRemove);

      // Also remove from API arrays
      if (indexToRemove < extrasTitlesIdsId.length) {
        extrasTitlesIdsId.removeAt(indexToRemove);
      }
      if (indexToRemove < extrasItemIdsId.length) {
        extrasItemIdsId.removeAt(indexToRemove);
      }
      if (indexToRemove < extrasItemIdsName.length) {
        extrasItemIdsName.removeAt(indexToRemove);
      }
      if (indexToRemove < extrasItemIdsPrice.length) {
        extrasItemIdsPrice.removeAt(indexToRemove);
      }

      print("Removed from arrays:");
      print("extrasTitlesIdsId: $extrasTitlesIdsId");
      print("extrasItemIdsId: $extrasItemIdsId");
    }

    update();
  }

  // Method to clear all selections
  void clearOptionSelections() {
    selectedChoices.clear();
    selectedOptions.clear();
    selectedOptionIds.clear();
    selectedOptionNames.clear();
    selectedChoiceNames.clear();
    selectedChoicePrices.clear();

    // Also clear API arrays
    extrasTitlesIdsId.clear();
    extrasItemIdsId.clear();
    extrasItemIdsName.clear();
    extrasItemIdsPrice.clear();

    update();
  }

  // Method to get all selected options as formatted string
  String getSelectedOptionsSummary() {
    String summary = '';
    for (int i = 0; i < selectedOptionIds.length; i++) {
      summary += '${selectedOptionNames[i]}: ${selectedChoiceNames[i]} (\$${selectedChoicePrices[i]})\n';
    }
    return summary;
  }

  // Method to get total extra price from selected options
  double getTotalExtraPrice() {
    double total = 0;
    for (String price in selectedChoicePrices) {
      total += double.tryParse(price) ?? 0;
    }
    return total;
  }

  specific_Product_Api({
    required String productId,
    required String categoryId,
  }) async {
    goToCart.value = false;
    selectedAddOn.clear();
    extrasTitlesIdsId.clear();
    extrasItemIdsId.clear();
    extrasItemIdsName.clear();
    extrasItemIdsPrice.clear();
    // Clear options selections
    clearOptionSelections();

    selectedImageUrl.value = "";
    cartCount.value = 1;
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "product_id": productId,
      "category_id": categoryId,
    };
    api.specific_Product_Api(data).then((value) {
      if(value.status == true){
        isSelected = (-1).obs;
        productdata_Set(value);
        setRxRequestStatus(Status.COMPLETED);
      }else if(value.status == false){
        Get.back();
        Utils.showToast("Product is not active.");
        setRxRequestStatus(Status.ERROR);
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  refreshSpecificProductApi({
    required String productId,
    required String categoryId,
  }) async {
    Map data = {
      "product_id": productId,
      "category_id": categoryId,
    };
    api.specific_Product_Api(data).then((value) {
      if(value.status == true){
        productdata_Set(value);
        setRxRequestStatus(Status.COMPLETED);
      }else if(value.status == false){
        Get.back();
        Utils.showToast("Product is not active.");
        setRxRequestStatus(Status.COMPLETED);
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print(stackError);
      print('errrrrrrrrrrrr');
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  String formatDate(String? dateString) {
    if (dateString == null) {
      return "";
    }
    try {
      DateTime date = DateTime.parse(dateString);
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(date);
      print("Formatted Date: $formattedDate");
      return formattedDate;
    } catch (e) {
      print("Error formatting date: $e");
      return "";
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}