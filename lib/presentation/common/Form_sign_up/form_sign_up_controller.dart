import 'dart:io';

import 'package:woye_user/core/utils/app_export.dart';

class FormSignUpController extends GetxController {
  GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();

  bool isLoading = false;

  bool isValid = false;

  final ImagePicker _picker = ImagePicker();
  File? image;

  late TextEditingController fisrtNameController,
      lastNameController,
      dateOfBirthController,
      emailController,
      genderController;

  @override
  void onInit() async {
    fisrtNameController = TextEditingController();
    lastNameController = TextEditingController();
    dateOfBirthController = TextEditingController();
    emailController = TextEditingController();
    genderController = TextEditingController();

    // responseToken = await prefUtils.getToken();
    // responseEmail = await prefUtils.getEmail();
    // debugPrint("responseToken at signUp==============> $responseToken");
    // debugPrint("responseEmail at signUp==============> $responseEmail");
    // networkController.onInit();

    // emailController.text = responseEmail! ?? "";
    super.onInit();
  }

  @override
  void onClose() {
    fisrtNameController.dispose();
    lastNameController.dispose();
    dateOfBirthController.dispose();
    emailController.dispose();
    genderController.dispose();

    super.onClose();
  }

  Future<void> pickImageFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      // isValid = (signupFormKey.currentState!.validate() && image != null);
      update();
    }

    update();
  }

  Future<void> pickImageFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
      // isValid = (signupFormKey.currentState!.validate() && image != null);
      update();
    }
    update();
  }

  String? validateFirstName(String? value) {
    if (value!.isEmpty) {
      return "Please enter a valid Name";
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value!.isEmpty) {
      return "Please enter a valid Name";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isEmpty ||
        !isValidEmail(value, isRequired: true) ||
        value == "") {
      return "Please enter a valid Email";
    }

    return null;
  }

  void checkValid() {
    isValid = (formSignUpKey.currentState!.validate() && image != null);

    update();
  }
}
