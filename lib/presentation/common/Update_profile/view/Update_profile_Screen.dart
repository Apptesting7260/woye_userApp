import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Update_profile/controller/Update_profile_controller.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';

class SignUpFormScreen extends StatelessWidget {
  SignUpFormScreen({super.key});

  final SignUpForm_editProfileController controller =
      Get.put(SignUpForm_editProfileController());

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    String? typeFrom = arguments?['typefrom'];
    return Scaffold(
        appBar: CustomAppBar(isLeading: typeFrom == "back" ? false : true),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: circularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet') {
                return InternetExceptionWidget(
                  onPress: () {
                    controller.getprofileApi();
                  },
                );
              } else {
                return GeneralExceptionWidget(
                  onPress: () {
                    controller.getprofileApi();
                  },
                );
              }
            case Status.COMPLETED:
              return RefreshIndicator(
                onRefresh: () async {
                  controller.getprofileApi();
                },
                child: SingleChildScrollView(
                  padding: REdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header(typeFrom ?? ""),
                      hBox(30),
                      //
                      form(controller, context),
                      hBox(20),
                      //
                      continueButton(typeFrom ?? ""),
                      hBox(40),
                    ],
                  ),
                ),
              );
          }
        }));
  }

  Widget header(typeFrom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          typeFrom == "back" ? "Update your profile" : "Fill your profile",
          style: AppFontStyle.text_36_600(AppColors.darkText),
        ),
        hBox(15),
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightText),
        ),
      ],
    );
  }

  Widget form(SignUpForm_editProfileController signUpFormController,
      BuildContext context) {
    return Form(
        key: signUpFormController.formSignUpKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: imagePicker(context, signUpFormController),
            ),
            hBox(30),
            CustomTextFormField(
              alignment: Alignment.center,
              controller: signUpFormController.fisrtNameController,
              prefix: SvgPicture.asset(
                ImageConstants.profileIcon,
              ),
              prefixConstraints:
                  BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
              hintText: "First name",
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              validator: signUpFormController.validateFirstName,
            ),
            hBox(15),
            CustomTextFormField(
              controller: signUpFormController.mobileController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              prefix: CountryCodePicker(
                padding: const EdgeInsets.only(left: 10),
                onChanged: (CountryCode countryCode) {
                  print("country code===========> ${countryCode.code}");
                  signUpFormController.updateCountryCode(countryCode);
                  signUpFormController.showError.value = false;
                  int? countrylength = signUpFormController
                      .countryPhoneDigits[countryCode.code.toString()];
                  signUpFormController.chackCountryLength = countrylength!;
                },
                // initialSelection: "IN"
                initialSelection:
                    signUpFormController.selectedCountryCode.value.dialCode,
              ),
              hintText: "Phone Number",
              textInputType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number';
                }
                if (value.length != signUpFormController.chackCountryLength) {
                  return 'Please enter a valid phone number (${signUpFormController.chackCountryLength} digits required)';
                }
                return null;
              },
            ),
            hBox(15),
            GestureDetector(
              onTap: () => signUpFormController.selectDate(context),
              child: Obx(() {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: AppColors.textFieldBorder),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        ImageConstants.calendar,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        signUpFormController.formattedCurrentDate.value.isEmpty
                            ? "Date of Birth"
                            : signUpFormController.formattedCurrentDate.value,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              }),
            ),
            hBox(15),
            CustomTextFormField(
              controller: signUpFormController.emailController,
              prefix: SvgPicture.asset(
                ImageConstants.email,
              ),
              prefixConstraints:
                  BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
              hintText: "Email Address",
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              validator: signUpFormController.validateEmail,
            ),
            hBox(15),
            DropdownButtonFormField(
              hint: Text(
                signUpFormController.genderController.text.isEmpty
                    ? "Gender"
                    : signUpFormController.genderController.text,
                style: AppFontStyle.text_16_400(AppColors.darkText),
              ),
              style: AppFontStyle.text_16_400(AppColors.darkText),
              icon: SvgPicture.asset(ImageConstants.arrowDown),
              decoration: InputDecoration(
                  contentPadding:
                      REdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textFieldBorder),
                      borderRadius: BorderRadius.circular(15.r)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textFieldBorder),
                      borderRadius: BorderRadius.circular(15.r)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.textFieldBorder),
                      borderRadius: BorderRadius.circular(15.r))),
              items: ["Male", "Female", "Other"]
                  .map((element) => DropdownMenuItem(
                      value: element.toString(),
                      child: Text(element.toString())))
                  .toList(),
              onChanged: (value) {
                signUpFormController.genderController.text = value.toString();
                // print("${signUpFormController.genderController.text}");
              },
            )
          ],
        ));
  }

  Widget imagePicker(BuildContext context,
      SignUpForm_editProfileController signUpFormController) {
    return GestureDetector(
      onTap: () {
        bottomSheet(context);
      },
      child: SizedBox(
        height: 140.h,
        child: Stack(
          children: [
            signUpFormController.profileImageFromAPI.value.isNotEmpty
                ? Container(
                    width: 120.h,
                    height: 120.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.r),
                      border: Border.all(color: Colors.transparent),
                    ),
                    child: signUpFormController.profileImageGetUrl.value.isEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100.r),
                            child: CircleAvatar(
                              backgroundColor:
                                  AppColors.greyBackground.withOpacity(0.5),
                              child: CachedNetworkImage(
                                imageUrl: signUpFormController
                                    .profileImageFromAPI.value,
                                placeholder: (context, url) =>
                                    circularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.person,
                                  size: 60.h,
                                  color: AppColors.lightText.withOpacity(0.5),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            width: 120.h,
                            height: 120.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.r),
                              // Round container
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              // Round the image inside the container
                              child: Image.file(
                                signUpFormController.image.value,
                                // The image file you want to display
                                fit: BoxFit
                                    .cover, // Ensures the image fills the circular container
                              ),
                            ),
                          ))
                : Container(
                    width: 120.h,
                    height: 120.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        // shape: BoxShape.circle,
                        border: Border.all(color: Colors.transparent)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.r),
                        child: signUpFormController
                                .profileImageGetUrl.value.isEmpty
                            ? CircleAvatar(
                                backgroundColor:
                                    AppColors.greyBackground.withOpacity(0.5),
                                child: Icon(
                                  Icons.person,
                                  size: 60.h,
                                  color: AppColors.lightText.withOpacity(0.5),
                                ))
                            : Container(
                                width: 120.h,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100.r),
                                  // Round container
                                  border: Border.all(color: Colors.transparent),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  // Round the image inside the container
                                  child: Image.file(
                                    signUpFormController.image.value,
                                    // The image file you want to display
                                    fit: BoxFit
                                        .cover, // Ensures the image fills the circular container
                                  ),
                                ),
                              ))),
            Positioned(
              bottom: 28.h,
              right: 4.w,
              child: Container(
                width: 30.h,
                height: 30.h,
                decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(50.r),
                    border: Border.all(color: AppColors.primary)),
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                  size: 12.h,
                ),
              ),
            ),
            // if (signUpFormController.image == null)
            //   Positioned(
            //       bottom: 0,
            //       child: Text(
            //         "      Please choose an image",
            //         style: TextStyle(color: Colors.red, fontSize: 8.sp),
            //       ))
          ],
        ),
      ),
    );
  }

  void checkValid() {
    controller.isValid =
   controller.formSignUpKey.currentState!.validate();
    print("Path ---> ${controller.profileImageGetUrl.value}");

    if (controller.isValid) {
      if (controller.formattedCurrentDate.value.isEmpty) {
        Utils.showToast("Please Select Date of Birth");
       controller.isValid = false;
      } else if (controller.genderController.text.isEmpty) {
        Utils.showToast("Please choose your gender");
        controller.isValid = false;
      }
      // else if (controller.profileImageFromAPI.value.isEmpty &&
      //     controller.profileImageGetUrl.value.isEmpty) {
      //   Utils.showToast("Please choose your profile image");
      //   SignUpFormScreen.controller.isValid = false;
      // }
    }
  }

  Widget continueButton(String type) {
    return CustomElevatedButton(
        isLoading: controller.rxRequestStatus2.value == Status.LOADING,
        text: type == "back" ? "Update" : "Continue",
        onPressed: () {
          checkValid();

          if (controller.isValid) {
            controller.profileupdateApi(type);
          }
        });
  }

  Future bottomSheet(BuildContext context) {
    final SignUpForm_editProfileController controller =
        Get.find<SignUpForm_editProfileController>();
    return showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: OutlineInputBorder(
          borderSide: const BorderSide(width: 0, color: Colors.transparent),
          gapPadding: 0,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
        ),
        showDragHandle: true,
        constraints: BoxConstraints(maxHeight: 218.h),
        elevation: 12.w,
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 5,
                    blurStyle: BlurStyle.outer)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r)),
              color: Colors.white,
              // gradient: LinearGradient(
              //     colors: [Colors.white, AppColors.primary.withOpacity(0.05)],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: REdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text("Pick an Image",
                      style: GoogleFonts.poppins(
                        textStyle:
                            AppFontStyle.text_18_400(AppColors.mediumText),
                      )),
                  hBox(18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.pickImage(ImageSource.camera);
                          // _pickImageFromCamera();
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: REdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.outer)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.r)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_camera_outlined,
                                color: AppColors.lightText,
                                size: 24.h,
                              ),
                              Text(
                                "Camera",
                                style: AppFontStyle.text_16_400(
                                    AppColors.lightText),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.pickImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: REdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.primary.withOpacity(0.2),
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.outer)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.r)),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo_library_outlined,
                                color: AppColors.lightText,
                                size: 24.h,
                              ),
                              Text(
                                "Gallery",
                                style: AppFontStyle.text_16_400(
                                    AppColors.lightText),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
