import 'package:flutter/services.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Add_address/add_address_controller.dart';
import 'package:woye_user/shared/widgets/address_fromgoogle/modal/GoogleLocationModel.dart';
import 'package:woye_user/shared/widgets/address_fromgoogle/AddressFromGoogleTextField.dart';

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({super.key});

  final controller = Get.put(AddAddressController(), permanent: true);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.loadLocationData();
    return PopScope(
      canPop: controller.location.value == "" ? false : true,
      child: Scaffold(
        appBar: CustomAppBar(
          isLeading: controller.location.value == "" ? false : true,
          title: Text(
            "Add New Address",
            style: AppFontStyle.text_22_600(AppColors.darkText),
          ),
        ),
        body: SingleChildScrollView(
          padding: REdgeInsets.symmetric(horizontal: 24.h),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                hBox(20.h),
                fullName(),
                hBox(15.h),
                phoneNumber(),
                hBox(15.h),
                houseNo(),
                hBox(15.h),
                AddressFromGoogleAPI(
                  controller: controller.locationController,
                  onChanged: (value) {
                    controller.isValidAddress.value = false;
                    print(
                        "SelectedLocation 1${controller.isValidAddress.value}");
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
                    controller.isValidAddress.value = true;
                    controller.searchPlace.clear();
                    print("SelectedLocation ${controller.selectedLocation}");
                    print("SelectedLocation 2${controller.isValidAddress}");
                  },
                  hintText: 'Address',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your address';
                    }
                    if (!controller.isValidAddress.value) {
                      return 'Select an valid address.';
                    }
                    return null;
                  },
                ),
                hBox(15.h),
                deliveryInstruction(),
                hBox(15.h),
                toggleButtons(),
                hBox(20.h),
                defaultSet(),
                hBox(30.h),
                saveButton(),
                hBox(50.h)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fullName() {
    return CustomTextFormField(
      controller: controller.nameController.value,
      hintText: "Full Name",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        return null;
      },
    );
  }

  Widget phoneNumber() {
    return CustomTextFormField(
      controller: controller.mobNoController!.value,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      prefix: CountryCodePicker(
          padding: const EdgeInsets.only(left: 10),
          onChanged: (CountryCode countryCode) {
            print("country code===========> ${countryCode.code}");
            controller.updateCountryCode(countryCode);
            controller.showError.value = false;
            int? countrylength =
                controller.countryPhoneDigits[countryCode.code.toString()];
            controller.chackCountryLength = countrylength!;
          },
          initialSelection: "IN"),
      hintText: "Phone Number",
      textInputType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        if (value.length != controller.chackCountryLength) {
          return 'Please enter a valid phone number (${controller.chackCountryLength} digits required)';
        }
        return null;
      },
    );
  }

  Widget houseNo() {
    return CustomTextFormField(
      controller: controller.houseNoController.value,
      hintText: "House No./Flat No./ Apartment No.",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your house number';
        }
        return null;
      },
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
            controller.addressType.value = "Home";
          }),
      wBox(10.h),
      CustomToogleButton(
          title: "Office",
          value: 1.obs,
          groupValue: controller.radioValue,
          icon: "assets/svg/office.svg",
          selectedIcon: "assets/svg/office-primary.svg",
          onChanged: (v) {
            controller.radioValue.value = v!;
            controller.addressType.value = "Office";
          }),
      wBox(10.h),
      CustomToogleButton(
          title: "Other",
          value: 2.obs,
          groupValue: controller.radioValue,
          icon: "assets/svg/location-pin.svg",
          selectedIcon: "assets/svg/location-pin-primary.svg",
          onChanged: (v) {
            controller.radioValue.value = v!;
            controller.addressType.value = "Other";
          }),
    ]);
  }

  Widget defaultSet() {
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
                  value: controller.defaultSet.value,
                  side: BorderSide(
                    color: AppColors.black,
                  ),
                  onChanged: (value) {
                    controller.defaultSet.value = !controller.defaultSet.value;
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

  Widget deliveryInstruction() {
    return CustomTextFormField(
      controller: controller.deliveryInstructionController.value,
      hintText: "Delivery Instruction (Optional)",
    );
  }

  Widget saveButton() {
    return Obx(
      () => CustomElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            controller.addAddressApi();
          }
        },
        isLoading: controller.rxRequestStatus.value == Status.LOADING,
        text: "Save",
      ),
    );
  }
}
