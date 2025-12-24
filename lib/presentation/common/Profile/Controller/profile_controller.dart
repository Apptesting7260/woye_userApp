import 'dart:io';

import 'package:woye_user/Data/app_exceptions.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Profile/model/logout_model.dart';

import '../../../../Data/network/network_api_services.dart' show NetworkApiServices;

class ProfileController extends GetxController {

  final api = Repository();
  final apiService = NetworkApiServices();
  final rxRequestStatus = Status.COMPLETED.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

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

  Future<void> logoutUser() async {
    try {
      setRxRequestStatus(Status.LOADING);
      LogoutModel response = await api.logoutUserApi();

      if (response.status == true) {
        // Clear user data from preferences
        await userPreference.removeUser();

        // Clear any other controllers if needed
        // For example:
        // Get.find<GetUserDataController>().clearData();
        // Get.find<SocialLoginController>().signout();

        setRxRequestStatus(Status.COMPLETED);

        Get.snackbar(
          'Success',
          response.message ?? 'Logged out successfully',
          snackPosition: SnackPosition.BOTTOM,
        );

        // Navigate to welcome screen
        Get.offAllNamed(AppRoutes.welcomeScreen);
      } else {
        setRxRequestStatus(Status.COMPLETED);
        Get.snackbar(
          'Error',
          response.message ?? 'Logout failed',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      setRxRequestStatus(Status.ERROR);
      Get.snackbar(
        'Error',
        'Something went wrong: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
