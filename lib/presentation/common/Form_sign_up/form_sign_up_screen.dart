import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/Common/form_sign_up/form_sign_up_controller.dart';
import 'package:woye_user/shared/widgets/custom_app_bar.dart';

class FormSignUpScreen extends StatelessWidget {
  const FormSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormSignUpController>(
        init: FormSignUpController(),
        builder: (formSignUpController) {
          return Scaffold(
            appBar: const CustomAppBar(),
            body: SingleChildScrollView(
              padding: REdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Fill your profile",
                    style: AppFontStyle.text_40_600(AppColors.darkText),
                  ),
                  hBox(24),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                    style: AppFontStyle.text_16_400(AppColors.lightText),
                  ),
                  hBox(30),
                  form(formSignUpController, context),
                  hBox(20),
                  CustomElevatedButton(
                      text: "Continue",
                      onPressed: () {
                        Get.toNamed(AppRoutes.restaurantNavbar);
                      }),
                  hBox(40),
                ],
              ),
            ),
          );
        });
  }

  Form form(FormSignUpController formSignUpController, BuildContext context) {
    return Form(
        key: formSignUpController.formSignUpKey,
        onChanged: () {
          formSignUpController.checkValid();
        },
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: imagePicker(context, formSignUpController),
            ),
            hBox(30),
            CustomTextFormField(
              alignment: Alignment.center,
              controller: formSignUpController.fisrtNameController,
              prefix: SvgPicture.asset(
                ImageConstants.profileIcon,
              ),
              prefixConstraints:
                  BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
              hintText: "First name",
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              validator: formSignUpController.validateFirstName,
            ),
            hBox(15),
            CustomTextFormField(
              controller: formSignUpController.lastNameController,
              prefix: SvgPicture.asset(
                ImageConstants.profileIcon,
              ),
              prefixConstraints:
                  BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
              hintText: "Last name",
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              validator: formSignUpController.validateLastName,
            ),
            hBox(15),
            CustomTextFormField(
              controller: formSignUpController.dateOfBirthController,
              prefix: SvgPicture.asset(
                ImageConstants.calendar,
              ),
              prefixConstraints:
                  BoxConstraints(maxHeight: 18.h, minWidth: 48.h),
              hintText: "Date of birth",
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              // validator: formSignUpController.validateLastName,
            ),
            hBox(15),
            CustomTextFormField(
              controller: formSignUpController.emailController,
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
                formSignUpController.genderController.text = value.toString();
              },
            )
          ],
        ));
  }

  Widget imagePicker(
      BuildContext context, FormSignUpController formSignUpController) {
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
                        color: formSignUpController.image == null
                            ? Colors.red
                            : Colors.transparent)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: formSignUpController.image == null
                      ? CircleAvatar(
                          backgroundColor:
                              AppColors.greyBackground.withOpacity(0.5),
                          child: Icon(
                            Icons.person,
                            size: 60.h,
                            color: AppColors.lightText.withOpacity(0.5),
                          ))
                      : Image.file(
                          formSignUpController.image!,
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
            if (formSignUpController.image == null)
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

  Future bottomSheet(BuildContext context) {
    final FormSignUpController controller = Get.find<FormSignUpController>();
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
