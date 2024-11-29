import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:woye_user/Data/Model/usermodel.dart';
import 'package:woye_user/Data/Repository/repository.dart';
import 'package:woye_user/Data/response/status.dart';
import 'package:woye_user/Data/userPrefrenceController.dart';
import 'package:woye_user/Routes/app_routes.dart';
import 'package:woye_user/presentation/common/Social_login/social_model.dart';
import '../../../Core/Utils/snackbar.dart';
import '../../../shared/theme/colors.dart';

class SocialLoginController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle(BuildContext context) async {
    showLoading();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print('user crediental -------------$credential');
      print(
          'details------${googleUser?.displayName}---${googleUser?.email}---${googleUser?.photoUrl}---${googleUser?.id}----${googleUser?.serverAuthCode}  ===   ${googleAuth?.accessToken}');
      final datad =
          await FirebaseAuth.instance.signInWithCredential(credential);

      String? displayName = googleUser?.displayName;
      String firstName = '';
      String lastName = '';

      if (displayName != null) {
        List<String> nameParts = displayName.split(' ');
        print(nameParts);
        if (nameParts.length > 1) {
          firstName = nameParts.first;
          lastName = nameParts.sublist(1).join(' ');
        } else {
          firstName = displayName;
        }
      }
      print("Login Details:");
      print("Email: ${googleUser?.email}");
      print("Name: $displayName");
      print("UID: ${googleUser?.id}");
      print("Photo: ${googleUser?.photoUrl}");
      print("Phone: ${datad.user?.phoneNumber ?? 'No phone number available'}");
      print("Phone: ${datad.user?.phoneNumber ?? 'No phone number available'}");
      print(
          "gender: ${datad.additionalUserInfo?.profile ?? 'No phone number available'}");
      String Mobilenumber = "";
      String countryCode = "";
      String? phoneNumber = datad.user?.phoneNumber;
      if (phoneNumber != null) {
        countryCode =
            phoneNumber.substring(0, phoneNumber.indexOf(' ') + 1).trim();
        String phoneNumberWithoutCountryCode =
            phoneNumber.substring(phoneNumber.indexOf(' ') + 1).trim();
        print("Phone Number: $phoneNumberWithoutCountryCode");
        print("Country Code: $countryCode");
        Mobilenumber = phoneNumberWithoutCountryCode;
        countryCode = countryCode;
      } else {
        print("Phone Number: Not available");
      }
      SocialLoginApi(
          email: googleUser!.email.toString(),
          id: googleUser.id.toString(),
          type: "google",
          name: displayName ?? "",
          mobile: Mobilenumber ?? "",
          countryCode: countryCode ?? "");

      // Get.back();
      // Get.offAllNamed(AppRoutes.signUpFom);
    } on FirebaseAuthException catch (e) {
      Get.back();
      print('FirebaseAuthException: ${e.message}');
    } catch (e) {
      Get.back();
      print('error == ${e.toString()}');
      SnackBarUtils.showToast('Login failed. Please try again.');
    }
  }

  Future<void> facebookLogin(BuildContext context) async {
    showLoading();
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        // permissions: ['email'],
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final userData = await FacebookAuth.i.getUserData(
          fields: "name,email",
        );
        final name = userData["name"];
        final email = userData["email"];
        final phone = userData["phone"] ?? "";

        String countryCode = "";
        String phoneNumber = phone;

        if (phone == null) {
          final parts = phone.split(' ');
          if (parts.length > 1) {
            countryCode = parts[0];
            phoneNumber = parts[1];
          }
        }

        print("User Name: $name");
        print("User Email: $email");
        print("User Phone: $phone");
        print("Country Code: $countryCode");
        print("Phone Number: $phoneNumber");

        await SocialLoginApi(
          type: "facebook",
          email: email,
          id: accessToken.userId,
          name: name,
          mobile: phoneNumber,
          countryCode: countryCode,
        );
      } else {
        Get.back();
        print(result.message);
        SnackBarUtils.showToast("${result.message}");
        Get.back();
      }
    } catch (e) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
      print("An error occurred during Facebook login: $e");
      SnackBarUtils.showToast(
          "An error occurred during Facebook login: $e");
      Get.back();
    }
  }

  Future<void> signout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    await FacebookAuth.instance.logOut();
    print("User signed out");
  }

  Future<void> appleLogin(BuildContext context) async {
    showLoading();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print("start");
      print(credential);
      print("email: ${credential.email}");
      print("name: ${credential.givenName}");
      print("name: ${credential.givenName}");
      print("suarname: ${credential.familyName}");
      print("identityToken: ${credential.identityToken}");
      print("authorizationCode: ${credential.authorizationCode}");
      print("userIdentifier:${credential.userIdentifier}");
      print("userIdentifier:${credential.email}");

      await SocialLoginApi(
        type: "google",
        email: credential.email.toString(),
        id: credential.userIdentifier.toString(),
        name: "${credential.givenName ?? ''} ${credential.familyName ?? ''}",
        mobile: "",
        countryCode: "",
      );
    } catch (e) {
      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: ${e.toString()}')),
      );
    }
  }

  final _api = Repository();

  final rxRequestStatus = Status.COMPLETED.obs;
  final socialLoginData = SocialModel().obs;
  RxString error = ''.obs;
  String token = '';

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  void SocialDataSet(SocialModel value) => socialLoginData.value = value;

  void setError(String value) => error.value = value;

  UserModel userModel = UserModel();

  UserPreference userPreference = UserPreference();

  SocialLoginApi({
    required String email,
    required String type,
    required String id,
    required String name,
    required String mobile,
    required String countryCode,
  }) async {
    String? tokenFCM = await FirebaseMessaging.instance.getToken();
    //
    // UserModel userModel = UserModel();
    // var pref = UserPreference();
    // userModel = await pref.getUser();

    Map data = {
      'email': email,
      "fcm_token": tokenFCM.toString(),
      'step': userModel.token.toString() == 2 ? '2' : '1',
      'type': type.toString(),
      'fname': name,
      'mob_no': mobile,
      'country_code': countryCode,
      'dob': "",
      "gender": "",
      'uuid': id,
    };
    print("WWWWWWWWWWWW$data");
    setRxRequestStatus(Status.LOADING);
    _api.SocialLoginApi(data,).then((value) async {
      setRxRequestStatus(Status.COMPLETED);
      SocialDataSet(value);
      if (socialLoginData.value.status == true) {
        print("object ==========  await Analytics.loginEvent");
        // await Analytics.login_event(email, type);
        UserModel userModel = UserModel(
            token: socialLoginData.value.token.toString(),
            isLogin: true,
            loginType: socialLoginData.value.type.toString(),
            step: socialLoginData.value.step);
        userPreference.saveUser(userModel).then((value) {
          Get.delete<SocialModel>();
          Get.back();
          print("objectStep${socialLoginData.value.step}");
          if (socialLoginData.value.step == 1) {
            Get.offAllNamed(AppRoutes.signUpFom);
          }
          if (socialLoginData.value.step == 2) {
            Get.offAllNamed(AppRoutes.restaurantNavbar);
          }
        }).onError((error, stackTrace) {});
      } else {
        SnackBarUtils.showToast(socialLoginData.value.message.toString());
        Get.back();
      }
    }).onError((error, stackTrace) {
      setError(error.toString());
      // Utils.toastMessage("sorry for the inconvenience we will be back soon!!");
      print('errrrrrrrrrrrr');
      print(error);
      print(stackTrace);
      // setRxRequestStatus(Status.ERROR);
      Get.back();
    });
  }

  Future<void> showLoading() async {
    await Get.dialog(
      PopScope(
        canPop: false, // Prevents dialog from being dismissed
        child: Center(
          child: LoadingAnimationWidget.inkDrop(
            color: AppColors.primary,
            size: 30,
          ),
        ),
      ),
      barrierDismissible: false, // Prevents user from dismissing the dialog
    );
  }
}
