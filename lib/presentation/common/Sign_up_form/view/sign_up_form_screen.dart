import 'package:flutter/cupertino.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Sign_up_form/controller/sign_up_form_controller.dart';

class SignUpFormScreen extends StatefulWidget {
  const SignUpFormScreen({super.key});

  static SignUpFormController signUpFormController =
      Get.find<SignUpFormController>();

  @override
  State<SignUpFormScreen> createState() => _SignUpFormScreenState();
}

class _SignUpFormScreenState extends State<SignUpFormScreen> {
  SignUpFormController controller = Get.put(SignUpFormController());

  @override
  void initState() {
    // if (controller.serviceEnabled != true) {
    //   locationRequestPopUp(context);
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (controller.serviceEnabled != true) {
    //     locationRequestPopUp(context);
    //   }
    //   // locationRequestPopUp(context);
    // });
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: REdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            hBox(30),
            //
            form(SignUpFormScreen.signUpFormController, context),
            hBox(20),
            //
            continueButton(),
            hBox(40),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Fill your profile",
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

  Widget form(SignUpFormController signUpFormController, BuildContext context) {
    return Form(
        key: signUpFormController.formSignUpKey,
        onChanged: () {
          signUpFormController.checkValid();
        },
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
              prefix: SvgPicture.asset(
                ImageConstants.profileIcon,
              ),
              prefixConstraints:
                  BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
              hintText: "Mobile Number",
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              validator: signUpFormController.validateLastName,
            ),
            hBox(15),
            // CustomTextFormField(
            //   controller: signUpFormController.dateOfBirthController,
            //   prefix: SvgPicture.asset(
            //     ImageConstants.calendar,
            //   ),
            //   prefixConstraints:
            //       BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
            //   hintText: "Date of birth",
            //   onTapOutside: (event) {
            //     FocusScope.of(context).unfocus();
            //   },
            //   // validator: formSignUpController.validateLastName,
            // ),
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
                        signUpFormController.selectedDate.value == null
                            ? "Date of Birth"
                            : "${signUpFormController.selectedDate.value!.day}/${signUpFormController.selectedDate.value!.month}/${signUpFormController.selectedDate.value!.year}",
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
              // validator: formSignUpController.validateLastName,
            ),
            hBox(15),
            DropdownButtonFormField(
              hint: Text(
                "Gender",
                style: AppFontStyle.text_16_400(AppColors.darkText),
              ),
              style: AppFontStyle.text_16_400(AppColors.darkText),
              icon: SvgPicture.asset(ImageConstants.arrowDown),
              decoration: InputDecoration(
                  contentPadding:
                      REdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
              },
            )
          ],
        ));
  }

  Widget imagePicker(
      BuildContext context, SignUpFormController signUpFormController) {
    return GestureDetector(
      onTap: () {
        bottomSheet(context);
      },
      child: SizedBox(
        height: 140.h,
        child: Stack(
          children: [
            Container(
                width: 120.h,
                height: 120.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    // shape: BoxShape.circle,
                    border: Border.all(
                        color: signUpFormController.image == null
                            ? Colors.red
                            : Colors.transparent)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: signUpFormController.image == null
                      ? CircleAvatar(
                          backgroundColor:
                              AppColors.greyBackground.withOpacity(0.5),
                          child: Icon(
                            Icons.person,
                            size: 60.h,
                            color: AppColors.lightText.withOpacity(0.5),
                          ))
                      : Image.file(
                          signUpFormController.image!,
                          fit: BoxFit.cover,
                        ),
                )),
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
            if (signUpFormController.image == null)
              Positioned(
                  bottom: 0,
                  child: Text(
                    "      Please choose an image",
                    style: TextStyle(color: Colors.red, fontSize: 8.sp),
                  ))
          ],
        ),
      ),
    );
  }

  Widget continueButton() {
    return CustomElevatedButton(
        isLoading:
            SignUpFormScreen.signUpFormController.rxRequestStatus.value ==
                Status.LOADING,
        text: "Continue",
        onPressed: () {
          SignUpFormScreen.signUpFormController.profileupdateApi();
          // Get.offAndToNamed(AppRoutes.restaurantNavbar);
        });
  }

  Future bottomSheet(BuildContext context) {
    final SignUpFormController controller = Get.find<SignUpFormController>();
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
                          controller.pickImageFromCamera();
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
                          controller.pickImageFromGallery();

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
