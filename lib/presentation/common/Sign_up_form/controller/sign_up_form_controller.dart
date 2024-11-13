import 'dart:developer';
import 'dart:io';

import 'package:location/location.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/network/network_api_services.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Sign_up_form/Model/getprofile_model.dart';
import 'package:woye_user/presentation/common/Sign_up_form/Model/updateprofile_model.dart';

class SignUpFormController extends GetxController {
  GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();

  final api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final profileData = ProfileModel().obs;
  final updateprofileData = UpdateprofileModel().obs;
  RxString error = ''.obs;
  UserModel userModel = UserModel();
  Location location = Location();
  bool? serviceEnabled;
  LocationData? locationData;

  var pref = UserPreference();

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;
  void profileSet(ProfileModel _value) => profileData.value = _value;
  void upprofileSet(UpdateprofileModel _value) =>
      updateprofileData.value = _value;
  void setError(String _value) => error.value = _value;

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

  final ImagePicker _picker = ImagePicker();
  File? image;

  late TextEditingController fisrtNameController,
      mobileController,
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
      countryCode = args["countryCode"] ??
          ""; // Provide a default value, e.g., empty string
      mob = args["mob"] ?? ""; // Provide a default value, e.g., empty string
    } else {
      // Handle the case where arguments are missing
      countryCode = "";
      mob = "";
      log("Warning: Arguments for countryCode and mob are missing.");
    }

    fisrtNameController = TextEditingController();
    mobileController = TextEditingController();
    dateOfBirthController = TextEditingController();
    emailController = TextEditingController();
    genderController = TextEditingController();

    // responseToken = await prefUtils.getToken();
    // responseEmail = await prefUtils.getEmail();
    // debugPrint("responseToken at signUp==============> $responseToken");
    // debugPrint("responseEmail at signUp==============> $responseEmail");
    // networkController.onInit();

    // emailController.text = responseEmail! ?? "";
    checkLocation();
    getprofileApi();
    super.onInit();
  }

  void checkLocation() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled!) {
      serviceEnabled = await location.requestService();
    }
    if (!serviceEnabled!) {
      debugPrint("location====================> location denied");
    }
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

  profileupdateApi() async {
    final data = {
      "first_name": fisrtNameController.text.toString(),
      "phone": mobileController.text.trim().toString(),
      "dob": dateOfBirthController.text.trim().toString(),
      "email": emailController.text.trim().toString(),
      "gender": genderController.text.toString(),
    };

    log(data.toString());

    log("update profile");

    userModel = await pref.getUser();

    log("get header : ${userModel.token.toString()}");

    setRxRequestStatus(Status.LOADING);

    api.updateprofileApi(data, userModel.token.toString()).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      upprofileSet(value);

      if (updateprofileData.value.status == true) {
        userModel.step = updateprofileData.value.step;
        log("get Response Step: ${userModel.step}");
        Get.offAllNamed(AppRoutes.restaurantNavbar);
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  getprofileApi() async {
    log("get profile");

    userModel = await pref.getUser();

    log("get header : ${userModel.token.toString()}");

    setRxRequestStatus(Status.LOADING);

    api.getprofileApi(userModel.token.toString()).then((value) {
      setRxRequestStatus(Status.COMPLETED);
      profileSet(value);

      if (profileData.value.status == true) {
        userModel.step = profileData.value.step;
        log("get Response Step: ${userModel.step}");
        mobileController.text = profileData.value.data!.phone.toString();
        log("get Response phone: ${mobileController}");
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }
}
