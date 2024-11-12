import 'dart:io';

import 'package:woye_user/core/utils/app_export.dart';

class ProfileController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  File? image;

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
}
