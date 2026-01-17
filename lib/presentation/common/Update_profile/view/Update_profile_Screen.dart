import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:woye_user/Data/components/GeneralException.dart';
import 'package:woye_user/Data/components/InternetException.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Update_profile/controller/Update_profile_controller.dart';
import 'package:woye_user/presentation/common/email_verify/send_otp/send_otp_email_controller.dart';
import 'package:woye_user/shared/theme/font_family.dart';
import 'package:woye_user/shared/widgets/CircularProgressIndicator.dart';
import 'package:woye_user/shared/widgets/custom_dropdown_api.dart';

class SignUpFormScreen extends StatefulWidget {
  SignUpFormScreen({super.key});

  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  final SignUpForm_editProfileController controller = Get.put(SignUpForm_editProfileController());

  final SendOtpEmailController sendOtpEmailController = Get.put(SendOtpEmailController());

    @override
    void initState() {
    controller.getprofileApi();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    String? typeFrom = arguments?['typefrom'];
    return Scaffold(
        appBar: CustomAppBar(
            isLeading: typeFrom != "back" ? false : true,
          title: typeFrom == "back" ? Text("Edit Profile", style: AppFontStyle.text_22_600(AppColors.darkText,family: AppFontFamily.onestRegular)) : const SizedBox(),
        ),
        body: Obx(() {
          switch (controller.rxRequestStatus.value) {
            case Status.LOADING:
              return Center(child: circularProgressIndicator());
            case Status.ERROR:
              if (controller.error.value == 'No internet' ||controller.error.value == 'InternetExceptionWidget') {
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
              return GestureDetector(
                onTap: (){
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.refreshGetProfileApi();
                  },
                  child: SingleChildScrollView(
                    padding: REdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (typeFrom != "back") ...[
                          header(),
                          hBox(30),
                        ],
                        //
                        form(controller, context),
                        hBox(20),
                        //
                        continueButton(typeFrom ?? ""),
                        hBox(40),
                      ],
                    ),
                  ),
                ),
              );
          }
        }));
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fill your profile",
          maxLines: 2,
          style: AppFontStyle.text_34_600(AppColors.darkText,family: AppFontFamily.onestRegular),
        ),
        hBox(15),
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.lightText,fontFamily: AppFontFamily.onestRegular),
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
              hintText: "First Name",
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              validator: signUpFormController.validateFirstName,
            ),
            hBox(15),
            CustomTextFormField(
              alignment: Alignment.center,
              controller: signUpFormController.lastNameController,
              prefix: SvgPicture.asset(
                ImageConstants.profileIcon,
              ),
              prefixConstraints:
              BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
              hintText: "Last Name",
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              validator: signUpFormController.validateLastName,
            ),
            hBox(15),

            CustomTextFormField(
              controller: signUpFormController.formattedCurrentDateController.value,
              hintText: "Date of birth",
              readOnly: true,
              onTap: () => signUpFormController.selectDate(context),
              prefix: Padding(
                padding: const EdgeInsets.only(left: 13.0,right: 10),
                child: SvgPicture.asset(
                  ImageConstants.calendar,
                ),
              ),
              validator: (value) {
                if(value == null ||  value.isEmpty){
                  return "Please select date of birth";
                }
                return null;
              },
            ),

            hBox(15),
            Opacity(
              opacity: controller.profileData.value.data?.type == "google" ? .8 : 1,
              child: CustomTextFormField(
                controller: signUpFormController.emailController,
                prefix: SvgPicture.asset(
                  ImageConstants.email,
                ),
                readOnly: controller.profileData.value.data?.type == "google"
                    ? true
                    : false,
                prefixConstraints:
                    BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
                hintText: "Email Address",
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus!.unfocus();
                },
                onChanged: (value) {
                  if (controller.profileData.value.data?.email ==
                      signUpFormController.emailController.text.trim()) {
                    controller.emailVerify.value = false;
                  } else {
                    controller.emailVerify.value = true;
                  }
                },
                validator: (value) {

                  if (value!.isEmpty || !isValidEmail(value, isRequired: true) || value == "") {
                    return "Please enter a valid Email";
                  }else  if(controller.profileData.value.data?.emailVerified != "true"){
                    return "Please verify your email";
                  }

                  return null;
                },
                suffix: controller.profileData.value.data?.type == "google"
                    ? SizedBox()
                    :
                // signUpFormController.emailController.text.isEmpty
                //         ? const SizedBox()
                //         :
                (controller.profileData.value.data?.emailVerified =="true" && controller.emailVerify.value == false)
                    ? Icon(
                        Icons.check_circle,
                        color: AppColors.black,
                      )
                    :Obx(() => TextButton(
                    onPressed: (sendOtpEmailController.rxRequestStatus.value == Status.LOADING) ? null
                    :() {
                              FocusManager.instance.primaryFocus?.unfocus();

                              String email = signUpFormController.emailController.text.trim();

                              // Email validation
                              if (email.isEmpty) {
                                controller.formSignUpKey.currentState?.validate();
                                // Utils.showToast("Email field cannot be empty");
                                return;
                              }

                              if (!GetUtils.isEmail(email)) {
                                // Utils.showToast("Enter a valid email address");
                                controller.formSignUpKey.currentState?.validate();
                                return;
                              }

                              // API call if validation passes
                              sendOtpEmailController.sendOtpApi(email: email).then((value) {
                                sendOtpEmailController.startTimer();
                              });
                            },
                    child: (sendOtpEmailController.rxRequestStatus.value == Status.LOADING)
                    ? circularProgressIndicator(size: 18.h)
                    : Text(
                      "Verify",
                      style: AppFontStyle.text_14_400(
                          AppColors.primary,
                      family: AppFontFamily.onestMedium),
                    ),
                  ),
                ),
              ),
            ),
            hBox(15),
            CustomDropDownApi(
              hintText: "Select Gender",
              hintStyle: AppFontStyle.text_16_400(AppColors.lightText,family: AppFontFamily.onestRegular),
              items: genderItems,
              textStyle: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestRegular),
              selectedValue: signUpFormController.genderController.text.isEmpty
                  ? null
                  : signUpFormController.genderController.text,
              onChanged: (value) {
                signUpFormController.genderController.text = value ?? '';
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select gender";
                }
                return null;
              },
              borderRadius: 15,
              isExpanded: true,
            ),
/*
            DropdownButtonFormField(
              hint: Text(
                signUpFormController.genderController.text.isEmpty
                    ? "Gender"
                    : signUpFormController.genderController.text,
                style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestRegular),
              ),
              style: AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestRegular),
              icon: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(ImageConstants.arrowDown,height: 10,width: 10),
              ),
              decoration: InputDecoration(
                  contentPadding:
                      REdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.red),
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onChanged: (value) {
                signUpFormController.genderController.text = value.toString();
                // print("${signUpFormController.genderController.text}");
              },
              validator: (value){

                if(signUpFormController.genderController.text.isEmpty){
                  return "Please select gender";
                }

                return null;
              },
            ),
*/
            hBox(15),
            CustomTextFormField(
              controller: signUpFormController.mobileController,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              // readOnly: controller.profileData.value.data?.type == "google" ? false : true,
              prefix: CountryCodePicker(
                padding: const EdgeInsets.only(left: 10),
                showFlag: false,
                textStyle:AppFontStyle.text_16_400(AppColors.darkText,family: AppFontFamily.onestRegular),
                onChanged: (CountryCode countryCode) {
                  print("country code===========> ${countryCode.code}");
                  signUpFormController.updateCountryCode(countryCode);
                  signUpFormController.showError.value = false;
                  int? countrylength = signUpFormController.countryPhoneDigits[countryCode.code.toString()];
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
          ],
        ));
  }

  Widget imagePicker(BuildContext context, SignUpForm_editProfileController signUpFormController) {
    return GestureDetector(
      onTap: () {
        bottomSheet(context);
      },
      child: Obx(
        ()=> SizedBox(
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
                              child: CachedNetworkImage(
                                imageUrl: signUpFormController
                                    .profileImageFromAPI.value
                                    .toString(),
                                placeholder: (context, url) =>
                                    circularProgressIndicator(),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.person,
                                  size: 40.h,
                                  color: AppColors.lightText.withOpacity(0.5),
                                ),
                                fit: BoxFit.cover,
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
                                child: Image.file(
                                  signUpFormController.image.value,
                                  fit: BoxFit.cover,
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
                                    child: Image.file(
                                      signUpFormController.image.value,
                                      fit: BoxFit.cover,
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
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(50.r),
                      border: Border.all(color: AppColors.black)),
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
      ),
    );
  }

  Widget continueButton(String type) {
    return CustomElevatedButton(
      isLoading: controller.rxRequestStatus2.value == Status.LOADING,
      text: type == "back" ? "Save" : "Continue",
      fontFamily: AppFontFamily.onestMedium,
      onPressed: () {
        // First, validate the form
        if (!controller.formSignUpKey.currentState!.validate()) {
          return;
        }

        final originalEmail = controller.profileData.value.data?.email ?? "";
        final currentEmail = controller.emailController.text.trim();
        final emailWasChanged = originalEmail != currentEmail;

        // Case 1: Email was changed but not verified
        if (emailWasChanged && controller.emailVerify.value) {
          Utils.showToast("Please verify your new email before updating");
          return;
        }

        // Case 2: Original email wasn't verified (and wasn't changed)
        if (!emailWasChanged &&
            controller.profileData.value.data?.emailVerified != "true") {
          Utils.showToast("Please verify your email before updating");
          return;
        }

        // Case 3: All validations passed - proceed with update
        controller.profileupdateApi(type);
      },
    );
  }
  // void checkValid() {
  // Widget continueButton(String type) {
  //   return CustomElevatedButton(
  //       isLoading: controller.rxRequestStatus2.value == Status.LOADING,
  //       text: type == "back" ? "Update" : "Continue",
  //       fontFamily: AppFontFamily.onestMedium,
  //       onPressed: () {
  //         print("object ${controller.profileData.value.data?.emailVerified}");
  //         // if (controller.profileData.value.data?.emailVerified != "true") {
  //         //   Utils.showToast("First Verify your Email");
  //         // } else {
  //           // checkValid();
  //           // if (controller.isValid) {
  //           // }
  //           if(controller.formSignUpKey.currentState!.validate() && controller.profileData.value.data?.emailVerified == "true"){
  //             controller.profileupdateApi(type);
  //           }
  //         // }
  //       });
  // }
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
class CommonDropDownItem {
  final String id;
  final String name;

  CommonDropDownItem({required this.id, required this.name});
}

final List<CommonDropDownItem> genderItems = [
  CommonDropDownItem(id: "Male", name: "Male"),
  CommonDropDownItem(id: "Female", name: "Female"),
  CommonDropDownItem(id: "Other", name: "Other"),
];
