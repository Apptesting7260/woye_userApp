import 'package:woye_user/Core/Utils/app_export.dart';
import 'package:woye_user/presentation/Restaurants/Pages/Restaurant_home/Sub_screens/Product_details/modal/specific_product_modal.dart';
import 'package:intl/intl.dart';

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

  void toggleChoiceSelection({
    String? optionId,
    String? optionName,
    required String uniqueKey, // For internal tracking 'optionId_choiceIndex'
    int? choiceIndex, // To identify which choice in the option
    String? choiceName,
    String? choicePrice,
    bool isRequired = false,
  }) {
    // For radio button behavior (select only one per option)
    if (isRequired && optionId != null) {
      // If this option already has a selected choice, deselect it
      if (selectedOptions[optionId] != null && selectedOptions[optionId] != uniqueKey) {
        String? previousUniqueKey = selectedOptions[optionId];
        if (previousUniqueKey != null) {
          selectedChoices[previousUniqueKey] = false;

          // Remove from selected options list
          removeSelectedOptionChoice(optionId: optionId, uniqueKey: previousUniqueKey);
        }
      }

      // Toggle current choice
      bool currentState = selectedChoices[uniqueKey] ?? false;
      if (currentState) {
        // Deselect
        selectedChoices[uniqueKey] = false;
        selectedOptions[optionId] = null;
        removeSelectedOptionChoice(optionId: optionId, uniqueKey: uniqueKey);
      } else {
        // Select
        selectedChoices[uniqueKey] = true;
        selectedOptions[optionId] = uniqueKey;
        updateSelectedOptionChoice(
          optionId: optionId,
          optionName: optionName,
          uniqueKey: uniqueKey,
          choiceIndex: choiceIndex,
          choiceName: choiceName,
          choicePrice: choicePrice,
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
    String? uniqueKey,
    int? choiceIndex,
  }) {
    if (optionId == null || uniqueKey == null) return;

    // Find if this option is already selected
    int existingIndex = selectedOptionIds.indexWhere((id) => id == optionId);

    if (existingIndex != -1) {
      // Update existing selection (replace with new choice for same option)
      selectedOptionNames[existingIndex] = optionName ?? '';
      selectedChoiceNames[existingIndex] = choiceName ?? '';
      selectedChoicePrices[existingIndex] = choicePrice ?? '0';

      // Update the arrays for API
      // IMPORTANT: Send only optionId (like "1") to both arrays
      if (existingIndex < extrasTitlesIdsId.length) {
        extrasTitlesIdsId[existingIndex] = optionId; // Just optionId like "1"
      }
      if (existingIndex < extrasItemIdsId.length) {
        // Send only optionId, no choice-specific ID
        extrasItemIdsId[existingIndex] = optionId; // Same optionId like "1"
      }
      if (existingIndex < extrasItemIdsName.length) {
        extrasItemIdsName[existingIndex] = choiceName ?? '';
      }
      if (existingIndex < extrasItemIdsPrice.length) {
        extrasItemIdsPrice[existingIndex] = choicePrice ?? '0';
      }

      print("=== Updated Selection ===");
      print("Option ID: $optionId (Updated choice to: $choiceName)");
    } else {
      // Add new selection
      selectedOptionIds.add(optionId);
      selectedOptionNames.add(optionName ?? '');
      selectedChoiceNames.add(choiceName ?? '');
      selectedChoicePrices.add(choicePrice ?? '0');

      // Add to arrays for API
      // Send only optionId (no choice index or name in ID fields)
      extrasTitlesIdsId.add(optionId); // Just "1" for Size option
      extrasItemIdsId.add(optionId);   // Same "1" for Size option
      extrasItemIdsName.add(choiceName ?? '');
      extrasItemIdsPrice.add(choicePrice ?? '0');

      print("=== Added Selection ===");
      print("Option ID: $optionId");
      print("Option Name: $optionName");
      print("Choice Name: $choiceName");
      print("Choice Price: $choicePrice");
      print("extrasTitlesIdsId: $extrasTitlesIdsId"); // ["1", "2"]
      print("extrasItemIdsId: $extrasItemIdsId");     // ["1", "2"] - same optionId
      print("extrasItemIdsName: $extrasItemIdsName"); // ["large", "spicy"]
      print("extrasItemIdsPrice: $extrasItemIdsPrice"); // ["100", "20"]
    }

    update();
  }

  // Method to remove selected option choice
  void removeSelectedOptionChoice({
    String? optionId,
    String? uniqueKey,
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

      print("=== Removed Selection ===");
      print("Option ID: $optionId removed");
      print("extrasTitlesIdsId: $extrasTitlesIdsId");
      print("extrasItemIdsId: $extrasItemIdsId");
    }

    // Remove from internal tracking maps
    if (uniqueKey != null) {
      selectedChoices.remove(uniqueKey);
    }
    selectedOptions.remove(optionId);

    update();
  }

  // Method to check if a choice is selected
  bool isChoiceSelected(String uniqueKey) {
    return selectedChoices[uniqueKey] ?? false;
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