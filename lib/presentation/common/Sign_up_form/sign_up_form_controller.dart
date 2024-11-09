import 'dart:developer';
import 'dart:io';

import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/network/network_api_services.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Sign_up_form/updateprofile_model.dart';

class SignUpFormController extends GetxController {
  GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  // Method to show the date picker
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
    }
  }

  bool isLoading = false;

  bool isValid = false;

  var proVerify = false.obs;
  final apiService = NetworkApiServices();
  UserModel userModel = UserModel();

  final ImagePicker _picker = ImagePicker();
  File? image;

  late TextEditingController fisrtNameController,
      lastNameController,
      dateOfBirthController,
      emailController,
      genderController;

  late String countryCode;
  late String mob;


  @override
  void onInit() async {
    // Retrieve the arguments and provide fallback values if necessary
    var args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      countryCode = args["countryCode"] ?? ""; // Provide a default value, e.g., empty string
      mob = args["mob"] ?? "";                 // Provide a default value, e.g., empty string
    } else {
      // Handle the case where arguments are missing
      countryCode = "";
      mob = "";
      log("Warning: Arguments for countryCode and mob are missing.");
    }

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

  // @override
  // void onClose() {
  //   fisrtNameController.dispose();
  //   lastNameController.dispose();
  //   dateOfBirthController.dispose();
  //   emailController.dispose();
  //   genderController.dispose();
  //
  //   super.onClose();
  // }

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

  Future<void> profileupdateApi() async {

    final data = {
      "first_name": fisrtNameController.text.toString(),
      "phone": mob,
      "dob": dateOfBirthController,
      "email": emailController.text.trim().toString(),
      "gender": genderController.text.toString(),
      "country_code": countryCode,
    };

    log(data.toString());

    final header = userModel.token;

    try {
      proVerify.value = true;
      var response = await apiService.postApi(data, AppUrls.updateProfile, header!);

      if (response != null && response is Map<String, dynamic>) {
        // Parse the response into the RegisterModel
        UpdateprofileModel updateprofileModel = UpdateprofileModel.fromJson(response);

        log("Response: ${updateprofileModel.message}");

        // Check if the status is true
        if (updateprofileModel.status == true) {
          userModel.step = updateprofileModel.step;
          log("Response Step: ${userModel.step}");
          Get.toNamed(AppRoutes.restaurantNavbar);
        }
      }


    } catch (e) {
      proVerify.value = false;
      log("Errors: $e");

    }

  }


}
