import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/services.dart';

import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/Sub_screens/Delivery_address/Sub_screens/Edit_address/edit_address_controller.dart';
import 'package:woye_user/shared/widgets/address_fromgoogle/AddressFromGoogleTextField.dart';
import 'package:woye_user/shared/widgets/address_fromgoogle/modal/GoogleLocationModel.dart';

class EditAddressScreen extends StatelessWidget {
  EditAddressScreen({super.key});

  final EditAdressController controller = Get.put(EditAdressController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isLeading: true,
        title: Text(
          "Edit Address",
          style: AppFontStyle.text_22_600(AppColors.darkText),
        ),
      ),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // hBox(20),
              // fullName(),
              // hBox(15),
              // phoneNumber(),
              // hBox(15),
              // houseNo(),
              // hBox(15),
              // countryStateCityPicker(),
              // hBox(15),
              // address(),
              // hBox(15),
              // zipPostalCode(),
              // hBox(15),
              // setterButtons(),
              // hBox(20),
              // defaultSet(),
              // hBox(30),
              // saveButton(),
              // hBox(50)
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
                  print("SelectedLocation 1${controller.isValidAddress.value}");
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

  // Widget phoneNumber() {
  //   return CustomTextFormField(
  //     controller: controller.mobNoController!.value,
  //     inputFormatters: [
  //       FilteringTextInputFormatter.digitsOnly,
  //     ],
  //     prefix: CountryCodePicker(
  //         padding: const EdgeInsets.only(left: 10),
  //         onChanged: (CountryCode countryCode) {
  //           print("country code===========> ${countryCode.code}");
  //           controller.updateCountryCode(countryCode);
  //           controller.showError.value = false;
  //           int? countrylength =
  //               controller.countryPhoneDigits[countryCode.code.toString()];
  //           controller.chackCountryLength = countrylength!;
  //         },
  //         initialSelection: "IN"),
  //     hintText: "Phone Number",
  //     textInputType: TextInputType.phone,
  //     validator: (value) {
  //       if (value == null || value.isEmpty) {
  //         return 'Please enter your phone number';
  //       }
  //       if (value.length != controller.chackCountryLength) {
  //         return 'Please enter a valid phone number (${controller.chackCountryLength} digits required)';
  //       }
  //       return null;
  //     },
  //   );
  // }
  Widget phoneNumber() {
    return  CustomTextFormField(
      controller: controller.mobNoController.value,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      prefix: CountryCodePicker(
        padding: const EdgeInsets.only(left: 10),
        onChanged: (CountryCode countryCode) {
          print("country code===========> ${countryCode.code}");
          controller.updateCountryCode(countryCode);
          controller.showError.value = false;
          int? countrylength = controller
              .countryPhoneDigits[countryCode.code.toString()];
          controller.chackCountryLength = countrylength!;
        },
        initialSelection:
        controller.selectedCountryCode.value.dialCode,
      ),
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
            controller.editAddressApi();
            print("object");
          }
        },
        isLoading: controller.rxRequestStatus.value == Status.LOADING,
        text: "Save",
      ),
    );
  }

// Widget fullName() {
//   return const CustomTextFormField(
//     hintText: "Full Name",
//   );
// }
//
// Widget phoneNumber() {
//   return CustomTextFormField(
//     controller: controller.mobNoCon!.value,
//     inputFormatters: [
//       FilteringTextInputFormatter.digitsOnly,
//     ],
//     prefixConstraints: const BoxConstraints(maxWidth: 100),
//     prefix: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CountryCodePicker(
//             showFlag: false,
//             padding: REdgeInsets.symmetric(horizontal: 0, vertical: 9),
//             onChanged: (CountryCode countryCode) {
//               controller.updateCountryCode(countryCode);
//               controller.showError.value = false;
//               int? countrylength =
//                   controller.countryPhoneDigits[countryCode.code.toString()];
//               controller.checkCountryLength = countrylength!;
//             },
//             initialSelection: "IN"),
//         const Icon(Icons.keyboard_arrow_down_rounded),
//         wBox(5),
//       ],
//     ),
//     hintText: "Phone Number",
//     textInputType: TextInputType.phone,
//   );
// }
//
// Widget houseNo() {
//   return const CustomTextFormField(
//     hintText: "House No./Flat No./ Apartment No.",
//   );
// }
//
// Widget address() {
//   return const CustomTextFormField(
//     hintText: "Address",
//   );
// }
//
// Widget countryStateCityPicker() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 20),
//     child: Column(
//       children: [
//         Transform.scale(
//             scale: 1.28,
//             child: GetBuilder(
//                 init: controller,
//                 builder: (context) {
//                   return CSCPicker(
//                     dropdownHeadingStyle:
//                         AppFontStyle.text_12_400(AppColors.darkText),
//                     selectedItemStyle:
//                         AppFontStyle.text_12_400(AppColors.darkText),
//                     layout: Layout.vertical,
//                     disabledDropdownDecoration: BoxDecoration(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(
//                           12.r,
//                         ),
//                         border: Border.all(color: AppColors.textFieldBorder)),
//                     dropdownDecoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                           12.r,
//                         ),
//                         border: Border.all(color: AppColors.textFieldBorder)),
//                     onCountryChanged: (value) {
//                       controller.countryValue = value;
//                     },
//                     onStateChanged: (value) {
//                       controller.stateValue = value ?? "";
//                     },
//                     onCityChanged: (value) {
//                       controller.cityValue = value ?? "";
//                     },
//                   );
//                 }))
//       ],
//     ),
//   );
// }
//
// Widget zipPostalCode() {
//   return const CustomTextFormField(
//     hintText: "Zip/Postal Code",
//   );
// }
//
// Widget setterButtons() {
//   return Row(children: [
//     CustomToogleButton(
//         title: "Home",
//         value: 0.obs,
//         groupValue: controller.radioValue,
//         icon: "assets/svg/home-sharp.svg",
//         selectedIcon: "assets/svg/home-primary.svg",
//         onChanged: (v) {
//           controller.radioValue.value = v!;
//         }),
//     wBox(10),
//     CustomToogleButton(
//         title: "Office",
//         value: 1.obs,
//         groupValue: controller.radioValue,
//         icon: "assets/svg/office.svg",
//         selectedIcon: "assets/svg/office-primary.svg",
//         onChanged: (v) {
//           controller.radioValue.value = v!;
//         }),
//     wBox(10),
//     CustomToogleButton(
//         title: "Other",
//         value: 2.obs,
//         groupValue: controller.radioValue,
//         icon: "assets/svg/location-pin.svg",
//         selectedIcon: "assets/svg/location-pin-primary.svg",
//         onChanged: (v) {
//           controller.radioValue.value = v!;
//         }),
//   ]);
// }
//
// Widget defaultSet() {
//   RxBool isSelected = false.obs;
//   return Row(
//     children: [
//       Obx(
//         () => Transform.scale(
//           scale: 1.2,
//           child: SizedBox(
//             height: 20.h,
//             child: Checkbox(
//                 activeColor: AppColors.black,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5)),
//                 value: isSelected.value,
//                 side: BorderSide(
//                   color: AppColors.black,
//                 ),
//                 onChanged: (value) {
//                   isSelected.value = !isSelected.value;
//                 }),
//           ),
//         ),
//       ),
//       Text(
//         "Set default",
//         style: AppFontStyle.text_16_400(AppColors.darkText),
//       ),
//     ],
//   );
// }
//
// Widget saveButton() {
//   return CustomElevatedButton(
//     onPressed: () {
//       Get.back();
//     },
//     text: "Save",
//   );
// }
}
