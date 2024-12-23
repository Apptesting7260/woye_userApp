// import 'package:flutter/services.dart';
// import 'package:woye_user/Core/Utils/app_export.dart';
// import 'package:woye_user/presentation/common/Profile/Sub_screens/Edit_profile/edit_profile_controller.dart';
//
//
// class EditProfileScreen extends StatelessWidget {
//   const EditProfileScreen({super.key});
//
//   static final EditProfileController controller =
//       Get.put(EditProfileController(), permanent: true);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         isLeading: true,
//         title: Text(
//           "My Profile",
//           style: AppFontStyle.text_22_600(AppColors.darkText),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: REdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           children: [
//             imagePicker(context, controller),
//             hBox(30),
//             profileDetails(),
//             hBox(20),
//             saveButton()
//             // hBox(30),
//             // profileOptions(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget imagePicker(BuildContext context, EditProfileController controller) {
//     return GestureDetector(
//       onTap: () {
//         bottomSheet(context);
//       },
//       child: GetBuilder(
//           init: controller,
//           builder: (context) {
//             return SizedBox(
//               height: 100.h,
//               child: Stack(
//                 children: [
//                   Container(
//                       width: 100.h,
//                       height: 100.h,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100.r),
//                           // shape: BoxShape.circle,
//                           border: Border.all(
//                               color: controller.image == null
//                                   ? Colors.transparent
//                                   : Colors.transparent)),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(100.r),
//                         child: controller.image == null
//                             ? CircleAvatar(
//                                 backgroundColor:
//                                     AppColors.greyBackground.withOpacity(0.5),
//                                 child: Icon(
//                                   Icons.person,
//                                   size: 60.h,
//                                   color: AppColors.lightText.withOpacity(0.5),
//                                 ))
//                             : Image.file(
//                                 controller.image!,
//                                 fit: BoxFit.cover,
//                               ),
//                       )),
//                   Positioned(
//                     bottom: 6.h,
//                     right: 4.w,
//                     child: Container(
//                       padding: EdgeInsets.all(4.r),
//                       decoration: BoxDecoration(
//                           color: AppColors.primary,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: AppColors.primary)),
//                       child: Icon(
//                         Icons.photo_camera,
//                         color: Colors.white,
//                         size: 14.h,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
//
//   Widget profileDetails() {
//     return Column(
//       children: [
//         CustomTextFormField(
//             contentPadding: REdgeInsets.symmetric(horizontal: 20, vertical: 18),
//             hintText: "First Name",
//             prefix: Padding(
//               padding: REdgeInsets.only(left: 20, right: 14),
//               child: SvgPicture.asset(
//                 "assets/svg/person-icon.svg",
//                 height: 16.h,
//               ),
//             )),
//         hBox(15),
//         CustomTextFormField(
//             contentPadding: REdgeInsets.symmetric(horizontal: 20, vertical: 18),
//             hintText: "Last Name",
//             prefix: Padding(
//               padding: REdgeInsets.only(left: 20, right: 14),
//               child: SvgPicture.asset(
//                 "assets/svg/person-icon.svg",
//                 height: 16.h,
//               ),
//             )),
//         hBox(15),
//         CustomTextFormField(
//             contentPadding: REdgeInsets.symmetric(horizontal: 20, vertical: 18),
//             hintText: "Date Of Birth",
//             prefix: Padding(
//               padding: REdgeInsets.only(left: 20, right: 14),
//               child: SvgPicture.asset(
//                 "assets/svg/calendar.svg",
//                 height: 16.h,
//               ),
//             )),
//         hBox(15),
//         CustomTextFormField(
//             contentPadding: REdgeInsets.symmetric(horizontal: 20, vertical: 18),
//             hintText: "Email",
//             prefix: Padding(
//               padding: REdgeInsets.only(left: 20, right: 14),
//               child: SvgPicture.asset(
//                 "assets/svg/email.svg",
//                 height: 16.h,
//               ),
//             )),
//         hBox(15),
//         DropdownButtonFormField(
//           hint: Text(
//             "Gender",
//             style: AppFontStyle.text_14_400(AppColors.darkText),
//           ),
//           style: AppFontStyle.text_14_400(AppColors.darkText),
//           icon: SvgPicture.asset(ImageConstants.arrowDown),
//           decoration: InputDecoration(
//               contentPadding:
//                   REdgeInsets.symmetric(horizontal: 20, vertical: 18),
//               focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: AppColors.textFieldBorder),
//                   borderRadius: BorderRadius.circular(15.r)),
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: AppColors.textFieldBorder),
//                   borderRadius: BorderRadius.circular(15.r))),
//           items: ["Male", "Female", "Other"]
//               .map((element) => DropdownMenuItem(
//                   value: element.toString(), child: Text(element.toString())))
//               .toList(),
//           onChanged: (value) {
//             // signUpFormController.genderController.text = value.toString();
//           },
//         ),
//         hBox(15),
//         CustomTextFormField(
//           controller: controller.mobNoCon!.value,
//           inputFormatters: [
//             FilteringTextInputFormatter.digitsOnly,
//           ],
//           prefixConstraints: const BoxConstraints(maxWidth: 100),
//           prefix: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CountryCodePicker(
//                   showFlag: false,
//                   padding: REdgeInsets.symmetric(horizontal: 0, vertical: 9),
//                   onChanged: (CountryCode countryCode) {
//                     controller.updateCountryCode(countryCode);
//                     controller.showError.value = false;
//                     int? countrylength = controller
//                         .countryPhoneDigits[countryCode.code.toString()];
//                     controller.checkCountryLength = countrylength!;
//                   },
//                   initialSelection: "IN"),
//               const Icon(Icons.keyboard_arrow_down_rounded),
//               wBox(5),
//             ],
//           ),
//           hintText: "Phone Number",
//           textInputType: TextInputType.phone,
//         ),
//       ],
//     );
//   }
//
//   Widget saveButton() {
//     return CustomElevatedButton(
//       onPressed: () {
//         Get.back();
//       },
//       text: "Save",
//     );
//   }
//
//   Future bottomSheet(BuildContext context) {
//     final EditProfileController controller = Get.find<EditProfileController>();
//     return showModalBottomSheet(
//         backgroundColor: Colors.white,
//         shape: OutlineInputBorder(
//           borderSide: const BorderSide(width: 0, color: Colors.transparent),
//           gapPadding: 0,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
//         ),
//         showDragHandle: true,
//         constraints: BoxConstraints(maxHeight: 218.h),
//         elevation: 12.w,
//         context: context,
//         builder: (context) {
//           return Container(
//             decoration: BoxDecoration(
//               boxShadow: [
//                 BoxShadow(
//                     color: AppColors.primary.withOpacity(0.2),
//                     blurRadius: 5,
//                     blurStyle: BlurStyle.outer)
//               ],
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30.r),
//                   topRight: Radius.circular(30.r)),
//               color: Colors.white,
//               // gradient: LinearGradient(
//               //     colors: [Colors.white, AppColors.primary.withOpacity(0.05)],
//               //     begin: Alignment.topCenter,
//               //     end: Alignment.bottomCenter),
//             ),
//             child: Padding(
//               padding: REdgeInsets.all(12.0),
//               child: Column(
//                 children: [
//                   Text("Pick an Image",
//                       style: GoogleFonts.poppins(
//                         textStyle:
//                             AppFontStyle.text_18_400(AppColors.mediumText),
//                       )),
//                   hBox(18),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           controller.pickImageFromCamera();
//                           // _pickImageFromCamera();
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           padding: REdgeInsets.all(10.h),
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                   color: AppColors.primary.withOpacity(0.2),
//                                   blurRadius: 5,
//                                   blurStyle: BlurStyle.outer)
//                             ],
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(8.r)),
//                             color: Colors.white,
//                           ),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.photo_camera_outlined,
//                                 color: AppColors.lightText,
//                                 size: 24.h,
//                               ),
//                               Text(
//                                 "Camera",
//                                 style: AppFontStyle.text_16_400(
//                                     AppColors.lightText),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           controller.pickImageFromGallery();
//
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           padding: REdgeInsets.all(10.h),
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                   color: AppColors.primary.withOpacity(0.2),
//                                   blurRadius: 5,
//                                   blurStyle: BlurStyle.outer)
//                             ],
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(8.r)),
//                             color: Colors.white,
//                           ),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.photo_library_outlined,
//                                 color: AppColors.lightText,
//                                 size: 24.h,
//                               ),
//                               Text(
//                                 "Gallery",
//                                 style: AppFontStyle.text_16_400(
//                                     AppColors.lightText),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
