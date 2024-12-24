import 'package:flutter/services.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Add_address/add_address_controller.dart';
import 'package:woye_user/shared/widgets/address_fromgoogle/modal/GoogleLocationModel.dart';
import 'package:woye_user/shared/widgets/address_fromgoogle/AddressFromGoogleTextField.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  final controller = Get.put(AddAddressController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Add New Address",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24.h),
        child: Column(
          children: [
            hBox(20),
            fullName(),
            hBox(15),
            phoneNumber(),
            hBox(15),
            houseNo(),
            hBox(15),
            AddressFromGoogleAPI(
              controller: controller.locationController,
              onChanged: (value) {
                controller.isValidAddress = false;
                // addressSetController.house_noController.value.clear();
              },
              suggestionsCallback: (query) async {
                return await controller.searchAutocomplete(query);
              },
              itemBuilder: (context, Predictions suggestion) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text(
                        suggestion.description ?? "",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                  ],
                );
              },
              onSelected: (Predictions selectedAddress) {
                controller.locationController.text =
                    selectedAddress.description ?? "";
                controller.getLatLang(controller.locationController.text);
                controller.selectedLocation =
                    controller.locationController.text;
                controller.isValidAddress = true;
                controller.searchPlace.clear();
                print("SelectedLocation ${controller.selectedLocation}");
              },
              hintText: 'Address',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'enter your address';
                }
                if (!controller.isValidAddress) {
                  return 'Select an valid address.';
                }
                return null;
              },
            ),
            hBox(15),
            toggleButtons(),
            hBox(20),
            defaultSet(),
            hBox(30),
            saveButton(),
            hBox(50)
          ],
        ),
      ),
    );
  }

  Widget fullName() {
    return const CustomTextFormField(
      hintText: "Full Name",
    );
  }

  Widget phoneNumber() {
    return CustomTextFormField(
      controller: controller.mobNoCon!.value,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      prefixConstraints: const BoxConstraints(maxWidth: 100),
      prefix: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CountryCodePicker(
              showFlag: false,
              padding: REdgeInsets.symmetric(horizontal: 0, vertical: 9),
              onChanged: (CountryCode countryCode) {
                controller.updateCountryCode(countryCode);
                controller.showError.value = false;
                int? countrylength =
                    controller.countryPhoneDigits[countryCode.code.toString()];
                controller.checkCountryLength = countrylength!;
              },
              initialSelection: "IN"),
          const Icon(Icons.keyboard_arrow_down_rounded),
          wBox(5),
        ],
      ),
      hintText: "Phone Number",
      textInputType: TextInputType.phone,
    );
  }

  Widget houseNo() {
    return const CustomTextFormField(
      hintText: "House No./Flat No./ Apartment No.",
    );
  }

  Widget address() {
    return const CustomTextFormField(
      hintText: "Address",
    );
  }

  Widget toggleButtons() {
    return Row(children: [
      CustomToogleButton(
          title: "Home",
          value: 0.obs,
          groupValue: controller.radioValue,
          icon: "assets/svg/home-sharp.svg",
          selectedIcon: "assets/svg/home-primary.svg",
          onChanged: (v) {
            controller.radioValue.value = v!;
          }),
      wBox(10),
      CustomToogleButton(
          title: "Office",
          value: 1.obs,
          groupValue: controller.radioValue,
          icon: "assets/svg/office.svg",
          selectedIcon: "assets/svg/office-primary.svg",
          onChanged: (v) {
            controller.radioValue.value = v!;
          }),
      wBox(10),
      CustomToogleButton(
          title: "Other",
          value: 2.obs,
          groupValue: controller.radioValue,
          icon: "assets/svg/location-pin.svg",
          selectedIcon: "assets/svg/location-pin-primary.svg",
          onChanged: (v) {
            controller.radioValue.value = v!;
          }),
    ]);
  }

  Widget defaultSet() {
    RxBool isSelected = false.obs;
    return Row(
      children: [
        Obx(
          () => Transform.scale(
            scale: 1.2,
            child: SizedBox(
              height: 20.h,
              child: Checkbox(
                  activeColor: AppColors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  value: isSelected.value,
                  side: BorderSide(
                    color: AppColors.black,
                  ),
                  onChanged: (value) {
                    isSelected.value = !isSelected.value;
                  }),
            ),
          ),
        ),
        Text(
          "Set default",
          style: AppFontStyle.text_16_400(AppColors.darkText),
        ),
      ],
    );
  }

  Widget saveButton() {
    return CustomElevatedButton(
      onPressed: () {
        Get.back();
      },
      text: "Save",
    );
  }
}
