import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/services.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Add_address/add_address_controller.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  static final controller = Get.put(AddAddressController(), permanent: true);

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
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            hBox(20),
            fullName(),
            hBox(15),
            phoneNumber(),
            hBox(15),
            houseNo(),
            hBox(15),
            countryStateCityPicker(),
            hBox(15),
            address(),
            hBox(15),
            zipPostalCode(),
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

  Widget countryStateCityPicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
      child: Column(
        children: [
          Transform.scale(
              scale: 1.28,
              child: GetBuilder(
                  init: controller,
                  builder: (context) {
                    return CSCPicker(
                      dropdownHeadingStyle:
                          AppFontStyle.text_12_400(AppColors.darkText),
                      selectedItemStyle:
                          AppFontStyle.text_12_400(AppColors.darkText),
                      layout: Layout.vertical,
                      disabledDropdownDecoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(
                            12.r,
                          ),
                          border: Border.all(color: AppColors.textFieldBorder)),
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            12.r,
                          ),
                          border: Border.all(color: AppColors.textFieldBorder)),
                      onCountryChanged: (value) {
                        controller.countryValue = value;
                      },
                      onStateChanged: (value) {
                        controller.stateValue = value ?? "";
                      },
                      onCityChanged: (value) {
                        controller.cityValue = value ?? "";
                      },
                    );
                  }))
        ],
      ),
    );
  }

  Widget zipPostalCode() {
    return const CustomTextFormField(
      hintText: "Zip/Postal Code",
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
