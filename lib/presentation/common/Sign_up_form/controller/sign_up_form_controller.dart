import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:woye_user/Core/Constant/app_urls.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/core/utils/app_export.dart';
import 'package:woye_user/presentation/common/Sign_up_form/Model/getprofile_model.dart';
import 'package:woye_user/presentation/common/Sign_up_form/Model/updateprofile_model.dart';

class SignUpFormController extends GetxController {
  @override
  void onInit() async {
    // Retrieve the arguments and provide fallback values if necessary
    // var args = Get.arguments;
    // if (args != null && args is Map<String, dynamic>) {
    //   countryCode = args["countryCode"] ?? "";
    //   mob = args["mob"] ?? "";
    // } else {
    //   // Handle the case where arguments are missing
    //   countryCode = "";
    //   mob = "";
    //   log("Warning: Arguments for countryCode and mob are missing.");
    // }

    fisrtNameController = TextEditingController();
    mobileController = TextEditingController();
    emailController = TextEditingController();
    genderController = TextEditingController();

    getprofileApi();
    super.onInit();
  }

  final api = Repository();

  final rxRequestStatus = Status.LOADING.obs;
  final profileData = ProfileModel().obs;
  final updateprofileData = UpdateprofileModel().obs;
  RxString error = ''.obs;
  UserModel userModel = UserModel();
  Location location = Location();
  var pref = UserPreference();

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void profileSet(ProfileModel value) => profileData.value = value;

  void upprofileSet(UpdateprofileModel value) =>
      updateprofileData.value = value;

  void setError(String value) => error.value = value;

  var profileImageFromAPI = "".obs;

  getprofileApi() async {
    log("get profile");

    userModel = await pref.getUser();

    log("get header : ${userModel.token.toString()}");

    setRxRequestStatus(Status.LOADING);

    api.getprofileApi().then((value) {
      setRxRequestStatus(Status.COMPLETED);
      profileSet(value);

      if (profileData.value.status == true) {
        userModel.step = profileData.value.step;
        log("get Response Step: ${userModel.step}");
        mobileController.text = profileData.value.data?.phone ?? "";
        emailController.text = profileData.value.data?.email ?? "";
        fisrtNameController.text = profileData.value.data?.firstName ?? "";
        formattedCurrentDate.value = profileData.value.data?.dob ?? "";
        genderController.text = profileData.value.data?.gender ?? "";
        profileImageFromAPI.value = profileData.value.data?.imageUrl ?? "";

        log("get Response phone: ${profileData.value.data?.gender}");
        log("get Response phone: ${genderController.text}");
      }
    }).onError((error, stackError) {
      setError(error.toString());
      print('errrrrrrrrrrrr');
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print(error);
      setRxRequestStatus(Status.ERROR);
    });
  }

  late DateTime selectedDate = DateTime.now();
  RxString formattedCurrentDate = "".obs;

  Future<void> selectDate(BuildContext context) async {
    final DateTime initialDate =
        (selectedDate != null && selectedDate!.isBefore(DateTime(2015, 12, 31)))
            ? selectedDate
            : DateTime(2015, 12, 31);

    final DateTime? picked = await showDatePicker(
      context: context,
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        child: child!,
      ),
      initialDate: initialDate,
      firstDate: DateTime(1990, 1, 1),
      lastDate: DateTime(2015, 12, 31),
    );

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      formattedCurrentDate.value =
          DateFormat('dd-MM-yyyy').format(selectedDate!);

      print("Formatted Selected Date: ${formattedCurrentDate.value}");
    }
  }

  late TextEditingController fisrtNameController,
      mobileController,
      emailController,
      genderController;

  GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();
  bool isValid = false;

  String? validateFirstName(String? value) {
    if (value!.isEmpty) {
      return "Please enter a valid Name";
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value!.isEmpty) {
      return "Please enter your mobile number";
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

  String? validateGender(String? value) {
    if (value!.isEmpty) {
      return "Please Select Gender";
    }
    return null;
  }

  final rxRequestStatus2 = Status.COMPLETED.obs;

  var profileImageGetUrl = "".obs;

  Rx<File> image = File("assets/appLogo.png").obs;

  Future<void> pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      // Get the original image file
      File originalImage = File(pickedImage.path);

      // You can print the size of the original image if needed
      int originalSize = await originalImage.length();
      print('Original image size: $originalSize bytes');

      // No compression, just use the selected image directly
      image.value = originalImage;

      // Upload or further process the image if necessary
      profileImageGetUrl.value = image.value.path;
      print("Path ---> ${image.value.path}");
    }
  }

  profileupdateApi() async {
    rxRequestStatus2(Status.LOADING);
    final data = {
      "first_name": fisrtNameController.text.toString(),
      "phone": mobileController.text.trim().toString(),
      "dob": formattedCurrentDate.value,
      "email": emailController.text.trim().toString(),
      "gender": genderController.text.toString(),
    };

    var uri = Uri.parse(AppUrls.updateProfile);
    var request = http.MultipartRequest('POST', uri);

    data.forEach((key, value) {
      request.fields[key] = value;
    });
    request.headers['Authorization'] = 'Bearer ${userModel.token.toString()}';
    print("userModel.token.toString()${userModel.token.toString()}");
    if (profileImageGetUrl.value != "") {
      var pic = await http.MultipartFile.fromPath("image", image.value.path);

      request.files.add(pic);
      print("hhhhhhhhhhhhhhhh${image.value.path}");
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // var responseBody = await response.stream.bytesToString();
        // var responseData = json.decode(responseBody);
        // log('Profile update success: $responseData');
        // upprofileSet(responseData);

        var responseBody = await response.stream.bytesToString();
        var responseData = json.decode(responseBody);

        UpdateprofileModel profileData =
            UpdateprofileModel.fromJson(responseData);

        log('Profile update success: $profileData');
        upprofileSet(profileData);

        if (updateprofileData.value.status == true) {
          userModel.step = updateprofileData.value.step;
          log("get Response Step: ${userModel.step}");
          pref.saveStep(userModel.step!);
          rxRequestStatus2(Status.COMPLETED);
          // Get.offAllNamed(AppRoutes.restaurantNavbar);
        }
      } else {
        log('Failed to update profile. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      log('Error occurred: $error');
      setError(error.toString());
      rxRequestStatus2(Status.ERROR);
    }
  }
}
